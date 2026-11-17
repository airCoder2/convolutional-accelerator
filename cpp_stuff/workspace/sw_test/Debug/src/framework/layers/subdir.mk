################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/framework/layers/Convolutional.cpp \
../src/framework/layers/Dense.cpp \
../src/framework/layers/Flatten.cpp \
../src/framework/layers/Layer.cpp \
../src/framework/layers/MaxPooling.cpp 

OBJS += \
./src/framework/layers/Convolutional.o \
./src/framework/layers/Dense.o \
./src/framework/layers/Flatten.o \
./src/framework/layers/Layer.o \
./src/framework/layers/MaxPooling.o 

CPP_DEPS += \
./src/framework/layers/Convolutional.d \
./src/framework/layers/Dense.d \
./src/framework/layers/Flatten.d \
./src/framework/layers/Layer.d \
./src/framework/layers/MaxPooling.d 


# Each subdirectory must supply rules for building sources it contributes
src/framework/layers/%.o: ../src/framework/layers/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 g++ compiler'
	arm-none-eabi-g++ -DZEDBOARD -Wall -O0 -g3 -I../src/framework -I../src/zedboard -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -std=c++17 -O3 -I/home/umhaihl/machine_learning/lab7/cpp_stuff/workspace/sw_test_platform/export/sw_test_platform/sw/sw_test_platform/standalone_domain/bspinclude/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


