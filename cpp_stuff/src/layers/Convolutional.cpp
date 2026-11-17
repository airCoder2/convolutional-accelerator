#include "Convolutional.h"

#include <iostream>
#include <algorithm>

#include "../Types.h"
#include "../Utils.h"
#include "Layer.h"
#include "./config.h"

// NEW STUFF BEGIN

#include <sstream>
#include <vector>
#include <fstream>
#include <filesystem>

#include "../Config.h"


#ifdef ZEDBOARD
#include <xil_io.h>
#include <xaxicdma_hw.h>
#include <xil_cache.h>
#include <xparameters.h>
#endif

namespace ML
{


} 

using namespace ML;

#define MLP_BRAM_BASEADDR (0x40000000)
#define MLP_CONV_BASEADDR (0x4C000000)

#define MLP_INPUTS  ((ui8*)MLP_BRAM_BASEADDR + (0 << 17))
#define MLP_OUTPUTS ((ui8*)MLP_BRAM_BASEADDR + (1 << 17))
#define MLP_FILTER0 ((ui8*)MLP_BRAM_BASEADDR + (1 << 18) + (0 << 11))
#define MLP_FILTER1 ((ui8*)MLP_BRAM_BASEADDR + (1 << 18) + (1 << 11))
#define MLP_FILTER2 ((ui8*)MLP_BRAM_BASEADDR + (1 << 18) + (2 << 11))
#define MLP_FILTER3 ((ui8*)MLP_BRAM_BASEADDR + (1 << 18) + (3 << 11))

#define MLP_CONV_IDLE_REG               (MLP_CONV_BASEADDR + 0x00)
#define MLP_CONV_IDLE_ON_MASK           (1 << 0)
#define MLP_CONV_IDLE_OFF_MASK          (0 << 0)

#define MLP_CTRL                       (MLP_CONV_BASEADDR + 0x04)
#define MLP_CTRL_SWAP_FILTERS          (1 << 0)
#define MLP_CTRL_SWAP_ACTIVATIONS      (1 << 1)
#define MLP_CTRL_MAX_POOLING           (1 << 2)
#define MLP_CTRL_RELU                  (1 << 3)
// #define MLP_RESERVED                   (MLP_CONV_BASEADDR + 0x08)
#define MLP_FILTER_W                    (MLP_CONV_BASEADDR + 0x0C)
#define MLP_FILTER_H                    (MLP_CONV_BASEADDR + 0x10)
#define MLP_FILTER_C                    (MLP_CONV_BASEADDR + 0x14)
#define MLP_OUTPUT_W                    (MLP_CONV_BASEADDR + 0x18)
#define MLP_OUTPUT_H                    (MLP_CONV_BASEADDR + 0x1C)
#define MLP_INPUT_END_DIFF_FW           (MLP_CONV_BASEADDR + 0x20)
#define MLP_INPUT_END_DIFF_FH           (MLP_CONV_BASEADDR + 0x24)
#define MLP_INPUT_END_DIFF_FC           (MLP_CONV_BASEADDR + 0x28)
#define MLP_INPUT_END_DIFF_OW           (MLP_CONV_BASEADDR + 0x2C)
#define MLP_OUTPUT_ELEMENTS_PER_CHANNEL (MLP_CONV_BASEADDR + 0x30)
#define MLP_OUTPUT_INITIAL_OFFSET       (MLP_CONV_BASEADDR + 0x34)
#define MLP_MAC0_BIAS                   (MLP_CONV_BASEADDR + 0x38)
#define MLP_MAC1_BIAS                   (MLP_CONV_BASEADDR + 0x3C)
#define MLP_MAC2_BIAS                   (MLP_CONV_BASEADDR + 0x40)
#define MLP_MAC3_BIAS                   (MLP_CONV_BASEADDR + 0x44)
#define MLP_Q_SCALE                     (MLP_CONV_BASEADDR + 0x48)
#define MLP_Q_ZERO                      (MLP_CONV_BASEADDR + 0x4C)

