#include <iostream>
#include <sstream>
#include <vector>
#include <algorithm>
#include <fstream>
#include <filesystem>

#include "Config.h"
#include "Model.h"
#include "Types.h"
#include "Utils.h"
#include "layers/Convolutional.h"
#include "layers/Dense.h"
#include "layers/Layer.h"
#include "layers/MaxPooling.h"
#include "layers/Flatten.h"
#include "layers/Softmax.h"
#include "layers/config.h"

#include "Accelerator.h"


#ifdef ZEDBOARD
#include <ff.h>
#include <file_transfer/file_transfer.h>
#include "xil_printf.h"
#endif

namespace ML
{

    // Build our ML toy model
    Model buildToyModel(const Path modelPath)
    {
        Model model;
        logInfo("--- Building Toy Model ---");

        // --- Conv 1: L1 ---
        // Input shape: 64x64x3
        // Output shape: 60x60x32
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {64, 64, 3}},                                    // Input Data
            LayerParams{sizeof(i8), {60, 60, 32}},                                   // Output Data
            LayerParams{sizeof(i8), {5, 5, 3, 32}, modelPath / "quantized_model_data"/ weights_dir/ "conv2d_weights.bin"}, // Weights
            LayerParams{sizeof(i32), {32}, modelPath / "quantized_model_data"/ biases_dir / "conv2d_biases.bin"}            // Bias
        );

        // --- Conv 2: L2 ---
        // Input shape: 60x60x32
        // Output shape: 56x56x32
