### 编译器基本规则
创建变量就会分配空间， 
调用函数时会为函数的参数中是变量的参数会分配空间
简单理解堆和栈，堆是一个数组，或者理解成静态链表
程序说白了，就是对一些数据进行修改


## 各种关键字
noexcept 不抛出异常
```constexpr```用于声明常量表达式, 指示编译器在编译时计算表达式的值, 声明的变量必须在编译时求值，所以必须是常量表达式。onstexpr 还可以用于函数模板参数，从而可以在编译时对函数进行求值，而不仅仅是对常量进行求值。常量构造函数 C++11 中，constexpr 还可以用于构造函数，用于声明常量表达式构造函数，这样的构造函数可以在编译时求值，并且可以用于在编译时初始化常量表达式

### 模板
函数模板/类模板/
template <typename T>
T myFunction(T a, T b) {
    return a + b;
}
template <typenameT>
class MyTemplateClass{
    T myVariable;
}
Myclass<T>::funtional(T& name)
### 匿名函数
```[捕获列表](参数列表) -> 返回类型 { 函数体 }```


理论知识
---
- 有些编译器要求您使用特定的标记，让其支持部分C+11特性:g++-std=c++0x use_auto.cpp
- 强制类型转换只在表达式里转换，不会修改变量真正属性
- ```[[nodiscard]]``` 是 C++11 新增的属性（attribute），用于告诉编译器应该检查函数的返回值，并在调用函数时处理其返回值。如果你希望确保调用 check() 函数时不会忽略其返回值，可以使用 ```[[nodiscard]]``` 标记该函数。

```
const bool getbool(){}      //函数的返回值不可修改
bool getbool()const{return} //保证函数内部不可修改成员
```


实战过程的零散知识  
----
- 如果模板头文件没有c++文件引用它，它可能会被用c编译器编译
- ::sendmsg(m_sock, &msg, flags);//用::表示它是全局命名空间的函数，提高可读性


跨平台
---
- 条件编译
```
#ifdef _WIN32
#elif __linux__
#endif
```

标准库的函数或容器
----
- std::multimap 也是按照键（key）来组织和存储数据的，不同之处在于 std::multimap 允许键具有重复的值。
- std::funtional 
函数对象:
```
class MyFunctor {
public:
    // 重载 () 运算符
    int operator()(int a, int b) const {
        return a + b;
    }
};
MyFunctor functor;
int a = functor(3,4);
```
- funtional用法
```
#include <functional>
int add(int a, int b) {
    return a + b;
}
// 一个可调用对象（函数对象）
struct Substract {
    int operator()(int a, int b) const {
        return a - b;
    }
};
int main() {
    std::function<int(int, int)> func;
    func = add;
    std::cout << "add(3, 4): " << func(3, 4) << std::endl; // 输出 7

    Substract sub;
    func = sub;
    std::cout << "sub(8, 5): " << func(8, 5) << std::endl; // 输出 3

    func = [](int a, int b) { return a * b; };
    std::cout << "lambda(6, 7): " << func(6, 7) << std::endl; // 输出 42
    return 0;
}
```

inline内联函数：
---- 
- 函数调用改为直接函数代码的代码嵌入程序使用该函数的地方，就不需要函数调用过程中创造栈帧浪费时间，缺点是将代码嵌入程序需要更大的内存（如循环过程，内联函数就需要复制10次代码到内存区，如果函数调用只需要一份代码的内存区。）


继承与多态
------
>子类构造函数初始化父类私有变量：
>- 调用父类私有变量进行构造
>- 在构造函数中调用父类函数修改私有变量,如下面的代码
```
-ChildClass(int parentValue, int childValue) : ParentClass(parentValue) {}
```
- 子类在构造前先调用父类构造函数
- private关键字也对派生类进行限制，如果对析构函数使用private，外部不能delete该对象

数据类型
----
- _t表示是数据类型
size_t 无符号整数类型，不同系统上表示内存中对象的大小,也常用于表示数字长度，内存分配，字符串长度
- int32_t保证不同平台都是64位宽度
- 自动变量，静态变量(程序运行时创建，程序结束时销毁)，动态变量

## 内存模型相关
### 移动语义
移动语义可以相当于浅拷贝+源指针置空
浅拷贝就是遇到指针的成员变量时只复制指针，不复制指针指向的内容

- 传入的对象处于有效但未定义的状态，通常被称为移后源对象（Moved-From Object）
- 拷贝构造函数和移动构造函数
- std::move()是将对象标志为可移动状态, 如果有移动构造的话就会调用移动构造

#### 左值，右值，亡值
左值: 变量
纯右值表达式:字面量如常数, 匿名函数返回值[]{return1;}, 引用&a, 算数表达式a+b
亡值: 资源权将要被转移的```a=std::move(b)```中的b, ```int a{3}```中的3


```
//函数里在什么时候使用对象的拷贝构造函数情况
//拷贝两次
Myclass fun1(myclass a) {     //在传入参数a时，没有用到&，所以传进来是靠拷贝得来的a，
    //这里任一修改a, 随便写
    return a;                //返回值是Myclass, return a时函数还会拷贝一次, 原来的a会析构掉。如果编译器有返回值优化（Return Value Optimization，RVO），会直接将第一次拷贝直接构造到返回值的内存空间里, 只拷贝一次
}                                  
//拷贝一次
Myclass fun2(myclass& a){    //传的是引用，不用再拷贝a参数了
    //这里任一修改a
    return std::move(a);     //这里还是会拷贝一次, 返回的是a修改后的拷贝, 因为返回值是Myclass，而不是Myclass的引用
}
//没有拷贝
Myclass& fun3(myclass& a){
    //任一修改a
    return a;               //此时返回的是a修改后的引用
}
```
右值引用相关函数相关函数
```static_cast<int&&>(value)```强制转为右值引用

