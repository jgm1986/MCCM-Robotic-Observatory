cmake_minimum_required(VERSION 2.8)
PROJECT(indi_plcdome C CXX)

LIST(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake_modules/")
LIST(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../cmake_modules/")
include(GNUInstallDirs)

set(CMAKE_CXX_FLAGS "-std=c++0x ${CMAKE_CXX_FLAGS}")

set(INDI_PLCDOME_VERSION_MAJOR 1)
set(INDI_PLCDOME_VERSION_MINOR 1)

find_package(INDI REQUIRED)
find_package(ZLIB REQUIRED)
find_package(Nova REQUIRED)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config.h )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/indi_plcdome.xml.cmake ${CMAKE_CURRENT_BINARY_DIR}/indi_plcdome.xml )

include_directories( ${CMAKE_CURRENT_BINARY_DIR})
include_directories( ${CMAKE_CURRENT_SOURCE_DIR})
include_directories( ${INDI_INCLUDE_DIR})
include_directories( ${NOVA_INCLUDE_DIR})

########### PLC Dome ###########
set(indiplcdome_SRCS
   ${CMAKE_CURRENT_SOURCE_DIR}/plcdomedriver.c
   ${CMAKE_CURRENT_SOURCE_DIR}/plcdome.cpp
   )

add_executable(indi_plcdome ${indiplcdome_SRCS})

target_link_libraries(indi_plcdome ${INDI_LIBRARIES} ${NOVA_LIBRARIES})

install(TARGETS indi_plcdome RUNTIME DESTINATION bin )

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/indi_plcdome.xml DESTINATION ${INDI_DATA_DIR})
