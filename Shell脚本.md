#  shell脚本 
## 编程基础
bash ***.sh运行脚本  
算法+数据结构  
过程式  
对象式 大型项目
- 编程逻辑处理方式
顺序执行  
循环执行  
选择执行  
- **远程执行脚本**
```
将脚本scp xxx.sh ip:/var/www/html/拷贝到一台主机的网页目录下
访问这台主机的页面下载脚本 service httpd start 
ip/xxx.sh
在需要执行脚本的主机上运行
curl http://ip/xxx.sh|bash
这样就直接远程执行脚本
```

- shell:过程式、解释执行
```bash
格式要求：首行shebang机制
#!/bin/bash
#!/usr/bin/python
#!/bin/bash
# ------------------------------------------
# Filename: hello.sh
# Revision: 1.1
# Date: 2017/06/01
# Author: wang
# Email: wang@gmail.com
# Website: www.magedu.com
# Description: This is the first script
# ------------------------------------------
# Copyright: 2017 wang
# License: GPL
echo “hello world”
```
bash -n 检查错误  
bash -x 跟踪脚本执行过程

**脚本中不支持别名**

## 变量  
shell支持整数变量  
强类型  java、c#、Python  
弱类型  bash    

1. 不能使程序中的保留字：例如if, for   
1. 只能使用数字、字母及下划线，且不能以数字开头（不能使用-）  
1. 见名知义  
1. 驼峰法命名：变量名每单词首字母大写  

## 变量种类
- 局部变量：生效范围为当前shell进程；对当前shell之外的其它shell进程，
包括当前shell的子shell进程均无效  
- 环境（全局）变量：生效范围为当前shell进程及其子进程  
- 本地变量：生效范围为当前shell进程中某代码片断，通常指函数  
- 位置变量：$1, $2,...来表示，用于让脚本在脚本代码中调用通过命令行传递给它的参数  
- 特殊变量：$?, $0, $*, $@, $#,$$

cmd=hostname  
$cmd 可以调用命令 实现别名的效果   
定期删除内存变量 避免内存泄漏  

删除变量 **unset** name

**man bash** 查询系统变量  

显示当前进程号  
echo $$  
(echo $BASHPID)小括号子进程中和$$不同(更准确)    

**普通变量只对当前进程有效果**  

export 设置环境变量 不受父子进程影响  

(umask 026;touch /data/f1.log);touch /data/f2.log  
640 644  
**()会开启子shell,不影响默认shell设置**   
name=m34;(echo $name;name=net34;echo $name);echo $name  
m34 net34 m34  
name=m34;{ echo $name;name=net34;echo $name };echo $name  **注意空格**  
m34 net34 net34  
{}不开启子进程

**开启脚本后会运行在上一进程的子进程**  
SHLVL shell的嵌套层数  
$_ 上一个命令的最后一个字符串  

- 只读变量  
readonly
- 位置变量  
$1 $2 $3...**${10}**作为一整需要{}表示  
系统默认变量  
ip.sh eth0  eth1 $1=eth0 $2=eth1  

```
test_arg.sh {1..10} 
echo "1st arg is $1"
echo "2st arg is $2"
echo "10st arg is ${10}"
echo "all arg are $*"
echo "all arg are $@"
echo "the arg number is $#"
echo "the scriptname is `basename $0`"
```
`$*` 多脚本调用时会出现不能准确取出特定参数的情况，会认为前面的结果为一个整体参数  
`$@`多脚本调用时,每个参数独立可用  
`$@ $*` **只在被双引号包起来的时候才会有差异**  
`$?`只保存最后一个命令的结果  
返回0 表示成功 其它数字失败 1-255  
`ping -c1 -w1 IP` c次数 w时间  

## 算数运算
+, -, *, /, %取模(取余), **(乘方)
- let 功能强大
```
(1) let var=算术表达式
(2) var=$[算术表达式]
(3) var=$((算术表达式))
(4) var=$(expr arg1 arg2 arg3 ...)
(5) declare –i var = 数值
(6) echo ‘算术表达式’ | bc
```
- \++i先运算  i++后运算  
```
i=10;let j=i++;echo j=$j先赋值
j=10
i=10;let j=++i;echo j=$j先+再赋值
j=11
```  

- echo $[RANDOM%63+1]从1开始取到63  

## 逻辑运算
- 与 或  
```
true 1, false 0 
与:
1 与 1 = 1
1 与 0 = 0
0 与 1 = 0
0 与 0 = 0

或:
1 或 1 = 1
1 或 0 = 1
0 或 1 = 1
0 或 0 = 0

echo $[12&24] 与 8 
echo $[12|24] 或 28 

非:!
! 1 = 0 ! true
! 0 = 1 ! false

异或:^
异或的两个值,相同为假0,不同为真1

A=10;B=20;A=$[A^B];B=$[A^B];A=$[A^B];echo A=$A B=$B
A=20 B=10

```

- 短路与 短路或  
```
cmd1 与 cmd2 &
cmd1 为真 与 cmd2 结果 ？
cmd1 为假 或 cmd2 结果为假

cmd1 或 cmd2 |
cmd1 为真 或 cmd2 结果为真
cmd1  为假 或 cmd2 结果 ？

cmd1 短路与 cmd2 &&
如果cmd1 为真，执行cmd2
如果cmd1 为假，不执行cmd2

cmd1 短路或 cmd2  ||
如果cmd1 为真，不执行cmd2
如果cmd1 为假，执行cmd2
```
## 条件测试
```
test EXPRESSION
[ EXPRESSION ]
[[ EXPRESSION ]]
注意:EXPRESSION前后必须有空白字符

[ "$1" = "$2" ]中括号涉及到变量的时候注意两边空格和引号

username=user1;id $username &> /dev/null || useradd $username 判断是否user1存在，不存在创建用户

age=26; [ "$age" -gt 18 ] && echo "too old" || echo "young" 判断age大于18，打印命令
```

