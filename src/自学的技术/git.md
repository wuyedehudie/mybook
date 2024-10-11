工作区，暂存区
## 1. git基础
简单而言git用于保存项目，在项目根目录使用git应用程序保存项目代码，支持远程仓库github创建和提交。有版本回溯功能，有项目开发分支试验时合并的功能
### 1.1理论/知识点

- 暂存区只要文件修改了都可以用git add，不会有冗余的修改记录，只有用**git commit**的代码才有可回溯的提交记录。
>git reset --soft/hard/mixed
soft保留工作区和暂存区，hard都不保留，mixed仅保留工作区
>git diff --cathe//一般使用图形化工具


### 1.2 基础命令
速查
- ```git init```将文件夹（命令执行所在目录）初始化，其实是增加了一个.git文件
- ```git add filename```git add ./git add *txt   将文件添加到暂存区，相当于随手保存
- ```git status```文件状态，可以
- ```git commit```  
- ```git commit -a``` //跳过相当于使用了一次git add
- ```git branch```
- ```git log /git log --online```
- ```git rm --cache filename```     //只会删除暂存区内容，不会删除本地文件

### 1.3 文件状态
- **untracked** 没使用过任何git命令前的最原始的状态
- **modified**  
- **staged**
- **unmodified**
- 总结：
- **untracked**——```git add```——》**staged**
- **staged**——```git commit```——》**unmodified**
- 任一状态——任意修改——》**modified**
- **unmodified**——```git rm```——》**untracked**

### 1.4 简单创建一个远程仓库
先在github上创建一个远程仓库, 创建好后
> git remote add origin <remote_repository_url>
//先绑定远程仓库
>git push -u origin master
//上传
> **git push --set-upstream QTmusicPlayer master**
> **git push --set-upstream origin master**
>**git checkout -b main**//切换并创建分支main，然后推送到github默认的main分支上
>**git pull origin main --allow-unrelated-histories，**//**如果main仓库有你选择创建的readme.md文件（用第一个报错后），选择使用这个命令先把readme.md文件拉到本地仓库,在使用上述命令pull到远程仓库

## 2.具体实践
## 2.1 .gitignore忽略某些文件
- 在.git文件夹所在目录下创建一个.gitignore文件
```
# 示例：忽略编译生成的文件(就是忽略文件夹
build/
bin/
# 示例：忽略临时文件
temp/
# 忽略特定文件
filename
```
- 只要把文件名写在上面，用git add 将.gitignore添加上就可以。
- 注意如果在创建.gitignore之前就已经对某文件用了```git add```，需要用```git rm --cached filename```将文件从缓存里删除，之后用```git status```会看到该文件不会出现在文件状态里
### 
```git config --list --show-origin```配置
```git config <key>```查找某个配置的值
```git confit --globa  user.email "xxx"``` 设置全局邮件

- git push时，空文件夹不会提交

## 3. 团队协作git流程
负责人a，团队成员b、c
- a
先创建远程仓库，把基础代码上传。在github上邀请成员b,c
- b，c
git clone
git pull 确保最新
先用git pull origion xxxx，在该xxx分支进行开发。
- b 先开发完他的分支
尝试合并主分支后，发送pull request
- a
检查和测试
- c
有两个选择，如果开发时间较短，可以先开发完当前分支

### 3.1 其他问题
- 多个PR（pull request）时，使用CI/CD自动化工具，在PR后自动进行，如果有问题会标记冲突，让开发人员解决冲突。多个PR涉及同一模块时，可以优先合并冲突最少的PR，剩余PR开发人员自己解决冲突，重新提交

### 3.2 git冲突类型
- 同一文件冲突
- 重命名冲突


## 4. 项目开发
### 4.1 cmake项目团队与模块化
- 每个模块有自己的cmakeList，主程序文件由test文件代替
- 主CmakeList 用add_subdirectory()
- 

### 4.2 开发风险
工期拖延
需求变化
人员跳槽
新技术

### 4.3 项目开发模型
瀑布模型，渐增式模型
- 基于组件的开发模型
寻找Find, Select, Adapt, Create, 组装Compose，替代RePlace


## 暂存区
- 暂存区只要文件修改了都可以用git add，不会有冗余的修改记录，只有用**git commit**的代码才有可回溯的提交记录。
>git reset --soft/hard/mixed
soft保留工作区和暂存区，hard都不保留，mixed仅保留工作区
>git diff --cathe//一般使用图形化工具

远程仓库
----
先在github上创建一个远程仓库, 创建好后
> git remote add origin <remote_repository_url>
//先绑定远程仓库
>git push -u origin master
//上传
> **git push --set-upstream QTmusicPlayer master**
> **git push --set-upstream origin master**
>**git checkout -b main**//切换并创建分支main，然后推送到github默认的main分支上
>**git pull origin main --allow-unrelated-histories，**//**如果main仓库有你选择创建的readme.md文件（用第一个报错后），选择使用这个命令先把readme.md文件拉到本地仓库,在使用上述命令pull到远程仓库

## 忽略某些文件
在.git文件夹所在目录下创建一个.gitignore文件
```
# 示例：忽略编译生成的文件
build/
bin/
# 示例：忽略临时文件
temp/
# 忽略特定文件
filename
```
- 只要把文件名写在上面，用git add将.gitignore添加上就可以。
- 注意如果在创建.gitignore之前就已经对某文件用了```git add```，需要用```git rm --cached filename```将文件从缓存里删除，之后用```git status```会看到该文件不会出现在

1.6
```git config --list --show-origin```配置
```git config <key>```查找某个配置的值


