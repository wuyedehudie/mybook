坑：.ui文件需要qt的Core模块，如果编译完成了但是没有界面，估计就是没有添加上这一模块。qt缺少模块不会报错, 头铁自学被卡了好久，所以最好先看一下qt文档
检查自己是否在同一个目标里依赖了两个有main（）函数的源文件，qt不会报错

## qt的cmake项目管理
- qt的项目视图是基于CmakeList的可执行目标来显示的，要添加子目录也需要包含的项目目录不会出现在项目视图里，它会根据可执行目标依赖的头文件和资源文件来进行分类，如果用cmake的话建议改为文件系统视图更符合平时的习惯
- 两种添加和管理模块（头文件和源文件）的方式：第一种用直接添加include_direcotory(), 虽然仍然可以使用这些头文件，但在；第二种是用子目录的形势
- pwd print worker directory，当前工作目录，$$PWD/作为默认CmakeList所在的根目录

```

```

### qt外部依赖:
```find_package(Qt6 6.4 REQUIRED COMPONENTS Core Quick Gui Widgets) ```
``` target_link_libraries(target Qt6::Widgets Qt6::Core...)```
子目录```target_include_directories(MyProject PRIVATE ${CMAKE_SOURCE_DIR}/include)```

### 自定义文件依赖配置：
```
set(CONTROLLER
    controller/controller.cpp
)
qt_add_executable(appmonitor_system
    view/mainview.cc
    view/mainview.h
    view/mainview.ui
    ${CONTROLLER}
    ${MODEL}
)
```

### 资源文件
**1.** 文件->新建文件(new file)->qt->Qt Resource File，最好建一个src文件专门放。
**2.** 在自己的qt_add_qml_module添加RESOURCES src/image.qrc
**3.** 注意不要放太大的文件，因为文件是相当于嵌入到.exe里的，太大的文件会崩溃
   Q_INIT_RESOURCE(WBoard);

## mvc结构
- model负责数据获取和处理，view负责界面和视图，controller负责界面和model之间的数据传输

## ui设计师界面

## 代码结构

```
if(${QT_VERSION} VERSION_LESS 6.1.0)
  set(BUNDLE_ID_OPTION MACOSX_BUNDLE_GUI_IDENTIFIER com.example.ticket_system)
endif()
set_target_properties(ticket_system PROPERTIES
    ${BUNDLE_ID_OPTION}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

```


## 踩坑

QgraphicsProxy 在调用setWidget()后，会重置自身的pos()，如果要保留原有的pos()，需要先存储pos()，然后在setWidget()之后重新设置pos()

## qt套件
%{Qt:QT_INSTALL_PREFIX}


## qt打包，windeployqt xx.exe


## 其他
-  监控平台相关第三方库和协议
```#include <libavformat/>```
rtsp协议
linux摄像头接口```#include <linux/videodev2.h>```

