## 杂项细节
```Thread(const Thread&) = delete;```删除拷贝构造
```Thread& operator=(const Thread&)=delete;```
socket调用bind时才使用::socket初始化套接字

sylar的Thread::run里

## 1.1客户端和服务端的tcp通信时，函数调用顺序：
**0**.服务器```bind(server_fd,addr,addrlen)```
**1**.服务器```listen(fd,num)```, 在服务器调用 listen() 函数后，服务器将套接字标记为监听状态，并开始监听传入的连接请求。第二个参数是连接请求的最大数量，
循环{
**2**.客户端```connect()```， 发送一个连接请求（SYN包）到服务器。服务器对于的文件描述符fd会有读事件产生    
**3**.服务器```accetp(serverfd,)```，它会等待并接受客户端的连接请求。一旦有连接请求到达，服务器会回复客户端一个确认连接的响应（SYN-ACK包），客户端收到（SYN-ACK包），再次发送(AcK)确认包到服务器，服务器收到之后连接建立完成。函数返回值是新创建的对应客户端的文件描述符
此后则是请求资源过程
**4**.客户端```send()```正式发送请求信息，底层实现是请求信息会被存到客户端的发送缓存区上，再由客户端的操作系统中的网络协议栈赋值发送到服务端的接收缓存区当中。要考虑发送数据的大小。
**5**.服务段```recv()```收到客户端的请求
**6**.服务端```send()```发送响应
**7**.客户端```recv()```收到服务器资源
}
### 1.2 服务端和客户端使用的系统调用
- 服务端
```bind()```
```listen()```
```accept```
- 客户端
```bind()```
```connect()```
都用到的：
```::socket()```
```send()```
```recv()```

### 1.3 系统调用在开发中的细节

### 1.4 系统调用的参数的实际值
```AF_INET```表示IPv4，值为2
```AF_INET6```表示IPv6, 值为10
```SOCK_STREAM```表示TCP，值为1
```SOCK_DGAM```表示UDP, 值为2

### 1.5 socket选项，不常用看一下即可
用setsocket()
```SO_REUSEADDR```： 允许地址重用，即在同一端口上启动多个 Socket 进程。这对于服务器程序在关闭后立即重新启动而不需要等待一段时间以释放端口非常有用。
```SO_SNDBUF 和 SO_RCVBUF```： 设置发送和接收缓冲区的大小，用于控制数据的发送和接收速度。
```SO_KEEPALIVE```： 开启或关闭 Keep-Alive 机制，用于检测空闲连接并在需要时断开连接。
```TCP_NODELAY```： 禁用 Nagle 算法，允许小数据包的立即发送，从而降低延迟。
```SO_LINGER```： 控制 Socket 关闭时的行为，例如是否等待数据发送完毕再关闭 Socket。
```SO_REUSEPORT```： 允许多个 Socket 绑定到相同的端口，用于实现负载均衡和高可用性。
```TCP_KEEPIDLE```、```TCP_KEEPINTVL``` 和 ```TCP_KEEPCNT```： 用于设置 TCP Keep-Alive 探测包的参数，控制探测包发送的间隔和次数。
```IP_TTL``` 和 ```IPV6_UNICAST_HOPS```： 设置 IP 数据包的 TTL（Time-To-Live）值，用于控制数据包在网络中的最大生存时间。
```IP_MULTICAST_TTL``` 和 ```IPV6_MULTICAST_HOPS```： 设置组播数据包的 TTL 值，用于控制组播数据包在网络中的传播范围。
```SO_BINDTODEVICE```： 绑定 Socket 到指定的网络接口，用于多网卡系统。

## 基础概念和函数
### 2.1 文件描述符
头文件fcntl.h(file control); 
文件描述符的
文件描述符创建方式：
- 标准io函数库（open(), creat(), pipe(), dup(), dup2()）
- socket()

### 2.2 io操作
I/O 操作指的是 Input/Output 操作，即输入和输出操作。在计算机编程中，I/O 操作通常涉及到程序与外部设备（如磁盘、网络、键盘、显示器等）之间的数据交换。
**文件 I/O**： 读取和写入文件中的数据，包括打开文件、读取文件内容、写入数据到文件等操作。
**网络 I/O**： 通过网络进行数据传输，包括建立网络连接、发送和接收数据等操作。
**键盘输入**： 从键盘接收用户输入的数据。
**显示器输出**： 将数据输出到显示器上进行显示。
**串口通信**： 通过串口进行数据传输，用于连接外部设备。
**管道和套接字通信**： 进程间或者网络间通过管道或者套接字进行数据传输。
**设备 I/O**： 与硬件设备之间进行数据交换，如读取传感器数据、控制机器人运动等。


##epoll

### 2.2 epoll事件类型 
```EPOLLIN```文件描述符可读取, 当客户端使用connect()连接服务器时触发
```EPOLLOUT```文件描述符可写入，当缓冲区由满到不满变化时触发。可以理解为上一次输入的数据已经发送，通知有空间进行下一处数据发送
``EPOLLERR```文件描述符发生错误，
```EPOLLHUP```文件描述符被挂断，通常是连接断开

```EPOLLET```边缘触发模式, 状态改变时触发一次通知，需要一次性读取或写入完毕，否则不会触发事件通知
```EPOLLONESHOT```设置为一次性事件，只通知一次，再次重新设置```EPOLLONSHOT```才能再次触发

### 2.3 epoll提供函数
```epoll_create()```创建epoll实例，参数是epoll在内存里的大小，高版本会动态调整，不是0即可
```epoll_ctl(epfd,option,fd,struct epoll_event *event)```添加epoll事件, option可以是```EPOLL_CTL_ADD```添加该fd ```EPOLL_CTL_MOD``` ```EPOLLCTL_CTL_DEL```删除该fd
```epoll_wait()```


### 8.1 定时器

### 7.1 服务器实现思路


## 参考代码
```
#include <iostream>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

int main() {
    // 创建套接字
    int server_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (server_socket == -1) {
        std::cerr << "Failed to create socket\n";
        return 1;
    }

    // 绑定地址
    struct sockaddr_in server_address;
    server_address.sin_family = AF_INET;
    server_address.sin_port = htons(8080); // 监听端口8080
    server_address.sin_addr.s_addr = INADDR_ANY;
    if (bind(server_socket, (struct sockaddr *)&server_address, sizeof(server_address)) == -1) {
        std::cerr << "Failed to bind address\n";
        return 1;
    }

    // 开始监听连接
    if (listen(server_socket, 5) == -1) {
        std::cerr << "Failed to listen for connections\n";
        return 1;
    }

    std::cout << "Server listening on port 8080...\n";

    // 接受连接
    struct sockaddr_in client_address;
    socklen_t client_address_size = sizeof(client_address);
    int client_socket = accept(server_socket, (struct sockaddr *)&client_address, &client_address_size);
    if (client_socket == -1) {
        std::cerr << "Failed to accept connection\n";
        return 1;
    }

    // 打印连接信息
    char client_ip[INET_ADDRSTRLEN];
    inet_ntop(AF_INET, &client_address.sin_addr, client_ip, INET_ADDRSTRLEN);
    std::cout << "Connection accepted from " << client_ip << ":" << ntohs(client_address.sin_port) << "\n";

    // 关闭套接字
    close(client_socket);
    close(server_socket);

    return 0;
}
```

