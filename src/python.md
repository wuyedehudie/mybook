- python编码

## 面向对象
- _init_:
- _new_ 调用发生在_init_前
- _str_ 用于用户友好的字符串表示
- _repr_ 用于开发的字符串表示，用于调试 
- _len_(m_self) 定义对象长度
- self 约定的名称指代实例本身，用于方法对象的属性方法
```
class Dog(animal):
    def __init__(self, name):
        self.name = name
    def bark(self):
        print(f"{self.name} says woof!")
```

- flask, Django
- 爬虫类型：通用、聚集网络、增量式、deep Web爬虫

## 微服务

### 网站架构
- ssh, SSM
### 微服务架构和SOA架构
通信协议：微服务（SOAP），SOA(RESTfulAPI)
微服务发现工具（Consul、Eureka）
spring cloud 使用RESTful, 可以兼容python,php开发的功能
### dockker