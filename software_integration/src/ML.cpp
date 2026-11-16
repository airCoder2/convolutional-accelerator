#include <iostream>
#include <sstream>
#include <vector>
#include <algorithm>
#include <fstream>
#include <filesystem>

#include "Config.h"
#include "Types.h"
#include "Utils.h"
#include "xtime_l.h"


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

    // setting conv_idle = 1
    Xil_Out32(MLP_CONV_IDLE_REG, MLP_CONV_IDLE_ON_MASK); 

    // putting the inputs into BRAM
    memcpy_dma(MLP_INPUTS, inputs, sizeof(inputs));

    // putting the filters into BRAM
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

    // HERE
    //Xil_Out32(MLP_CTRL, 0x0000000); // so basically everyhing is off. not swaaping filters/inputs, maxpooling/relu are both off
    Xil_Out32(MLP_CTRL, MLP_CTRL_SWAP_FILTERS); // so basically everyhing is off, but swaaping filters.  maxpooling/relu are both off, not swappig in/out buffers

    Xil_Out32(MLP_FILTER_W                   , 0x00000003);
    Xil_Out32(MLP_FILTER_H                   , 0x00000002);
    Xil_Out32(MLP_FILTER_C                   , 0x00000002);
    Xil_Out32(MLP_OUTPUT_W                   , 0x00000002);
    Xil_Out32(MLP_OUTPUT_H                   , 0x00000002);
    Xil_Out32(MLP_INPUT_END_DIFF_FW          , 0x00000002);
    Xil_Out32(MLP_INPUT_END_DIFF_FH          , 0x00000006);
    Xil_Out32(MLP_INPUT_END_DIFF_FC          , 0xFFFFFFEF);
    Xil_Out32(MLP_INPUT_END_DIFF_OW          , 0xFFFFFFF1);
    Xil_Out32(MLP_OUTPUT_ELEMENTS_PER_CHANNEL, 0x00000004);
    Xil_Out32(MLP_OUTPUT_INITIAL_OFFSET      , 0x00000000);
    Xil_Out32(MLP_MAC0_BIAS                  , 0x00000000);
    Xil_Out32(MLP_MAC1_BIAS                  , 0x00000001);
    Xil_Out32(MLP_MAC2_BIAS                  , 0x00000002);
    Xil_Out32(MLP_MAC3_BIAS                  , 0x00000003);
    Xil_Out32(MLP_Q_SCALE                    , 0x04000000);
    Xil_Out32(MLP_Q_ZERO                     , 0x00000000);



    // AHHHHHH I needed to swap filters after writing
    // Because, because because DMA interface is connected to the bank that is not connected to the accelerator
    // Soo by switching, I connect the filled bank to the accelerator.
    Xil_Out32(MLP_CONV_IDLE_REG, MLP_CONV_IDLE_OFF_MASK); 

    while (!Xil_In32(MLP_CONV_IDLE_REG)){}




    printf("Convolution is done\n");



    



}
#else
int main()
{
    printf("running on lab machines\n");
}
#endif
