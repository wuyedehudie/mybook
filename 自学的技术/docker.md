## wsl
```wsl shutdown```




```docker run -it maxxing/compiler-dev /bin/bash```

镜像文件
容器虚拟化

添加镜像仓库"registry-mirror":["https://registry.docker-cn.com","https://docker.mirrors.ustc.edu.cn","https://docker.mirrors.ustc.edu.cn"],

基础命令
----
- docker ps //列出正在运行的容器
- docker pull redis:6.2
docker run --name my-redis-container -d -p 6379:6379 redis:6.2      //-p端口号，--name 设定容器名字

- docker login  //登陆docker账号
- docker scout quickview jrottenberg/ffmpeg //查看容器漏洞和建议


生成镜像
---
From xxxx; //基础镜像，一般用小且好用的centos
docker build -t test:v1 .   //build表示构建项目，-t设定版本名称，test:v1是用户自定义的版本名称（也叫tag），.表示当前目录

## 后台运行
如果Docker 容器基于一个镜像，但是该镜像中没有运行任何进程，那么容器会立即退出，并返回一个退出码。
docker run -itd --name=dibian debian /bin/bash


 
### 目录挂载
```docker run -it -v /d/docker/bind_directory:/home/wuye debian /bin/bash```




实际项目的使用
---

通常情况下，将 Docker 与应用程序一起打包成一个单独的可执行文件（.exe 或其他可执行格式）并不是常见的做法。Docker 是一种容器化技术，它的主要用途是将应用程序和其依赖项隔离在容器中，以确保应用程序在不同环境中具有一致性和可重复性。
在实际部署应用程序时，通常的做法是：
Docker 镜像：将应用程序及其依赖项打包到一个 Docker 镜像中。这个镜像可以在开发环境、测试环境和生产环境之间进行轻松迁移和部署。
容器编排：使用容器编排工具（如 Docker Compose、Kubernetes 等）来管理和部署多个容器化的应用程序和服务。这些工具可以自动化应用程序的扩展、更新和监控。
CI/CD 流程：将 Docker 镜像集成到持续集成/持续交付（CI/CD）流程中，以自动构建、测试和部署应用程序。这样可以确保每次代码更改都经过自动化测试并部署到目标环境。
分发容器镜像：将 Docker 镜像存储在容器注册表（如 Docker Hub、Amazon ECR、Google Container Registry 等）中，以便在不同的环境中轻松分发和部署应用程序。
将 Docker 与应用程序一起打包成一个单独的可执行文件可能会导致复杂性和性能问题，并且不符合容器化的最佳实践。通常，您应该将应用程序和容器化的依赖项作为独立的部分进行管理，并使用适当的工具来管理容器化应用程序的部署和运行。这种方式可以更好地利用容器化技术的优势，同时也更容易维护和管理应用程序。