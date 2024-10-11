自用学习记录和部分使用经验
- 简单介绍cmake：cmake是跨平台构建工具，生成特定平台和编译器的Makefile、项目工程或工程文件。makefile描述源代码文件之间的依赖关系，描述如何将它们编译成可执行程序。
- 一个cmakeList生成项目最基础需要描述cmake最低版本、c++版本、可执行文件，加上自己头文件的路径和外部头文件的路径。进阶的用法就是了解一些变量使用，方便大型项目的依赖管理。

### 一.基础描述项目的部分
```cmake_minimum_requried()```描述cmake工具的最低版本
```project(name)```(可选）项目名
```set(CMAKE_CXX_STANDARD 17)```
```include_diretory(dir) ```//程序需要找文件时会搜索的目录，头文件、库文件、源文件等都可以查找
- cmake用##来注释

### 二.定义可执行文件或者库文件（下面简称目标）
- ```add_executable(target,main.cpp)```target为可执行程序名，main.cpp是所需文件，可以添加多个，如果目标是库文件，可以不带main函数入口。没有可执行程序名的时候可能不会报错，编译器找不到执行目标，无法运行a
- ```add_library(target,path) ```增加库

### 三.为可执行文件或者库文件添加依赖 
```
add_dependencies(target,target1,target2)      //添加目标所需的其他目标
target_include_directories(target,dir)        //添加目标所需的头文件目录
```

```target_link_library(target,PRIVATE,b) ```
- 添加所需要的库(静态库.lib或者.a文件，动态库.dll或.so文件)；不是自己用add_library()定义的库需要时，b为指定库的路径，如target_link_library(target,path/name.dll)；PRIVATE关键字表示只能将该库链接到该目标，不会让目标所依赖的其他目标被链接

### 四,变量
```
aux_source_directory(. DIR_SRCS)              //.指当前目录，可以设置成其他目录，DIR_SRCS是变量名，表示将该目录下的所有源文件（'.cpp''.cc''.cxx')赋值给DIR_SRCS，就不用麻烦写上所有源文件名了
add_executable(Demo ${DIR_SRCS})              

set(LIB_SRC
    1.cc
    2.cc
)           //LIB_SRC是变量名,常见定义变量的方式，LIB_SRC用于目标的依赖文件
set(LIBS
    target1
    target2
    .dll
)           
```
##### 部分默认变量
- ```${PROJECT_SOURCE_DIR}```, 用project()定义了项目后该CmakeList.txt所在目录
- ```${CMAKE_BINARY_DIR}```，bin目录
- ```${CMAKE_CURRENT_BINARY_DIR}```，当前CmakeList所在目录,当前cmakeList可能是子模块的cmakeList，大多时候该变量和${PROJECT_SOURCE_DIR}, 相同);
- ```${CMAKE_MODULE_PATH}```, 指向CMake模块文件的目录列表

### 五.函数

```
option(BUILD_TEST "ON for complile test" OFF)，BUILD_TEST是变量，“ON for compile test"是说明，OFF相当于bool的false
if(BUILD_TEST)
add_executable(test,...);   //便捷地决定是否编译某个东西
endif
```
```
configure_file (
  "${PROJECT_SOURCE_DIR}/config.h.in"       //自己的config模板
  "${PROJECT_BINARY_DIR}/config.h"          //自动生成，可以在其他源代码里使用，常见用法是定义一些环境宏定义，其他源代码可以使用该宏定义，比如window还是linux平台的宏定义
  )
```

### 其他
```
add_subdirectory(math)  //在当前目录（CmakekList所在目录）下找到math目录，以math目录下的CmakeList构建子项目
install 安装某文件（可执行文件或库文件）到系统目录
```
- Cmake模块
1.Cmake模块包含CMake命令和函数的脚本文件,名字格式name.cmake, 可以被CMakeList.txt引用
2.Cmake提供默认模块文件，用于执行常见的任务如查找标准库，查找第三方库，设置编译选项等
3.Cmake函数:
```
function(name_add_executable target srcs depends libs)  //name_add_executable函数名, srcs可执行文件的源文件变量， 可执行文件依赖的库列表 
    add_executable(${targetname} ${srcs})
    add_dependencies(${targetname} ${depends})
    force_redefine_file_macro_for_sources(${targetname})
    target_link_libraries(${targetname} ${libs})
endfunction()   //用于简化可执行文件添加过程
```

## 报错：
undefined reference
如果依赖的头文件和源文件被设置成变量set()，还需要变量添加到add_execut

其他：检查大小写、名字是否完全一致、是不是名字很像的几个弄混了