GET_FILENAME_COMPONENT(STM32_CMAKE_DIR ${CMAKE_CURRENT_LIST_FILE} DIRECTORY)
SET(CMAKE_MODULE_PATH ${STM32_CMAKE_DIR} ${CMAKE_MODULE_PATH})

include(${STM32_CMAKE_DIR}/arm-gcc-toolchain.cmake)

set(MCU_ARCH        "-mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard")

set(COMMON_FLAGS    "-ffunction-sections -fdata-sections -Wall -Wextra")
set(DRIVER_FLAGS    "${MCU_ARCH} ${COMMON_FLAGS}")

SET(CMAKE_C_FLAGS   "${DRIVER_FLAGS}")
SET(CMAKE_CXX_FLAGS "${DRIVER_FLAGS} -fno-exceptions -fno-rtti -fno-unwind-tables -fno-non-call-exceptions -fno-use-cxa-atexit")
SET(CMAKE_ASM_FLAGS "${MCU_ARCH} -x assembler-with-cpp")

SET(CMAKE_MODULE_LINKER_FLAGS "${MCU_ARCH}")
SET(CMAKE_SHARED_LINKER_FLAGS "${MCU_ARCH}")