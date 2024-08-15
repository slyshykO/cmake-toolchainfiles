cmake_minimum_required(VERSION 3.6.0)

project(test-app C CXX ASM)
set(TARGET_ELF ${PROJECT_NAME}.elf)

set(CMAKE_VERBOSE_MAKEFILE ON)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(HAL_DIR d:/projects/cpplibs/mcu/stm32/cube/STM32Cube_FW_F4_V1.23.0)
set(LD_FILE ${CMAKE_CURRENT_SOURCE_DIR}/STM32F401VEHx_FLASH.ld)

set(SRC_LIST main.cpp
    system_stm32f4xx.c
    simple.c 
    startup_stm32f401xe.S)

add_executable(${TARGET_ELF} ${SRC_LIST})

target_compile_definitions(${TARGET_ELF}
        PRIVATE
            STM32F401xC
)

target_include_directories(${TARGET_ELF}
        PRIVATE
            $<BUILD_INTERFACE:${HAL_DIR}/Drivers/CMSIS/Include>
            $<BUILD_INTERFACE:${HAL_DIR}/Drivers/STM32F4xx_HAL_Driver/Inc>
            $<BUILD_INTERFACE:${HAL_DIR}/Drivers/CMSIS/Device/ST/STM32F4xx/Include>
    )

target_link_options(${TARGET_ELF}
    PRIVATE
    -specs=nano.specs -specs=rdimon.specs
    -Wl,-Map=${PROJECT_NAME}.map,--cref -T ${LD_FILE}

)

add_custom_command(TARGET ${TARGET_ELF} POST_BUILD COMMAND ${CMAKE_OBJCOPY} -O ihex "${CMAKE_CURRENT_BINARY_DIR}/${TARGET_ELF}" "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.hex")
add_custom_command(TARGET ${TARGET_ELF} POST_BUILD COMMAND ${CMAKE_OBJCOPY} -O binary "${CMAKE_CURRENT_BINARY_DIR}/${TARGET_ELF}" "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.bin")
add_custom_command(TARGET ${TARGET_ELF} POST_BUILD COMMAND ${CMAKE_OBJDUMP} -x -D -S -s ${TARGET_ELF} | "\"${CMAKE_CPPFILT}\"" > ${PROJECT_NAME}.lss WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