#### std::move使用例子
1.
```
 unique_ptr<Myclass> ptr1,ptr2;
 ptr2 = std::make_shared<Myclass>(*arg);
 ptr1=std::move(ptr1);
```
2. ```myClasses.push_back(std::move(tmp));``` 
```
右值指在表达式中只能出现在赋值号右边的值，它通常具有临时性质，表示无法被取地址的、即将被销毁或者不再被使用的值
e:&10;、&(x + y);、&fmin(x, y);右值不可取地址,上述三个会报错，所以是右值
int& ra = a;
左值引用和右值引用
- 临时创建的对象(没有声明的):在函数返回语句中，函数返回一个临时对象,可以是对象，也可以是变量；在类型中转换的临时对象
- 右值引用使用 && 符号声明，允许程序员访问临时创建的对象，并且允许移动语义，右值引用主要用于两个方面：移动语义和完美转发。
```
```
- 浅拷贝：其中仅复制对象的成员变量的值。对于包含指针的对象，浅拷贝将仅复制指针的值，而不会复制指针所指向的内容。
- 深拷贝：
深拷贝（Deep Copy）通常是指当一个对象包含指针成员变量时，对这些指针所指向的内存进行复制，而不是简单地复制指针本身。(需要手动写代码用new为指针分配内存空间)
```


### 原子性
即保证某些操作必须连续完成且过程不被骚扰，例如修改一个变量的值需要找地址，修改地址上的该变量值，多线程情况下可能出现一个线程a在取地址的过程中，另外一个线程b修改了该变量的值，导致线程a修改的不是原有的值。原子性的实现需要依赖处理器之类或者锁


## 指针
### 基础
```&```取地址符号 
```*```声明指针对象或者解引用
**引用**：```Myclass& b=a```, 此时的```b```相当于```&a```，因为引用没有存储空间，相当于```&a```的一个别名, 所以不能声明必须初始化
**解引用**：```*（地址）```这就是一个右值，如```*p```或者```&value```，其中p是指针变量，value是变量


### 普通指针    
- 指针基础声明
>- ```int *ptr```强调 *ptr是int类型,```int* ptr```则强调这是指向int类型的指针，实际都一样
>- int*pl,p2;//创建一个int类型指针和一个int类型变量
>- 指针长度一样，无论指向什么类型。。。
>- ```long fellow; *fe11ow=223323;```野指针
>- pt=(int*)0xB8000000;

>- 悬挂指针：指针原本指向的内存区域已经被释放或者未被初始化的指针。当指针指向的内存区域被释放后，指针仍然保留着之前指向的地址，这样的指针就成为悬挂指针。在使用悬挂指针时，由于指针所指向的内存已经被释放，访问该指针可能导致未定义的行为。
>- 野指针：指针未初始化或者指向了未知的内存区域，可能是任意值（包括0、无效地址或者已释放的地址等）。野指针通常是指没有被明确初始化或赋值的指针，在程序中引起未定义的行为。

### malloc和new
- 指针内存分配
> 1.new,分配在堆上
> 2.malloc和calloc，分配在堆上，需要用free释放
> 3.alloc,分配在栈上,在函数返回时自动释放

### 智能指针
#### 基础使用
首先，智能指针是一个模板类，头文件```#include <memory>```
- ```std::shared_ptr<T>``` 

两种创建方式
```std::shared_ptr<Myclass> ptr(new Myclass(*arg))```构造函数构造
```
std::shared_ptr<Myclass> ptr
std::make_shared<Myclass>(*arg)
```

- ```std::weak_ptr```
>- std::weak_ptr 也用于管理动态分配的内存资源，但它并不拥有所指向的对象。它主要用于解决由 std::shared_ptr 可能造成的强引用环（circular reference）问题。强引用环是指两个或多个对象相互持有彼此的 std::shared_ptr，导致它们之间形成循环引用，使得对象无法被正确地释放，从而造成内存泄漏。
>- std::weak_ptr 是一种弱引用，它不会增加对象的引用计数。它可以从 std::shared_ptr 创建，允许观察由 std::shared_ptr 管理的对象，但不会增加对象的引用计数。因此，即使存在 std::weak_ptr，所指向的对象也可以被释放。


--------------------
- 使用场景概述：需要对引用的资源进行共享的时候, 通常使用share_ptr。需要解决循环引用的时候

#### 底层原理相关
```std::shared_ptr```的计数是原子的，性能开销大。
### 智能指针代码案例
- ```tcs::socket::ptr sock = CreateTCPSocket();```如果函数返回一个临时智能指针对象，编译器会使用移动构造来将临时智能指针对象的资源权赋值给
- ```tcs::socket::ptr sock(CreateTCPSocket());```和```tcs::socket::ptr sock=CreateTCPSocket()```的效果是一样的。

```
tcs::socket::ptr sock1(new tcs::socket());
tcs::socket::ptr sock2(new tcs::socket());
// 深拷贝，引用计数增加
sock1 = sock2;
```