static inline void memcpy_dma_start(void* dest, const void* src, ui32 len) {
    // std::cout << "MEMCPY FROM " << src << " TO " << dest << " OF LENGTH " << len << '\n';
    Xil_Out32(XPAR_AXI_CDMA_0_BASEADDR + XAXICDMA_DSTADDR_OFFSET, (ui32)dest);
    Xil_Out32(XPAR_AXI_CDMA_0_BASEADDR + XAXICDMA_SRCADDR_OFFSET, (ui32)src);
    Xil_Out32(XPAR_AXI_CDMA_0_BASEADDR + XAXICDMA_BTT_OFFSET, len); // len is the number of bytes
    // volatile ui8* udest = (volatile ui8*)dest;
    // volatile ui8* usrc = (volatile ui8*)src;
    // volatile ui8* end = udest + len;
    // while (udest != end)
    //     *udest++ = *usrc++;
}

static inline bool memcpy_dma_idle() {
    return !!(Xil_In32(XPAR_AXI_CDMA_0_BASEADDR + XAXICDMA_SR_OFFSET) & XAXICDMA_SR_IDLE_MASK);
}

static inline void memcpy_dma(void* dest, const void* src, ui32 len) {
    memcpy_dma_start(dest, src, len);
    while (!memcpy_dma_idle());
}

static inline void memcheck_write(void* baseaddr, ui32 length, ui32 seed) {
    ui32* data = (ui32*)malloc(length);
    ui32 word = seed;
    // oh I see, so it just does it like a word, rather than a byte. I guess that works
    // So we have to read it the same way as well then. But yeah, perfectly fine
    for (ui32 i = 0; i < length/4; i++) {
        data[i] = word++;
    }
    memcpy_dma(baseaddr, data, length);
    free(data);
}

static inline bool memcheck_verify(void* baseaddr, ui32 length, ui32 seed) {
    ui32* data = (ui32*)malloc(length);
    memcpy_dma(data, baseaddr, length);

    ui32 word = seed;
    for (ui32 i = 0; i < length/4; i++) {
        ui32 expected = word++;
        ui32 actual = data[i];
        if (actual != expected) {
            std::cout << "Address " << std::hex << i << " incorrect. Expected: " << expected << " actual: " << actual << std::dec << '\n';
            free(data);
            return false;
        }
    }
    free(data);
    std::cout << "MEMCHECK of " << std::hex << baseaddr << std::dec << " complete!" << '\n';
    return true;
}

static inline void memcheck(void* dest, const void* src, ui32 len) {
    ui8* data = (ui8*)malloc(len);
    memcpy_dma(data, dest, len);

    for (ui32 i = 0; i < len; i++) {
        u8 expected = ((ui8*)src)[i];
        u8 actual = data[i];
        if (actual != expected) {
            std::cout << "Address " << std::hex << i << " incorrect. Expected: " << (int)expected << " actual: " << (int)actual << std::dec << '\n';
            free(data);
            return;
        }
    }
    std::cout << "MEMCHECK of " << std::hex << dest << std::dec << " complete!" << '\n';
}

