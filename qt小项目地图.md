提示，该项目为学校作业，仅做了四五天就糊弄完了，很多都用gpt省事
因为懒所以项目有点乱，不过用来参考的话应该时足够的。希望不要苛求

## qt基础使用
- F4 头文件和源文件转换
- 项目视图，类视图，文件视图，刚开始时用文件视图比较符合新手习惯
- qt creator作为ide而言，对bug或者代码加载会比较慢。如果有bug提示什么的先多构建或者运行一下，或者清除重新构建一下
- src.qrc

### qt designer
- 也叫qt设计师界面，是qt为了方便界面设计ui所用工具。.ui文件对应一个类object，也就对应一个头文件。在设计师界面拖拽的组件例如一个Widget等其实就是在这个类里添加了一个Widget成员，可以通过object->Widget_Name()来调用，如果是一个text文本输入组件，就可以通过这样的形式获取输入的事件
- 对组件右键菜单样式表
- 布局，最大最小设置
- 各类widget
调用方式, ui->xxx
- 样式表 

cmakeList.txt

### qt类类型
了解一个框架最直接方法就是看类的使用。拿QPushButton举例，在设计师界面拖拽一个QPushButton，右键它在菜单上可以看到“转到槽”字样，点击之后则会出现该类以及它继承的类的信号函数，在QPushButton最常用的信号函数clicked里，后则会自动生成

### 信号机制
使用信号机制可以方便地将qt事件和自定义函数连接起来，例如需要在按钮点击后，触发自定义的函数时可以利用信号机制
- connect(&object1,object::funtion1,&object2,object::funtion);funtion1为信号函数，funton2为槽函数，注意funtion不需要括号，只需要写名字即可。
```
//在object1，声明为信号函数
public:
    xxx
signals:
    void funtion1();
//在object2，声明为槽函数
slots:
    void fution2();
```
- 在任何地方可调用，当funtion1调用之后，会调用funtion2，
- 如果函数有参数，funtion1的参数会按顺序传递给funtiont2，所以funtion2的参数数量不能多于funtion1，没有参数则不需要考虑

### 重写事件
在Qt

## 需求整理

- 图片上嵌入一个可点击按钮
QGraphicsView可以放置图片
可以放入QGrapicsProxy,下面简称proxy，proxy通过setWidget()函数设置一个类似于

有一个坑
setWidget后，proxy的pos属性会被重置，

- 如何简单地获取选取地点
1.在需要的时候，统一从按钮中获取
2.每次点击，都修改某一个bool数组
无论怎样，我们需要对按钮给一个编号，让它对应哪一个数字。这样在

- 如何让信号

## 构建MVC思路
在这个项目里View负责ui的显示，model存储地点信息，controller负责接收View上按钮的点击和选择并将选择的路径同步到controller上