## Bash 测试方式

测试种类 | 说明
---|---
文件测试 | 存在性
**数值测试** | 
-gt | 是否大于
-ge | 是否大于等于
-eq | 是否等于
-ne | 是否不等于
-lt | 是否小于
-le | 是否小于等于
**字符测试** | 
= | 是否等于
`>` | ascii码是否大于ascii码
`<` | 是否小于
！= | 是否不等于
=～ | 左侧字符串是否能够被右侧的PATTERN所匹配。注意: 此表达式一般用于[[]]中;**扩展的正则表达式**
-z | 字符串是否为空,空为真,不空为假
-n | 字符串是否不空,不空为真,空为假
**文件测试** | 
-a、-e | 文件存在性测试,存在为真,否则为假
-b | 是否存在且为块设备文件
-c | 是否存在且为字符设备文件
-d | 是否存在且为目录文件
-f | 是否存在且为普通文件
-h | 是否存在且为符号链接文件
-p | 是否存在且为命名管道文件
-s | 是否存在且为套接字文件
**文件权限测试** | 
-r | 是否存在且可读
-w | 是否存在且可写
-x | 是否存在且可执行
-u | 是否存在且拥有suid权限
-g | 是否存在且拥有sgid权限
-k | 是否存在且拥有sticky权限
**文件属性测试** | 
-s | 是否存在且非空
-t | 文件描述符是否在某终端已经打开
-N | 文件自从上一次被读取之后是否被修改过
-O | 当前有效用户是否为文件属主
-G | 当前有效用户是否为文件属组
-ef | FILE1 -ef FILE2: FILE1是否是FILE2的硬链接
-nt | FILE1 -ef FILE2: FILE1是否新于FILE2(mtime)
-ot | FILE1 -ef FILE2: FILE1是否旧于FILE2(mtime)
**组合测试条件** | 
&& | COMMAND1 && COMMAND2 并且
|\|\| | COMMAND1 \|\| COMMAND2 或者
! | ! COMMAND 非
例如 | [ -f “$FILE” ] && [[ “$FILE”=~ .*\.sh$ ]]
**==-a==** | EXPRESSION1 -a EXPRESSION2 并且
**==-o==** | EXPRESSION1 -o EXPRESSION2 或者
! | 取反 EXPRESSION 
**注意** | [[ ]] 双中括号不支持-a -o
例如 | [ -z “$HOSTNAME” -o $HOSTNAME "=="localhost.localdomain" ] \&& hostname www.server ==注意中括号的空格==
例如 | [ -f /bin/cat -a -x /bin/cat ] && cat /etc/fstab 是否是普通文件并且拥有执行权限，如果是就打开/etc/fstab
**[[ == ]]  使用通配符和正则时使用**  
**\==后面可用通配符（不需加引号）  =~后面可用正则表达式（不需加引号） 扩展正则表达式**  
**()可以在子进程中执行命令**  
**{}只在当前shell中执行命令**  

## Read 提示输入命令
使用read来把输入值分配给一个或多个shell变量  
**建议每次一个变量**
```
read name age  
nie 20  
echo $name = nie  
echo $age = 20  
```
```
read -p "请输入姓名：" name
read -s -p "请输入密码" pass
echo 
echo your name is $name
echo your password is $pass
```
-p:制定要现实的提示  
-s：静默输入 密码等方式推荐使用  
-n：自定义输入位数 read -3 name  
-d:字符’ 输入结束符 read -d a name a作为结束符  
-t：超时时间N秒 read -t 10 name 10s结束 

`read i j k << "xx yy zz"` 一次给多个变赋值  

read 从标准输入中读取值,给每个单词分配一个变量  
**所有剩余单词都被分配给最后一个变量**

## Bash 命令执行优先级次序

1. 命令拆分单个命令词
2. 展开别名
3. 展开大括号声明（{}）
4. 展开波浪符声明(~)
5. 命令替换$() 和 ``)
6. 再次把命令行分成命令词
7. 展开文件通配(*、?、[abc]等等)
8. 准备I/0重导向(<、>)
9. 运行命令

## Bash配置文件

- 全局配置:
/etc/profile
/etc/profile.d/*.sh
/etc/bashrc
- 个人配置:
~/.bash_profile
~/.bashrc


登陆方式 | 说明 | 执行顺序 | 配置文件类型
---|---|---|---
交互式登录 | 直接通过终端输入账号密码登录 | 执行顺序:/etc/profile --> /etc/profile.d/*.sh --> ~/.bash_profile -->~/.bashrc --> /etc/bashrc | profile类:全局 /etc/profile, /etc/profile.d/*.sh、 个人 ~/.bash_profile
非交互式登录 | (1)su UserName、(2)图形界面下打开的终端、(3)执行脚本、(4)任何其它的。|执行顺序: /etc/profile.d/*.sh --> /etc/bashrc -->~/.bashrc | bashrc类:全局/etc/bashrc、个人~/.bashrc

修改profile和bashrc文件后需生效  
1重新启动shell进程  
2 . 或source
例:
. ~/.bashrc
