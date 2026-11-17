#include "Convolutional.h"

#include <iostream>
#include <algorithm>

#include "../Types.h"
#include "../Utils.h"
#include "Layer.h"
#include "./config.h"



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

        i64 sum;

        for (b = 0; b < kernel_b; b++){
            for (j = 0; j < out_h; j++){
                for (l = 0; l < out_w; l++){

                    sum = getBiasData().get<i32>(b);

                    for (d = 0; d < kernel_d; d++){
                        for (i = 0; i < kernel_h; i++){
                            for (k = 0; k < kernel_w; k++){

                                i8 weight = getWeightData().get<i8>(get_kernel_flat_idx_cm(i, k, d, b, kernel_w, kernel_d, kernel_h));
                                i8 activation = dataIn.get<i8>(get_image_flat_idx_cm(j + i, l + k, d, image_w, image_h));
                                
                                sum += (weight * activation);
                            }
                        }
                    }
                    double out_val;
                    i64 requantized_out_val;

                    if (layer_num == 100) // 100 means, just never execute this block. because layer 100 doesn't exist. 
                    {
                        out_val = sum / (SW_VALS[layer_num] * SI_VALS[layer_num]);
                        out_val = out_val > 0.0 ? out_val : 0;
                        getOutputData().get<fp32>(get_out_flat_idx_cm(j, l, b, out_w, out_h)) = out_val;
                    }
                    else // this requintizes it for the next layer makes it an int8
                    {
                        // Requintize:
                        // doing fixed point instead of floating point.
                        i64 product = sum * q_scale;
                        requantized_out_val = product >> 32;
                        requantized_out_val = requantized_out_val > 0 ? requantized_out_val : 0; // ReLU
                        requantized_out_val = requantized_out_val + z_next; // zero
                        requantized_out_val = std::clamp(requantized_out_val, static_cast<i64>(min_value), static_cast<i64>(max_value));     //saturate
                        
                        // cast it to i8 and assign to output
                        getOutputData().get<i8>(get_out_flat_idx_cm(j, l, b, out_w, out_h)) = static_cast<i8>(requantized_out_val);
                    }
               }
           }
        }

        // if this is the final layer, then reorder data for comparison
        // This basically convert from D H W  ------>  H W D
        // because intermediate feature maps are of that format, and I didn't want to
        // export my weights diffrently for maximum robustness
        if(layer_num == 0){
            LayerData reordered_data(getOutputParams());
            reordered_data.allocData();

            size_t o_widht = getOutputParams().dims[0];
            size_t o_depth = getOutputParams().dims[2];
            size_t o_height = getOutputParams().dims[1];

            for (size_t i = 0; i < o_height; i++) // slowest chaning is height
            {
                for (size_t j = 0; j < o_widht; j++) // next fastest changing is widht
                {
                    for (size_t k = 0; k < o_depth; k++) // so fastest chaning is depth
                    {
                        // image_w * image_d * height_idx + image_d * width_idx + depth_idx;
                        i8 temp = getOutputData().get<i8>(o_widht * o_height * k + o_widht * i + j);

                        reordered_data.get<i8>(o_depth * o_widht * i + o_depth * j + k) = temp; // DEPTH * WIDHT * (c_h) + DEPTH * (c_w) + c_d
                    }
                }
                
            }
            getOutputData() = reordered_data;

            reordered_data.freeData();
        }
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