static inline void runMemoryTest() {
    Xil_DCacheDisable();
    std::cout << "Starting DMA Transfer Test!\n";
    memcheck_write(MLP_INPUTS, (1 << 17), 14);
    memcheck_write(MLP_OUTPUTS, (1 << 17), 15);
    memcheck_verify(MLP_INPUTS, (1 << 17), 14);
    memcheck_verify(MLP_OUTPUTS, (1 << 17), 15);

    std::cout << "Write to bank 0\n";
    memcheck_write(MLP_FILTER0, (1 << 11), 10);
    memcheck_write(MLP_FILTER1, (1 << 11), 11);
    memcheck_write(MLP_FILTER2, (1 << 11), 12);
    memcheck_write(MLP_FILTER3, (1 << 11), 13);

    std::cout << "Swapping filter banks 1\n";
    Xil_Out32(MLP_CTRL, MLP_CTRL_SWAP_FILTERS); // Swap filter banks

    std::cout << "Write to bank 1\n";
    memcheck_write(MLP_FILTER0, (1 << 11), 20);
    memcheck_write(MLP_FILTER1, (1 << 11), 21);
    memcheck_write(MLP_FILTER2, (1 << 11), 22);
    memcheck_write(MLP_FILTER3, (1 << 11), 23);
    memcheck_verify(MLP_INPUTS, (1 << 17), 14);
    memcheck_verify(MLP_OUTPUTS, (1 << 17), 15);

    std::cout << "Verify bank 1\n";
    memcheck_verify(MLP_FILTER0, (1 << 11), 20);
    memcheck_verify(MLP_FILTER1, (1 << 11), 21);
    memcheck_verify(MLP_FILTER2, (1 << 11), 22);
    memcheck_verify(MLP_FILTER3, (1 << 11), 23);

    std::cout << "Verify bank 0\n";
    Xil_Out32(MLP_CTRL, MLP_CTRL_SWAP_ACTIVATIONS); // Swap banks back
    memcheck_verify(MLP_FILTER0, (1 << 11), 10);
    memcheck_verify(MLP_FILTER1, (1 << 11), 11);
    memcheck_verify(MLP_FILTER2, (1 << 11), 12);
    memcheck_verify(MLP_FILTER3, (1 << 11), 13);
    memcheck_verify(MLP_INPUTS, (1 << 17), 15);
    memcheck_verify(MLP_OUTPUTS, (1 << 17), 14);
}




// NEW STUFF END

#define CHANNEL_NUM_TO_COMPUTE_AT_ONCE 4

namespace ML
{
    // --- Begin Student Code ---

    inline size_t get_kernel_flat_idx(size_t height_idx, size_t width_idx, size_t depth_idx, size_t batch_idx, size_t kernel_w, size_t kernel_d, size_t kernel_b){
        return kernel_w * kernel_d * kernel_b * height_idx + kernel_d * kernel_b * width_idx + kernel_b * depth_idx + batch_idx;
    }

    inline size_t get_image_flat_idx(size_t height_idx, size_t width_idx, size_t depth_idx, size_t image_w, size_t image_d){
        return image_w * image_d * height_idx + image_d * width_idx + depth_idx;
    }

    inline size_t get_out_flat_idx(size_t height_idx, size_t width_idx, size_t batch_idx, size_t out_w, size_t out_d){
        return out_w * out_d * height_idx + out_d * width_idx + batch_idx;
    }

    inline size_t get_kernel_flat_idx_rm(size_t height_idx, size_t width_idx, size_t depth_idx, size_t batch_idx, size_t kernel_w, size_t kernel_d, size_t kernel_h){
        //return kernel_w * kernel_d * kernel_b * height_idx + kernel_d * kernel_b * width_idx + kernel_b * depth_idx + batch_idx;
        return (batch_idx * kernel_d * kernel_w * kernel_h + depth_idx * kernel_w * kernel_h + width_idx * kernel_h + height_idx);
    }

    inline size_t get_kernel_flat_idx_cm(size_t height_idx, size_t width_idx, size_t depth_idx, size_t batch_idx, size_t kernel_w, size_t kernel_d, size_t kernel_h){
        //return kernel_w * kernel_d * kernel_b * height_idx + kernel_d * kernel_b * width_idx + kernel_b * depth_idx + batch_idx;
        return (batch_idx * kernel_d * kernel_w * kernel_h + depth_idx * kernel_w * kernel_h + height_idx * kernel_w + width_idx);
    }


    inline size_t get_out_flat_idx_cm(size_t height_idx, size_t width_idx, size_t depth_idx, size_t out_w, size_t out_h){
        return out_w * out_h * depth_idx + out_w * height_idx + width_idx;
    }

    inline size_t get_image_flat_idx_cm(size_t height_idx, size_t width_idx, size_t depth_idx, size_t img_w, size_t img_h){
        //return kernel_w * kernel_d * kernel_b * height_idx + kernel_d * kernel_b * width_idx + kernel_b * depth_idx + batch_idx;
        return (depth_idx * img_w * img_h + height_idx * img_w + width_idx);
    }

