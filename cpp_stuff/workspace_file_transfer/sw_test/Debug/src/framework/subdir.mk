################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/framework/main.cpp 

OBJS += \
./src/framework/main.o 

CPP_DEPS += \
./src/framework/main.d 


# Each subdirectory must supply rules for building sources it contributes
src/framework/%.o: ../src/framework/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 g++ compiler'
	arm-none-eabi-g++ -DZEDBOARD -Wall -O0 -g3 -I../src/framework -I../src/zedboard -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -std=c++17 -O3 -I/home/umhaihl/machine_learning/lab7/cpp_stuff/workspace_file_transfer/sw_test_platform/export/sw_test_platform/sw/sw_test_platform/standalone_domain/bspinclude/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


