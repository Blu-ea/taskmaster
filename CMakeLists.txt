cmake_minimum_required(VERSION 3.10...3.31)

project(TaskManager)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED True)

include(FetchContent)

FetchContent_Declare(
        yaml-cpp
        GIT_REPOSITORY https://github.com/jbeder/yaml-cpp.git
        GIT_TAG 0.8.0
)
FetchContent_MakeAvailable(yaml-cpp)

include_directories(incs)

add_executable( TaskManager
        srcs/main.cpp
        srcs/class/Config.cpp
        srcs/class/Service.cpp
        srcs/class/Controler.cpp
        srcs/Commands.cpp
        incs/Commands.hpp
        srcs/Commands/help.cpp
)

target_link_libraries(TaskManager PUBLIC yaml-cpp::yaml-cpp)
