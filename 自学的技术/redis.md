图形化界面Redisinsight
连接本地数据库服务

常用命令
>SET key value
>GET key
>DEL key
>EXISTS key
>KEYS *
>FLUSHALL//删除所有键对
>clear

> 键的值可以设成中文，但使用get会返回ascii码,即中文的二进制表示
进入客户端时，使用**redis-cli --raw**进入客户端，可以显示数据原始形式，即显示中文

>**TTL key**//查看过期时间，-1表示没有设置过期时间，返回-2表示已经过期，过期的数据使用KEYS key查看不了
>**EXPIRE key time**time单位是秒，或者使用**SETEX**代替
>**SETNX key value**//当键不存在时设立

本地安装
- 切换到安装的本地目录
- 打开服务，修改redis为本地服务
- 将redis添加到环境变量