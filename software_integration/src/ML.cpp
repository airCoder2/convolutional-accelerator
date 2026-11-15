#include <iostream>
#include <sstream>
#include <vector>
#include <algorithm>
#include <fstream>
#include <filesystem>

#include "Config.h"
#include "Types.h"
#include "Utils.h"


#pragma once
#define ZEDBOARD
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

#define MLP_CTRLA                       (MLP_CONV_BASEADDR + 0x00)
#define MLP_CTRLA_CONV_IDLE             (1 << 0)
#define MLP_CTRLB                       (MLP_CONV_BASEADDR + 0x04)
#define MLP_CTRLB_SWAP_FILTERS          (1 << 0)
#define MLP_CTRLB_SWAP_ACTIVATIONS      (1 << 1)
#define MLP_CTRLB_MAX_POOLING           (1 << 2)
#define MLP_CTRLB_RELU                  (1 << 3)
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
    Xil_Out32(XPAR_AXI_CDMA_0_BASEADDR + XAXICDMA_BTT_OFFSET, len);
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
    Xil_Out32(MLP_CTRLB, MLP_CTRLB_SWAP_FILTERS); // Swap filter banks

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
    Xil_Out32(MLP_CTRLB, MLP_CTRLB_SWAP_ACTIVATIONS); // Swap banks back
    memcheck_verify(MLP_FILTER0, (1 << 11), 10);
    memcheck_verify(MLP_FILTER1, (1 << 11), 11);
    memcheck_verify(MLP_FILTER2, (1 << 11), 12);
    memcheck_verify(MLP_FILTER3, (1 << 11), 13);
    memcheck_verify(MLP_INPUTS, (1 << 17), 15);
    memcheck_verify(MLP_OUTPUTS, (1 << 17), 14);
}




#ifdef ZEDBOARD
extern "C" int main()
{
    Xil_DCacheDisable();


    printf("running on the Zedboard\n");
    printf("The year is: %d\n",2005 + 21);

//    runMemoryTest();

    i8 inputs[2][3][4] = {
        {
            {127, -1, -128, 4},
            {5, 6, 7, 8},
            {9, 10, 11, 12}
        },
        {
            {13, 14, 15, 16},
            {17, 18, 19, 0},
            {21, 3, 2, 1}
        }
    };


    i8 filters[4][2][2][3] = {
        {
            {
                {127, -1, -128},
                {4, 5, 6}
            },
            {
                {7, 8, 9},
                {10, 11, 12}
            }
        },
        {
            {
                {-13, -14, -15},
                {-16, -17, -18}
            },
            {
                {-19, -20, -21},
                {-22, -23, -24}
            }
        },
        {
            {
                {25, 26, 27},
                {28, 29, 30}
            },
            {
                {31, 32, 33},
                {34, 35, 36}
            }
        },
        {
            {
                {37, 38, 39},
                {40, 41, 42}
            },
            {
                {43, 44, 45},
                {46, 47, 48}
            }
        }
    };
    printf("The size of inputs   is: %u\n", sizeof(inputs));
    printf("The size of filter 1 is: %u\n", sizeof(filters[0]));
    printf("The size of filter 2 is: %u\n", sizeof(filters[1]));
    printf("The size of filter 3 is: %u\n", sizeof(filters[2]));
    printf("The size of filter 4 is: %u\n", sizeof(filters[3]));

    memcpy_dma(MLP_INPUTS, inputs, sizeof(inputs));

    memcpy_dma(MLP_FILTER0, filters[0], sizeof(filters[0]));
    memcpy_dma(MLP_FILTER1, filters[1], sizeof(filters[0]));
    memcpy_dma(MLP_FILTER2, filters[2], sizeof(filters[0]));
    memcpy_dma(MLP_FILTER3, filters[3], sizeof(filters[0]));


    memcheck(MLP_INPUTS, inputs, sizeof(inputs));

    memcheck(MLP_FILTER0, filters[0], sizeof(filters[0]));
    memcheck(MLP_FILTER1, filters[1], sizeof(filters[0]));
    memcheck(MLP_FILTER2, filters[2], sizeof(filters[0]));
    memcheck(MLP_FILTER3, filters[3], sizeof(filters[0]));

    printf("Custom array dma check is done\n");

        // set conv_idle to 0, while we are setthing things up
        conv_idle <= '1';
       
        // make all the DMA transferes here

        
        // set max polling 
        max_pooling <= '0';

        // set relu
        relu <= '0';

        // set filter w
        filter_w <= x"00000003";

        // set filter h
        filter_h <= x"00000002";

        // set filter c
        filter_c <= x"00000002";

        // set filter w 
        output_w <= x"00000002";

        // set ouput h
        output_h <= x"00000002";

        //set these
        input_end_diff_fw <= x"00000002";
        input_end_diff_fh <= x"00000006";
        input_end_diff_fc <= x"FFFFFFEF";
        input_end_diff_ow <= x"FFFFFFF1";

        // set element per channel
        output_elements_per_channel <= x"00000004";

        //set initial offset
        output_initial_offset <= x"00000000";

        // set biases
        mac0_bias <= x"00000000";
        mac1_bias <= x"00000001";
        mac2_bias <= x"00000002";
        mac3_bias <= x"00000003";

        //set scale
        q_scale <= x"04000000";

        // set zero
        q_zero <= x"00000000";

        // drop conv_idle to 0 so the things start
        conv_idle <= '0';

        // wait until conve_idle becomes 1 again




}
#else
int main()
{
    printf("running on lab machines\n");
}
#endif
