## 前置
linux区分大小写
```echo "Hellow world"``` echo 打印函数

## 标题
## 创建一个脚本
创建一个.sh文件```vim test.sh```
启动.sh ```bash test.sh```


## 1.变量相关

### 1.1 shell变量
```
a=1, b="join",  //不需要类型声明
a=b             //
echo $a         //用$引用变量
unset a         //删除变量
set             //显示所有变量，太多默认的变量了，不好用。
```

### 1.2 特殊变量
Shell常见的变量之一系统变量，主要是用于对参数判断和命令返回值判断时使用，系统变量详解如下：
$0 		当前脚本的名称；
$n 		当前脚本的第n个参数,n=1,2,…9；
$* 		当前脚本的所有参数(不包括程序本身)；
$# 		当前脚本的参数个数(不包括程序本身)；
$? 		令或程序执行完后的状态，返回0表示执行成功；
$$ 		程序本身的PID号。

## 2.1命令
```
pwd   //显示当前的路径
ls    //显示当前目录的文件, -a参数也显示隐藏文件或目录
find /path -name "name"     //查找文件
```

### 2.2find详细的用法
find 
sudo find /home -type f -name "tesh.sh"  # 只搜索普通文件
sudo find /home -type d -name "directory_name"  # 只搜索目录




## 语法
语句：
````
# 提示用户输入一个数字
echo "Enter a number: "
read num

# 判断数字的正负性，并输出相应的消息
if [ $num -gt 0 ]; then
    echo "$num is positive"
elif [ $num -lt 0 ]; then
    echo "$num is negative"
else
    echo "$num is zero"
fi
```