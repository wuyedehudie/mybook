事件循环
reactor模式

注册事件处理器（Event Handler）：

在使用 Muduo 编写网络应用时，你需要注册事件处理器来处理各种事件，如读事件、写事件、连接事件等。
例如，你可以通过调用 Channel 类的成员函数 setReadCallback()、setWriteCallback() 等来注册事件处理器。
- 事件循环（Event Loop）：
Muduo 中的事件循环负责监听并处理发生在文件描述符上的事件。
主要的事件循环位于 EventLoop 类中，它会在一个循环中不断地调用系统的 I/O 多路复用机制（如 epoll、kqueue）来监听文件描述符上的事件。
- 事件分发（Event Dispatching）：
当有事件发生时（如有新的连接到来、有数据可读、连接关闭等），系统会通知 Muduo 中的事件循环。
事件循环会根据发生的事件类型，在注册的事件处理器中查找对应的回调函数。
回调函数的执行：

一旦找到了对应的事件处理器，事件循环会调用该事件处理器中注册的回调函数来处理事件。
回调函数通常是你自己定义的，用于处理特定事件的逻辑，比如处理接收到的数据、处理新的连接等。
事件处理：

回调函数执行相应的事件处理逻辑，比如读取数据、发送数据、关闭连接等。
在处理完事件后，事件循环会继续监听下一个事件，并调用相应的回调函数。

- boost/any.hpp :boost::any var;//允许赋值任意一种类型
- iovec 是在 UNIX 和类 UNIX 系统上进行 I/O 操作时使用的一个数据结构。它通常用于在 I/O 操作（如读取或写入）中提供多个缓冲区的数据结构信息。
- struct msghdr 是在 UNIX 和类 UNIX 操作系统上用于进行系统调用（如 recvmsg() 和 sendmsg()）时，传递消息头信息的数据结构。

net命名空间
---
inetAddress 