//        model.addLayer<ConvolutionalLayer>(
//            LayerParams{sizeof(i8), {60, 60, 32}},                                    // Input Data
//            LayerParams{sizeof(i8), {56, 56, 32}},                                   // Output Data
//            LayerParams{sizeof(i8), {5, 5, 32, 32}, modelPath / "quantized_model_data"/weights_dir / "conv2d_1_weights.bin"}, // Weights
//            LayerParams{sizeof(i32), {32}, modelPath / "quantized_model_data"/ biases_dir / "conv2d_1_biases.bin"}            // Bias
//        );
//
//        // --- MPL 1: L3 ---
//        // Input shape: 56x56x32
//        // Output shape: 28x28x32
//        model.addLayer<MaxPoolingLayer>(
//            LayerParams{sizeof(i8), {56, 56, 32}},                                    // Input Data
//            LayerParams{sizeof(i8), {28, 28, 32}}                                    // Output Data
//        );
//
//        // --- Conv 3: L4 ---
//        // Input shape: 28x28x32
//        // Output shape: 26x26x64
//        model.addLayer<ConvolutionalLayer>(
//            LayerParams{sizeof(i8), {28, 28, 32}},                                    // Input Data
//            LayerParams{sizeof(i8), {26, 26, 64}},                                   // Output Data
//            LayerParams{sizeof(i8), {3, 3, 32, 64}, modelPath / "quantized_model_data"/ weights_dir / "conv2d_2_weights.bin"}, // Weights
//            LayerParams{sizeof(i32), {64}, modelPath / "quantized_model_data"/ biases_dir / "conv2d_2_biases.bin"}            // Bias
//        );
//
//        // --- Conv 4: L5 ---
//        // Input shape: 26x26x64
//        // Output shape: 24x24x64
//        model.addLayer<ConvolutionalLayer>(
//            LayerParams{sizeof(i8), {26, 26, 64}},                                    // Input Data
//            LayerParams{sizeof(i8), {24, 24, 64}},                                   // Output Data
//            LayerParams{sizeof(i8), {3, 3, 64, 64}, modelPath / "quantized_model_data"/ weights_dir / "conv2d_3_weights.bin"}, // Weights
//            LayerParams{sizeof(i32), {64}, modelPath / "quantized_model_data"/ biases_dir / "conv2d_3_biases.bin"}            // Bias
//        );
//
//        // --- MPL 2: L6 ---
//        // Input shape: 24x24x64
//        // Output shape: 12x12x64
//        model.addLayer<MaxPoolingLayer>(
//            LayerParams{sizeof(i8), {24, 24, 64}},                                    // Input Data
//            LayerParams{sizeof(i8), {12, 12, 64}}                                    // Output Data
//        );
//
//        // --- Conv 5: L7 ---
//        // Input shape: 12x12x64
//        // Output shape: 10x10x64
//        model.addLayer<ConvolutionalLayer>(
//            LayerParams{sizeof(i8), {12, 12, 64}},                                    // Input Data
//            LayerParams{sizeof(i8), {10, 10, 64}},                                   // Output Data
//            LayerParams{sizeof(i8), {3, 3, 64, 64}, modelPath / "quantized_model_data"/ weights_dir / "conv2d_4_weights.bin"}, // Weights
//            LayerParams{sizeof(i32), {64}, modelPath / "quantized_model_data"/ biases_dir / "conv2d_4_biases.bin"}            // Bias
//        );
//
//        // --- Conv 6: L8 ---
//        // Input shape: 10x10x64
//        // Output shape: 8x8x128
//        model.addLayer<ConvolutionalLayer>(
//            LayerParams{sizeof(i8), {10, 10, 64}},                                    // Input Data
//            LayerParams{sizeof(i8), {8, 8, 128}},                                   // Output Data
//            LayerParams{sizeof(i8), {3, 3, 64, 128}, modelPath / "quantized_model_data"/ weights_dir / "conv2d_5_weights.bin"}, // Weights
//            LayerParams{sizeof(i32), {128}, modelPath / "quantized_model_data"/ biases_dir / "conv2d_5_biases.bin"}            // Bias
//        );
//
//        // --- MPL 3: L9 ---
//        // Input shape: 8x8x128
//        // Output shape: 4x4x128
//        model.addLayer<MaxPoolingLayer>(
//            LayerParams{sizeof(i8), {8, 8, 128}},                                    // Input Data
//            LayerParams{sizeof(i8), {4, 4, 128}}                                    // Output Data
//        );
//
//        // --- Flatten 1: L10 ---
//        // Input shape: 4x4x128
//        // Output shape: 2048
//        model.addLayer<FlattenLayer>(
//            LayerParams{sizeof(i8), {4, 4, 128}},                                    // Input Data
//            LayerParams{sizeof(i8), {2048}}                                         // Output Data
//        );
//
//        // --- Dense 1: L11 ---
//        // Input shape: 2048
//        // Output shape: 256
//        model.addLayer<DenseLayer>(
//            LayerParams{sizeof(i8), {2048}},                                    // Input Data
//            LayerParams{sizeof(i8), {256}},                                   // Output Data
//            LayerParams{sizeof(i8), {256, 1024}, modelPath / "quantized_model_data"/ weights_dir / "dense_weights.bin"}, // Weights
//            LayerParams{sizeof(i32), {256}, modelPath / "quantized_model_data"/ biases_dir/ "dense_biases.bin"}  ,    // Bias
//            DenseLayer::ActivationType::ReLU
//        );
//
//        // --- Dense 2: L12 ---
//        // Input shape: 256
//        // Output shape: 200
//        model.addLayer<DenseLayer>(
//            LayerParams{sizeof(i8), {256}},                                    // Input Data
//            LayerParams{sizeof(fp32), {200}},                                   // Output Data
//            LayerParams{sizeof(i8), {200, 128}, modelPath / "quantized_model_data"/ weights_dir / "dense_1_weights.bin"}, // Weights
//            LayerParams{sizeof(i32), {200}, modelPath / "quantized_model_data"/ biases_dir / "dense_1_biases.bin"}  ,    // Bias
//            DenseLayer::ActivationType::SoftMax
//
//        );

        // --- Softmax 1: L13 ---
        // Input shape: 200
        // Output shape: 200

        // I added softmax as an activation funciton to the previous one. So no need to implement it. I don't know why they have it here
        // as a separate layer, since ReLU activation function was always done before the output of a layer

        return model;
    }
    inline size_t get_image_flat_idx(size_t height_idx, size_t width_idx, size_t depth_idx, size_t image_w, size_t image_d){
        return image_w * image_d * height_idx + image_d * width_idx + depth_idx;
    }

    void run_accel_inferance(const Model &model, const Path& input_image_bin){

        // quantizing the input and reordering it
        LayerData unquantized_img({sizeof(fp32), model[0].getInputParams().dims}, input_image_bin);
        unquantized_img.loadData();

        LayerData quantized_reordered_image(model[0].getInputParams());
        quantized_reordered_image.allocData();


        //input is 64 64 3
        // now it is    H W D
        // chnage it to D H W
            size_t img_h = 64;
            size_t img_w = 64;
            size_t img_d = 3;

            for (size_t i = 0; i < img_d; i++)
            {
                for (size_t j = 0; j < img_h; j++)
                {
                    for (size_t k = 0; k < img_w; k++)
                    {
                        // image_w * image_d * height_idx + image_d * width_idx + depth_idx;
                        i8 temp = static_cast<i8>(std::clamp(std::nearbyint((SI_VALS[0] * unquantized_img.get<fp32>(img_w * img_d * j + img_d * k + i)) + SZ_VALS[0]), min_value, max_value));
                        quantized_reordered_image.get<i8>(i * img_h * img_w + j * img_w + k) = temp;
                    }
                }
                
            }
            // free the unquantized since we don't need it anymore
            unquantized_img.freeData();

            Timer timer("Full Inference");

            // Run inference on the model
            //-----------------------------------------------------------------------------------------------------
            // do the actual inference here. Since we have acell to all the layer data, we could just use
            // it to fill the output and then compare the output that we got from software to what we got
            // here
            // STARTING



            const ConvolutionalLayer &conv = static_cast<const ConvolutionalLayer &>(model[0]);
            double M;      
            double z_next; 
            
            M      = SI_VALS[1] / (SI_VALS[0] * SW_VALS[0]);
            z_next = SZ_VALS[1];

            i64 q_scale = static_cast<i64>(M * std::pow(2, 32));


            Xil_DCacheDisable();

            // THESE ARE FINE, SINCE THE PARENT LAYER HAS THEM
            size_t image_h = conv.getInputParams().dims[0];
            size_t image_w = conv.getInputParams().dims[1];
            size_t image_d = conv.getInputParams().dims[2];

            // {60, 60, 32}
            size_t out_h = conv.getOutputParams().dims[0];
            size_t out_w = conv.getOutputParams().dims[1];

            // {5, 5, 3, 32}

            // casting the first layer. Without casting it didn't wokr
            size_t kernel_h = conv.getWeightParams().dims[0];
            size_t kernel_w = conv.getWeightParams().dims[1];
            size_t kernel_d = conv.getWeightParams().dims[2];
            size_t kernel_b = conv.getWeightParams().dims[3];


            printf("running on the Zedboard\n");
            printf("The year is: %d\n",2005 + 21);

            // setting conv_idle = 1
            Xil_Out32(MLP_CONV_IDLE_REG, MLP_CONV_IDLE_ON_MASK); 

            // putting the inputs into BRAM
            memcpy_dma(MLP_INPUTS, quantized_reordered_image.raw(), quantized_reordered_image.getParams().byte_size()); // gets the byte size

            // putting the filters into BRAM
            size_t single_filter_size = conv.getWeightParams().dims[0] * conv.getWeightParams().dims[1] * conv.getWeightParams().dims[2];
            size_t single_output_size = conv.getOutputParams().dims[0] * conv.getOutputParams().dims[1];

            i32 input_end_diff_fw = static_cast<i32>(1 - static_cast<i64>(kernel_w) + image_w);
            i32 input_end_diff_fh = static_cast<i32>(input_end_diff_fw - (static_cast<i64>(image_w) * kernel_h) + (static_cast<i64>(image_w) * image_h));
            i32 input_end_diff_fc = static_cast<i32>(input_end_diff_fh - (static_cast<i64>(image_w) * image_h * kernel_d) + 1);
            i32 input_end_diff_ow = static_cast<i32>(input_end_diff_fc + (static_cast<i64>(kernel_w) - 1));
            
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
            Xil_Out32(MLP_Q_SCALE                    , static_cast<ui32>(q_scale));
            Xil_Out32(MLP_Q_ZERO                     , static_cast<i32>(z_next));



            // Idk, there was a compiler issue with pointer arithmetic with void
            // soo yeah I changed it to be this. Makes someting work

            for (size_t b = 0; b < kernel_b; b+=CHANNEL_NUM_TO_COMPUTE_AT_ONCE){  // BEGINNING OF BATCH IF. Doing this so I can compare one channel output
                const auto* filters = static_cast<const uint8_t*>(conv.getWeightData().raw());

                memcpy_dma(MLP_FILTER0, filters + ((b+0) * single_filter_size), single_filter_size);
                memcpy_dma(MLP_FILTER1, filters + ((b+1) * single_filter_size), single_filter_size);
                memcpy_dma(MLP_FILTER2, filters + ((b+2) * single_filter_size), single_filter_size);
                memcpy_dma(MLP_FILTER3, filters + ((b+3) * single_filter_size), single_filter_size);



                printf("First four channel Dma copy is done!!!\n");

                // HERE
                //Xil_Out32(MLP_CTRL, 0x0000000); // so basically everyhing is off. not swaaping filters/inputs, maxpooling/relu are both off
                ui32 ctrl_reg = Xil_In32(MLP_CTRL);
                ctrl_reg ^= 1U; // Xoring the last bit to toggle it. This is for swapping filters
                ctrl_reg |= MLP_CTRL_RELU; // and then add RELU
                Xil_Out32(MLP_CTRL, ctrl_reg); // so basically everyhing is off, but swaaping filters.  maxpooling/relu are both off, not swappig in/out buffers

                Xil_Out32(MLP_OUTPUT_INITIAL_OFFSET      , single_output_size * b); // set the initial offset to single_output_size * b
                Xil_Out32(MLP_MAC0_BIAS                  , static_cast<ui32>(conv.getBiasData().get<i32>(b)));
                Xil_Out32(MLP_MAC1_BIAS                  , static_cast<ui32>(conv.getBiasData().get<i32>(b+1)));
                Xil_Out32(MLP_MAC2_BIAS                  , static_cast<ui32>(conv.getBiasData().get<i32>(b+2)));
                Xil_Out32(MLP_MAC3_BIAS                  , static_cast<ui32>(conv.getBiasData().get<i32>(b+3)));


                // AHHHHHH I needed to swap filters after writing
                // Because, because because DMA interface is connected to the bank that is not connected to the accelerator
                // Soo by switching, I connect the filled bank to the accelerator.
                Xil_Out32(MLP_CONV_IDLE_REG, MLP_CONV_IDLE_OFF_MASK); 

                while (!Xil_In32(MLP_CONV_IDLE_REG)){} // pause here until channel is computed

                //if (layer_num != 1){
                //    ctrl_reg = Xil_In32(MLP_CTRL);
                //    ctrl_reg |= MLP_CTRL_SWAP_ACTIVATIONS; // swap activations
                //    Xil_Out32(MLP_CTRL, ctrl_reg); // if it is not the final layer then swap activaitons. So inputs become outputs, outputs become inputs 
                //}
            }


            memcpy_dma(conv.getOutputData().raw(), MLP_OUTPUTS, conv.getOutputParams().byte_size()); // gets the byte size


    }


    void runInferenceTest(const Model &model, const Path& input_image_bin, const Path& ground_truth_pred_path)
    {
        // Load an image
        logInfo("\n\n\n--- Running Inference Test ---");

        // read the original file into buffer, the size of the input is fp32
        // there is no way of reading the image and quantizing it on the go, 
        // so first we must read it as it is, and then quantize it by writing to a different buffer
        LayerData unquantized_img({sizeof(fp32), model[0].getInputParams().dims}, input_image_bin);
        unquantized_img.loadData();

        LayerData quantized_reordered_image(model[0].getInputParams());
        quantized_reordered_image.allocData();

//        for (size_t i = 0; i < model[0].getInputParams().flat_count(); i++)
//        {
//            i8 temp = static_cast<i8>(std::clamp(std::nearbyint((SI_VALS[0] * unquantized_img.get<fp32>(i) + SZ_VALS[0])), min_value, max_value));
//
//            quantized_reordered_image.get<i8>(i) = temp;
//        }

        //input is 64 64 3
        // now it is    H W D
        // chnage it to D H W
            size_t img_h = 64;
            size_t img_w = 64;
            size_t img_d = 3;

            for (size_t i = 0; i < img_d; i++)
            {
                for (size_t j = 0; j < img_h; j++)
                {
                    for (size_t k = 0; k < img_w; k++)
                    {
                        // image_w * image_d * height_idx + image_d * width_idx + depth_idx;
                        i8 temp = static_cast<i8>(std::clamp(std::nearbyint((SI_VALS[0] * unquantized_img.get<fp32>(img_w * img_d * j + img_d * k + i)) + SZ_VALS[0]), min_value, max_value));
                        quantized_reordered_image.get<i8>(i * img_h * img_w + j * img_w + k) = temp;
                    }
                }
                
            }
            unquantized_img.freeData();

            Timer timer("Full Inference");

            // Run inference on the model
            timer.start();
            const LayerData &output = model.inference(quantized_reordered_image, Layer::InfType::NAIVE);
            timer.stop();



            LayerData unquantized_feature_map({sizeof(fp32), model[0].getOutputParams().dims}, ground_truth_pred_path);
            unquantized_feature_map.loadData();

            LayerData quantized_feature_map(model[0].getOutputParams());
            quantized_feature_map.allocData();

            size_t ker_w = 60;
            size_t ker_h = 60;
            size_t ker_d = 32;

            // reordering the feature map so I can compare
            for (size_t i = 0; i < ker_d; i++) // channel 
            {
                for (size_t j = 0; j < ker_h; j++) // height
                {
                    for (size_t k = 0; k < ker_w; k++) // widht
                    {
                        // image_w * image_d * height_idx + image_d * width_idx + depth_idx;
                        i8 temp = static_cast<i8>(std::clamp(std::nearbyint((SI_VALS[1] * unquantized_feature_map.get<fp32>(ker_w * ker_d * j + ker_d * k + i)) + SZ_VALS[1]), min_value, max_value));
                        quantized_feature_map.get<i8>(i * ker_h * ker_w + j * ker_w + k) = temp;
                    }
                }
                
            }
            unquantized_feature_map.freeData();
        // MODIFIED LENGTH WEIGHTED COSINE SIMILARITY
        double dot_product = 0;
        double a_magnitude_sq = 0;
        double b_magnitude_sq = 0;

        // Recurse as needed into each array
        for (std::size_t i = 0; i < model[0].getOutputParams().flat_count(); i++)
        {
            a_magnitude_sq += output.get<i8>(i) * output.get<i8>(i);
            b_magnitude_sq += quantized_feature_map.get<i8>(i) * quantized_feature_map.get<i8>(i);
            dot_product += output.get<i8>(i) * quantized_feature_map.get<i8>(i);
        }

        float cosine_similarity = 0;
        if (a_magnitude_sq == 0 && b_magnitude_sq == 0)
        {
            std::cout << "Zero Magnitude Vector Comparison" << std::endl;
        }
        else
        {
            cosine_similarity = dot_product / (std::max(a_magnitude_sq, b_magnitude_sq));
        }
        std::cout
        << "Comparing Outputs (Cosine Similarity) SOFT VS TRUTH: "
        << " " << clamp(cosine_similarity * 100.0, 0.0, 100.0) << "% "
        << " ("
        << cosine_similarity
        << ")\n\n";



        // free the unquantized image, we don't need to hold in our memory anymore


// ----------------COMMENTING THE REST FOR NOW. ACCELERATOR IS BEING TESTED
//        // Compare the output
//        // Construct a LayerData object from a LayerParams one
//        LayerData expected_fp32({sizeof(fp32), model.getOutputLayer().getOutputParams().dims}, ground_truth_pred_path);
//        expected_fp32.loadData();
//
//        // write a thing, so we get to compare i8s rather than comparing fp32
//        LayerData expected_i8(model.getOutputLayer().getOutputParams()); 
//        expected_i8.allocData();
//
//        // This is for requintizing the feature map itself soo we get to compare the output of our requitized model with it.
//        // I did this because accelerator is going to be outputting an int8 not fp32. (because the dequant unit is built in)
//        // So now using this, I get to compare the output of the accelerator with what we should have gotten
//        for (size_t i = 0; i < model.getOutputLayer().getOutputParams().flat_count(); i++)
//        {
//            i8 requantized_expected = static_cast<i8>(std::clamp(std::nearbyint((SI_VALS[1] * expected_fp32.get<fp32>(i)) + SZ_VALS[1]), min_value, max_value));
//            expected_i8.get<i8>(i) = requantized_expected;
//        }
//        
//
//
//        //model.getNumLayers(); // this will be the last layer
//
//        //std::cout << "fp32 comparison:\n";
//        //output.compareWithinPrint<fp32>(expected_fp32);
//
//        std::cout << "\n\ni8 comparison:\n";
//        output.compareWithinPrint<i8>(expected_i8);

          std::cout << "\n\nACCELERATOR TEST DONE!!!:\n";

    }

    void runTests()
    {
        // Base input data path (determined from current directory of where you are running the command)
#ifdef ZEDBOARD
        Path basePath("/data"); // SD card folder written by scripts/upload_data
#else
        Path basePath("../python_stuff");
#endif


        // Build the model and allocate the buffers
        Model model = buildToyModel(basePath);
        model.allocLayers(); // ME: allocates memory to store out_data from each leayer

        Model accel_model = buildToyModel(basePath);
        // REMEMBER: THERE ARE 2 allocLayers() method. One inside the inherited Layer Object, which allocates outputs
        // Another one is inside the actual conv, dense and all tthe other inheritee layers, they allocate weight and bias
        // data.  
        accel_model.allocLayers(); 

        runInferenceTest(model, basePath / "test_input"/"test_input_image.bin", basePath / "test_input_feature_maps" / "conv2d_feature.bin");
        run_accel_inferance(accel_model, basePath / "test_input"/"test_input_image.bin");

        // BEFORE CLEANUP COMPARE ACCELERATOR OUT AND SOFTWARE OUT

        // I just copied and pasted this cosine similariy example over
        // MODIFIED LENGTH WEIGHTED COSINE SIMILARITY
        double dot_product = 0;
        double a_magnitude_sq = 0;
        double b_magnitude_sq = 0;

        // Recurse as needed into each array
        for (std::size_t i = 0; i < model[0].getOutputParams().flat_count(); i++)
        {
            a_magnitude_sq += model[0].getOutputData().get<i8>(i) * model[0].getOutputData().get<i8>(i);
            b_magnitude_sq += accel_model[0].getOutputData().get<i8>(i) * accel_model[0].getOutputData().get<i8>(i);
            dot_product += model[0].getOutputData().get<i8>(i) * accel_model[0].getOutputData().get<i8>(i);
        }

        float cosine_similarity = 0;
        cosine_similarity = dot_product / (std::max(a_magnitude_sq, b_magnitude_sq));

        std::cout
        << "Comparing Outputs (Cosine Similarity) SOFT VS HARD: "
        << " " << clamp(cosine_similarity * 100.0, 0.0, 100.0) << "% "
        << " ("
        << cosine_similarity
        << ")\n";


        std::cout << "CONVOLUTION is done for LAYER\n" << std::endl;



        // Clean up 
        model.freeLayers();
       // accel_model.freeLayers();
        std::cout << "\n\n----- ML::runTests() COMPLETE -----\n";
    }

} // namespace ML

#ifdef ZEDBOARD
extern "C" int main()
{
	xil_printf("Hello UART\r\n");
    try
    {
        static FATFS fatfs;
        if (f_mount(&fatfs, "/", 1) != FR_OK)
        {
            throw std::runtime_error("Failed to mount SD card. Is it plugged in?");
        }
        ML::runTests();
    }
    catch (const std::exception &e)
    {
        std::cerr << "\n\n----- EXCEPTION THROWN -----\n"
                  << e.what() << '\n';
        std::cout << "\n\n----- STARTING FILE TRANSFER SERVER -----\n";
        FileServer::start_file_transfer_server();
    }
    return 0;
}
#else
int main()
{
    ML::runTests();
}
#endif
