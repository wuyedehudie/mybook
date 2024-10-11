依赖配置
一.完全卸载mysql并重装
```
1.sudo service mysql stop
2.sudo apt-get purge mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-*
3.sudo rm -rf /etc/mysql /var/lib/mysql
4.sudo apt-get autoremove
sudo apt-get autoclean
5.sudo apt-get install mysql-server
```
- 初始化mysql的引导
```
sudo mysql_secure_installation
```

- vmvare虚拟机mysql密码Bb_1122@

- 三.k创建数据库
```
create database TinyWeb;

USE TinyWeb;
CREATE TABLE user(
    username char(50) NULL,
    passwd char(50) NULL
)ENGINE=InnoDB;

INSERT INTO user(username,passwd) VALUES('wuye', 'a');
```
- 四.在main.cpp修改数据库登录名,密码,库名
string user = "wuye";
string passwd = "Bb_1122@";
string databasename = "TinyWeb";
- 五.安装mysql开发包
```
sudo apt-get install libmysqlclient-dev
```
- 六.make命令编译,在当前目录可以看到server可执行程序

运行./server        
检查ps aux | grep server