    // Compute the convultion for the layer data
    // ME: the LayerData object passed has been loaded before (by img.loadData() no need to do it again)
    void ConvolutionalLayer::computeNaive(const LayerData &dataIn, const int layer_num) const
    {
        // {64, 64, 3}
        size_t image_h = getInputParams().dims[0];
        size_t image_w = getInputParams().dims[1];
        size_t image_d = getInputParams().dims[2];

        // {60, 60, 32}
        size_t out_h = getOutputParams().dims[0];
        size_t out_w = getOutputParams().dims[1];

        // {5, 5, 3, 32}
        size_t kernel_h = getWeightParams().dims[0];
        size_t kernel_w = getWeightParams().dims[1];
        size_t kernel_d = getWeightParams().dims[2];
        size_t kernel_b = getWeightParams().dims[3];

    
        size_t j = 0, l = 0, i = 0, k = 0, d = 0, b = 0;
    
        // where I accumulate the sum
        double M;      
        double z_next; 
        
        // there should be a smarter way of doing this, but basically the idea is to choose the correct scale
        // if because layer_num + 1 might be 0
        if (layer_num == 1 || layer_num == 4 || layer_num == 5){
            M      = SI_VALS[layer_num + 2] / (SI_VALS[layer_num] * SW_VALS[layer_num]);
            z_next = SZ_VALS[layer_num + 2];
        }
        else if (layer_num == 7){
            M      = SI_VALS[layer_num + 3] / (SI_VALS[layer_num] * SW_VALS[layer_num]);
            z_next = SZ_VALS[layer_num + 3];
        }
        else {
            M      = SI_VALS[layer_num + 1] / (SI_VALS[layer_num] * SW_VALS[layer_num]);
            z_next = SZ_VALS[layer_num + 1];
        }
        //    M = 2^32 
        i64 q_scale = static_cast<i64>(M * std::pow(2, 32));

        i64 sum[CHANNEL_NUM_TO_COMPUTE_AT_ONCE] = {0};
        i8 weights[CHANNEL_NUM_TO_COMPUTE_AT_ONCE] = {0};
        i8 activation;

        //for (b = 0; b < kernel_b; b+=4){  // BEGINNING OF BATCH IF. Doing this so I can compare one channel output
            for (j = 0; j < out_h; j++){
                for (l = 0; l < out_w; l++){

                    for (size_t x = 0; x < CHANNEL_NUM_TO_COMPUTE_AT_ONCE; x++)
                    {
                        sum[x] = getBiasData().get<i32>(b + x);
                    }
                    
                    for (d = 0; d < kernel_d; d++){
                        for (i = 0; i < kernel_h; i++){
                            for (k = 0; k < kernel_w; k++){

                                activation = dataIn.get<i8>(get_image_flat_idx_cm(j + i, l + k, d, image_w, image_h));

                                for (size_t y = 0; y < CHANNEL_NUM_TO_COMPUTE_AT_ONCE; y++)
                                {
                                    weights[y] = getWeightData().get<i8>(get_kernel_flat_idx_cm(i, k, d, b + y, kernel_w, kernel_d, kernel_h));
                                    sum[y] += (weights[y] * activation);
                                }
                                
                            }
                        }
                    }
                    double out_val;
                    i64 requantized_out_val;

                    if (layer_num == 100) // 100 means, just never execute this block. because layer 100 doesn't exist. 
                    {
                        //out_val = sum / (SW_VALS[layer_num] * SI_VALS[layer_num]);
                        //out_val = out_val > 0.0 ? out_val : 0;
                        //getOutputData().get<fp32>(get_out_flat_idx_cm(j, l, b, out_w, out_h)) = out_val;
                    }
                    else // this requintizes it for the next layer makes it an int8
                    {
                        // Requintize:
                        // doing fixed point instead of floating point.
                        for (size_t z = 0; z < sizeof(CHANNEL_NUM_TO_COMPUTE_AT_ONCE); z++)
                        {
                            i64 product = sum[z] * q_scale;
                            requantized_out_val = product >> 32;
                            requantized_out_val = requantized_out_val > 0 ? requantized_out_val : 0; // ReLU
                            requantized_out_val = requantized_out_val + z_next; // zero
                            requantized_out_val = std::clamp(requantized_out_val, static_cast<i64>(min_value), static_cast<i64>(max_value));     //saturate
                            
                            // cast it to i8 and assign to output
                            getOutputData().get<i8>(get_out_flat_idx_cm(j, l, b + z, out_w, out_h)) = static_cast<i8>(requantized_out_val);
                        }
                        
                    }
               }
           }
        //} END OF BATCH IF


        // OKAY I CAN CONFIRM MY ACCELERATOR channel 1 works here. BECUASE I HAVE CONFIRMED CORRECT OUTPUT DATA FOR THE FIRST 4 CHANNELS HERE
        // SO I GET TO CONFIRM ONLY THE FIRST FOUR CHANNELS BEFORE REORDERING AND ANYTHING ELSE.

        
        // -------- ACCEL TEST BEGIN -----
           
        Xil_DCacheDisable();


        printf("running on the Zedboard\n");
        printf("The year is: %d\n",2005 + 21);

        // setting conv_idle = 1
        Xil_Out32(MLP_CONV_IDLE_REG, MLP_CONV_IDLE_ON_MASK); 

        // putting the inputs into BRAM
        memcpy_dma(MLP_INPUTS, dataIn.raw(), dataIn.getParams().byte_size()); // gets the byte size

        // putting the filters into BRAM
        size_t single_filter_size = getWeightParams().dims[0] * getWeightParams().dims[1] * getWeightParams().dims[2];
        size_t single_output_size = getOutputParams().dims[0] * getOutputParams().dims[1];

        i32 input_end_diff_fw = static_cast<i32>(1 - static_cast<i64>(kernel_w) + image_w);
        i32 input_end_diff_fh = static_cast<i32>(input_end_diff_fw - (static_cast<i64>(image_w) * kernel_h) + (static_cast<i64>(image_w) * image_h));
        i32 input_end_diff_fc = static_cast<i32>(input_end_diff_fh - (static_cast<i64>(image_w) * image_h * kernel_d) + 1);
        i32 input_end_diff_ow = static_cast<i32>(input_end_diff_fc + (static_cast<i64>(kernel_w) - 1));


        const auto* filters = static_cast<const uint8_t*>(getWeightData().raw());

        memcpy_dma(MLP_FILTER0, filters + 0 * single_filter_size, single_filter_size);
        memcpy_dma(MLP_FILTER1, filters + 1 * single_filter_size, single_filter_size);
        memcpy_dma(MLP_FILTER2, filters + 2 * single_filter_size, single_filter_size);
        memcpy_dma(MLP_FILTER3, filters + 3 * single_filter_size, single_filter_size);


//
//        memcheck(MLP_INPUTS, dataIn.raw(), dataIn.getParams().byte_size());
//
//        memcheck(MLP_FILTER0, getWeightData().raw() + 0 * single_filter_size , single_filter_size);
//        memcheck(MLP_FILTER1, getWeightData().raw() + 1 * single_filter_size , single_filter_size);
//        memcheck(MLP_FILTER2, getWeightData().raw() + 2 * single_filter_size , single_filter_size);
//        memcheck(MLP_FILTER3, getWeightData().raw() + 3 * single_filter_size , single_filter_size);

        printf("First four channel Dma check is done\n");

        // HERE
        //Xil_Out32(MLP_CTRL, 0x0000000); // so basically everyhing is off. not swaaping filters/inputs, maxpooling/relu are both off
        Xil_Out32(MLP_CTRL, MLP_CTRL_SWAP_FILTERS | MLP_CTRL_RELU); // so basically everyhing is off, but swaaping filters.  maxpooling/relu are both off, not swappig in/out buffers

        Xil_Out32(MLP_FILTER_W                   , kernel_w);
        Xil_Out32(MLP_FILTER_H                   , kernel_h);
        Xil_Out32(MLP_FILTER_C                   , kernel_d); // we don't care about batch, since we control it from outsise
        Xil_Out32(MLP_OUTPUT_W                   , out_w);
        Xil_Out32(MLP_OUTPUT_H                   , out_h); // again we don't care about the chanell of outputs, since it is conrolled from out
        Xil_Out32(MLP_INPUT_END_DIFF_FW          , input_end_diff_fw);
        Xil_Out32(MLP_INPUT_END_DIFF_FH          , input_end_diff_fh);
        Xil_Out32(MLP_INPUT_END_DIFF_FC          , input_end_diff_fc);
        Xil_Out32(MLP_INPUT_END_DIFF_OW          , input_end_diff_ow);
        Xil_Out32(MLP_OUTPUT_ELEMENTS_PER_CHANNEL, single_output_size);
        Xil_Out32(MLP_OUTPUT_INITIAL_OFFSET      , 0x00000000);
        Xil_Out32(MLP_MAC0_BIAS                  , static_cast<ui32>(getBiasData().get<i32>(0)));
        Xil_Out32(MLP_MAC1_BIAS                  , static_cast<ui32>(getBiasData().get<i32>(1)));
        Xil_Out32(MLP_MAC2_BIAS                  , static_cast<ui32>(getBiasData().get<i32>(2)));
        Xil_Out32(MLP_MAC3_BIAS                  , static_cast<ui32>(getBiasData().get<i32>(3)));
        Xil_Out32(MLP_Q_SCALE                    , static_cast<ui32>(q_scale));
        Xil_Out32(MLP_Q_ZERO                     , static_cast<i32>(z_next));



        // AHHHHHH I needed to swap filters after writing
        // Because, because because DMA interface is connected to the bank that is not connected to the accelerator
        // Soo by switching, I connect the filled bank to the accelerator.
        Xil_Out32(MLP_CONV_IDLE_REG, MLP_CONV_IDLE_OFF_MASK); 

        while (!Xil_In32(MLP_CONV_IDLE_REG)){}

        LayerData scratch_data(getOutputParams());
        scratch_data.allocData();

        memcpy_dma(scratch_data.raw(), MLP_OUTPUTS, 4 * single_output_size); // gets the byte size

        std::cout << "comparing the first 100 nums\n";
        for (size_t i = 0; i < 200; i++)
        {
            std::cout << "REAL: " << static_cast<i32>(getOutputData().get<i8>(i)) << " SCRATCH: " << static_cast<i32>(scratch_data.get<i8>(i)) << "\n";
        }
        




    printf("Convolution is done\n");













































    // ---------------- COMMENTING THE REST FOR NOW.
    //    // if this is the final layer, then reorder data for comparison
    //    // This basically convert from D H W  ------>  H W D
    //    // because intermediate feature maps are of that format, and I didn't want to
    //    // export my weights diffrently for maximum robustness
    //    if(layer_num == 0){
    //        LayerData reordered_data(getOutputParams());
    //        reordered_data.allocData();

    //        size_t o_widht = getOutputParams().dims[0];
    //        size_t o_depth = getOutputParams().dims[2];
    //        size_t o_height = getOutputParams().dims[1];

    //        for (size_t i = 0; i < o_height; i++) // slowest chaning is height
    //        {
    //            for (size_t j = 0; j < o_widht; j++) // next fastest changing is widht
    //            {
    //                for (size_t k = 0; k < o_depth; k++) // so fastest chaning is depth
    //                {
    //                    // image_w * image_d * height_idx + image_d * width_idx + depth_idx;
    //                    i8 temp = getOutputData().get<i8>(o_widht * o_height * k + o_widht * i + j);

    //                    reordered_data.get<i8>(o_depth * o_widht * i + o_depth * j + k) = temp; // DEPTH * WIDHT * (c_h) + DEPTH * (c_w) + c_d
    //                }
    //            }
    //            
    //        }
    //        getOutputData() = reordered_data;

    //        reordered_data.freeData();
    //    }
    }

    // Compute the convolution using threads
    void ConvolutionalLayer::computeThreaded(const LayerData &dataIn) const
    {
    }

    // Compute the convolution using a tiled approach
    void ConvolutionalLayer::computeTiled(const LayerData &dataIn) const
    {
    }

    void ConvolutionalLayer::computeSIMD(const LayerData &dataIn, const int layer_num) const
    {
    }
} // namespace ML
