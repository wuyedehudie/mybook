dotnet --info
用官方安装软件安装完成之后，在命令行使用dotnet --info
在环境变量中有两个关于dotnet的条目，将不是x86的那一条向上移动，报错原因估计是找到了32位的dotnet程序就不找了，然后32位的又打不开


虚拟机网络设置
在vmvare右键运行中的主机，点击设置的网络适配器
Linux命令```service network restart```