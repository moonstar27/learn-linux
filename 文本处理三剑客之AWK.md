 # awk基本用法：
 
 gawk：模式扫描和处理语言 

awk [options] 'program' var=value file…   
awk [options] -f programfile var=value file…   
awk [options] 'BEGIN{action;… }pattern{action;… }END{action;… }' file ...   

awk程序可由：**BEGIN语句块、能够使用模式匹配的通用语句块、END语句块**，共3部分组成   
**program** 通常是被放在单引号中    
选项：   
**-F** “分隔符” 指明输入时用到的字段分隔符   
**-v** var=value 变量赋值   

#### 基本格式：awk [options] 'program' file… 可处理多个文件     
其中**Program**：包括**pattern{action statements;..}**   

**pattern和action**   
- pattern部分决定动作语句何时触发及触发事件
BEGIN,END 
> BEGIN 加表头  
END 加统计汇总  

- action statements对数据进行处理，放在{}内指明   
print, printf

分割符、域和记录
- awk执行时，由分隔符分隔的字段（域）标记$1,$2...$n称为域标识。$0
为所有域，注意：此时和shell中变量$符含义不同
- 文件的每一行称为记录
- 省略action，则默认执行 print $0 显示整行的操作
  
## awk工作原理

第一步：执行BEGIN{action;… }语句块中的语句   
第二步：从文件或标准输入(stdin)读取一行，然后执行pattern{ action;… }语句块，它逐行扫描文件，从第一行到最后一行重复这个过程，直到文件全部被读取完毕。   
第三步：当读至输入流末尾时，执行END{action;…}语句块

BEGIN语句块在awk开始从输入流中读取行之前被执行，这是一个可选的语句块，比如变量初始化、打印输出表格的表头等语句通常可以写在BEGIN语句块中   

END语句块在awk从输入流中读取完所有的行之后即被执行，比如打印所有行的分析结果这类信息汇总都是在END语句块中完成，它也是一个可选语句块

pattern语句块中的通用命令是最重要的部分，也是可选的。如果没有提供pattern语句块，则默认执行{ print }，即打印每一个读取到的行，awk读取的每一行都会执行该语句块

## print格式

##### print格式：print item1, item2, ...  
要点：  
- 逗号分隔符
- 输出item可以字符串，也可是数值；当前记录的字段、变量或awk的表达式
- 如省略item，相当于print $0
```
示例：
#BEGIN执行一次运算，不循环读入文件的内容
[root@centos7 ~]#awk 'BEGIN{print 1+2}' /etc/passwd 
3
#BEGIN开头读入一次，中间print全部内容，END结束读入文件后执行一次
[root@centos7 data]#awk 'BEGIN{print "start"}{print $0}END{print "byebye"}' /data/http.log 
start
AT 2018-11-03 13:54:43 httpd restarted
AT 2018-11-03 13:55:29 httpd restarted
AT 2018-11-03 14:02:00 httpd restarted
byebye

awk '{print "hello,awk"}'
awk -F: '{print}' /etc/passwd  #-F: 是以:为分隔符切割字段
awk -F: '{print "wang"}' /etc/passwd
awk -F: '{print $1}' /etc/passwd
awk -F: '{print $0}' /etc/passwd
awk -F: '{print $1"\t"$3}' /etc/passwd  #\t把切割出的字段中增加一个tab，注意""引号
grep "^UUID"/etc/fstab | awk '{print $2,$4}'

磁盘空间打印
df|awk '{print $1,$5}'   

打印用户名和UID
awk -F: '{print $1,$3}' /etc/passwd 
awk -F: '{print $1":"$3}' /etc/passwd #打印出结果中间增加:

有一文件如下格式，请提取”.sina.com.cn”前面的主机名部分并写入到回到该文件中
bash$cat ip_list.txt
1 test.sina.com.cn
2 www.sina.com.cn
…
999 z.sina.com.cn

取空格和.为字符分隔符，打印第二个字段，重定向到原文件
awk -F " ." '{print $2}'  ip_list.txt >> ip_list.txt
```

> 变量不用加$ 和引号，字符串需要加" "   
数学运算不用加引号，可直接运算，加引号变为字符串  

# awk变量

变量：内置和自定义变量 
系统变量|解释
:--|:--
$0      |当前记录（这个变量中存放着整个行的内容）
$1~$n   |当前记录的第n个字段，字段间由FS分隔
FS      |输入字段分隔符 默认是空格或Tab     
NF      |当前记录中的字段个数，就是有多少列
NR      |已经读出的记录数，就是行号，从1开始，如果有多个文件话，这个值也是不断累加中。
FNR     |当前记录数，与NR不同的是，这个值会是各个文件自己的行号
RS      |输入的记录分隔符， 默认为换行符
OFS     |输出字段分隔符， 默认也是空格  
ORS     |输出的记录分隔符，默认为换行符
FILENAME |当前输入文件的名字
ARGC    |命令行参数的个数
ARGV    |数组，保存的是命令行所给定的各参数

![awk](https://github.com/moonstar27/learn-linux/blob/master/awk.jpg?raw=true)

##### 自定义变量(区分字符大小写)  
- -v var=value  
- 在program中直接定义 
> 先定义变量再引用

```
示例：
-V 变量赋值

FS输入字段分隔符:
awk -v FS=":" '{print $1,$3}' /etc/passwd
引用FS变量 
awk -v FS=":" '{print $1FS$3}' /etc/passwd

引用shell变量
fs=:
awk -v FS=$fs '{print $1FS$3}' /etc/passwd #变量方式调用
awk -F$fs '{print $1FS$3}' /etc/passwd  #选项方式调用

OFS输出字段分隔符:
awk -v FS=":" -v OFS="+" '{print $1,$3}' /etc/passwd

调用shell变量
fs=:;awk -v FS=$fs -v OFS=$fs '{print $1,$3}' /etc/passwd

RS输入的记录分隔符:
awk -v RS=":" '{print $0}' /etc/passwd #不指定FS 默认空格为字段分隔符

ORS输出的记录分隔符:
awk -v RS=":" -v ORS="++" '{print $0}' /etc/passwd

NF当前记录中的字段个数:
awk -F:  '{print NF}' /etc/passwd
打印最后一行
awk -F:  '{print $NF}' /etc/passwd
打印倒数第二行
awk -F:  '{print $(NF-1)}' /etc/passwd
取光盘中rpm安装包的类型统计
`ls /mnt/Packages/*.rpm | awk -F. '{print $(NF-1)}'|sort |uniq -c`

NR已经读出的记录数:
awk -v RS=":" '{print NR,$0}' /etc/passwd
awk -F:  '{print NR,$1}' /etc/passwd /etc/group

FNR当前记录数:
awk -F: '{print FNR,$1}' /etc/passwd

FILENAME文件名:
awk -F: '{print FNR,FILENAME,$1}' /etc/passwd


ARGC命令行参数的个数:
参数为3个，指的是这个命令本身的参数个数，不是结果输出的个数
awk -F:  '{print ARGC}' /etc/passwd /etc/group

ARGV数组，保存的是命令行所给定的各参数:
awk:第0个数组
/etc/passwd:第1个数组
/etc/group:第2个数组
awk -F: '{print ARGV[1]}' /etc/passwd /etc/group  

自定义变量:
awk -v test='hello gawk' '{print test}' /etc/fstab
awk -v test='hello gawk' 'BEGIN{print test}'
awk 'BEGIN{test="hello,gawk";print test}' 
利用-f调用文件打印username和UID
cat awkscript
{print script,$1,$3}
awk -F: -f awkscript  /etc/passwd

取日志中的时间
分隔符为一个[或者一个空格
awk -F "[\[ ]" '{print $5}' /var/log/httpd/access_log

取磁盘空间利用率，利用扩展正则表达式  
df | awk -F "[[:space:]]+|%" '{print $5}'

变量赋值  
awk -F: '{name="nie";print $1,name}' /etc/passwd
```
> 引用变量时，变量前不需加$

# printf命令

##### 格式化输出：printf “FORMAT”, item1, item2, ...  
- 必须指定FORMAT格式符  
- 不会自动换行，需要显式给出换行控制符，\n  
- FORMAT中需要分别为后面每个item指定格式符  

**格式符**：与item一一对应

格式符 | 说明
---|---
%c | 显示字符的ASCII码
%d、%i | 显示十进制整数
%e、%E | 显示科学计数法数值
%f | 显示为浮点数
%g、%G | 以科学计数法或浮点形式显示数值
%s | 显示字符串
%u | 无符号整数
%% | 显示%自身

**修饰符**

修饰符 | 说明
---|---
#[.#] | 第一个数字控制显示的宽度；第二个#表示小数点后精度。例如 %3.1f
- | 左对齐（默认右对齐）例如 %-15s
+ | 显示数值的正负符号 例如 %+d

```
定义$1格式为字符串，注意\n换行
awk -F: '{printf "%s\n",$1}' /etc/passwd
root
bin
daemon

打印时$1按照左对齐并以字符串显示，$3以右对齐并以数字格式显示
awk -F: '{printf "%-20s %10d\n",$1,$3}' /etc/passwd
root                          0
bin                           1
daemon                        2

增加Username:为字符串打印$1
awk -F: '{printf "Username:%s\n",$1}' /etc/passwd
Username:root
Username:bin
Username:daemon

增加Username:为字符串打印$1，增加UID:为数字打印$3
awk -F: '{printf "Username:%s,UID:%d\n",$1,$3}' /etc/passwd
Username:root,UID:0
Username:bin,UID:1
Username:daemon,UID:2


增加Username:为字符串打印$1，增加UID:为数字打印$3,$1默认右对齐
awk -F: '{printf "Username:%15s,UID:%d\n",$1,$3}' /etc/passwd
Username:           root,UID:0
Username:            bin,UID:1
Username:         daemon,UID:2


增加Username:为字符串打印$1，增加UID:为数字打印$3,$1左对齐
awk -F: '{printf "Username:%-15s,UID:%d\n",$1,$3}' /etc/passwd
Username:root           ,UID:0
Username:bin            ,UID:1
Username:daemon         ,UID:2


将结果修饰成为表格样式
awk -F: 'BEGIN{print "|username|           |uid|\n----------------------------"}{printf "%-20s |%-5d|\n----------------------------\n", $1,$3}' /etc/passwd
|username|           |uid|
----------------------------
root                 |0    |
----------------------------
bin                  |1    |
----------------------------
```

# 操作符


操作符 | 说明
---|---
**算数操作符** | 
x+y | 加法
x-y | 减法
x*y | 乘法
x/y | 除法
x^y | 乘方
x%y | 取模余数
-x | 转换为负数
+x | 将字符串转换为数值
**赋值操作符** | 
= | 等于
+= | x=x+y
-= | x=x-y
*= | x=x*y
/= | x=x/y
%= | x=x%y
^= | x=x^y
++ | 自增运算 \++i是先计算，再操作、i++是先操作，再计算
-- | 自减运算 --i是先计算，再操作、i--是先操作，再计算
**比较操作符** | 
<|小于
\>|大于
<=|小于或等于
\>=|大于或等于
==|相等
!=|不相等
~|匹配
!~|不匹配
**模式匹配符** | 
~ | 左边是否和右边匹配，包含
!~ | 是否不匹配
**逻辑操作符** | 
&& | 与
\|\| | 或
! | 非

```
赋值运算符示例：

下面两语句有何不同  
先运算后打印  
awk 'BEGIN{i=0;print \++i,i}'  
1 1  
先打印后运算  
awk 'BEGIN{i=0;print i++,i}'  
0 1
```
```
模式匹配符示例：

匹配全文包括root字符的内容，包含也会匹配到
awk -F: '$0 ~ /root/{print $1}' /etc/passwd
root
operator

匹配开头为root的整行文件，默认为空格分隔符
awk '$0 ~ "^root"' /etc/passwd
root:x:0:0:root:/root:/bin/bash

匹配不包含root的行，默认为空格分隔符
awk '$0 !~ /root/' /etc/passwd
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin

匹配以:分隔符取出的UID是否为0的行
awk -F: '$3==0' /etc/passwd
root:x:0:0:root:/root:/bin/bash
```
```
逻辑操作符示例：

利用:分割的第三段UID条件判断打印UID大于0和UID小于1000的username和UID
awk -F: '$3>=0 && $3<1000{print $1,$3}' /etc/passwd  
root 0
bin 1
daemon 2

利用:分割的第三段UID条件判断打印UID等于0或者UID大于1000的username和UID
awk -F: '$3==0 || $3>1000{print $1,$3}' /etc/passwd
root 0
nfsnobody 65534
li 1001

利用:分割的第三段UID条件判断打印UID不等于0的username和UID（除root以为）
awk -F: '!($3==0){print $1,$3}' /etc/passwd
bin 1
daemon 2
adm 3

利用:分割的第三段UID条件判断打印UID不大于等于500的username和UID
awk -F: '!($3>=500){print $1,$3}' /etc/passwd
root 0
bin 1
daemon 2
```

条件表达式（三目表达式）
selector?if-true-expression:if-false-expression
```
示例：
利用:分割的第三段UID条件判断是否大于等于1000，如果是就利用变量usertype打印为Common User，如果不是打印为SysUser，并且使用printf打印左对齐的格式输出username和usertype
awk -F: '{$3>=1000?usertype="Common User":usertype="SysUser";{printf "%-15s %-s\n",$1,usertype}}' /etc/passwd
root            SysUser
bin             SysUser
daemon          SysUser
```

# awk PATTERN条件判断

PATTERN:根据pattern条件，过滤匹配的行，再做处理
- 如果未指定：空模式，匹配每一行
- /regular expression/：仅处理能够**正则表达式**匹配到的行，需要用/ /括起来  
- relational expression:   关系表达式，结果为“真”才会被处理  
真：结果为非0值，非空字符串  
假：结果为空字符串或0值
- line ranges：行范围  
startline,endline：/pat1/,/pat2/  不支持直接给出数字格式   
- BEGIN/END模式
BEGIN{}：仅在**开始处理文件中的文本之前**执行一次  
END{}：仅在**文本处理完成之后**执行一次  

```
示例：
取UUID开头的行，默认空格为分隔符
awk '/^UUID/{print $1,$2}' /etc/fstab 
UUID=d9c353b1-9e80-4937-b538-6088f983df78 /
UUID=f168a437-14bc-4eff-8704-9c3f1a3b2857 /boot
UUID=01cad516-0d81-4490-b986-0c2abdba2c43 swap
UUID=9d6576fe-6ef3-4e4a-bec8-0634480a0344 /usr

取不是以UUID开头的行，默认空格为分隔符
awk '!/^UUID/{print $0}' /etc/fstab 
#
# /etc/fstab

取以root开头到sync结尾的行范围，打印以:分割的第一段字符
awk -F: '/^root/,/^sync/{print $1}' /etc/passwd
root
bin
daemon
adm
lp
sync

取判断NR行号大于等于10到小于等于20之间的，以:分割的行号和第一段字符
awk -F: '(NR>=10 && NR<=20){print NR,$1}' /etc/passwd
10 operator
11 games
12 ftp
13 nobody

取0的反结果为真，所以打印文件内容，取1的反为假，不打印文件内容
awk '!0' /etc/passwd ; awk '!1' /etc/passwd

利用:分割的第三段UID条件判断打印UID大于1000的username和UID
awk -F: '$3>=1000{print $1,$3}' /etc/passwd
nfsnobody 65534
nie 1000
li 1001

利用:分割的最后一段字符包含/bin/bash条件判断打印username和/bin/bash
awk -F: '$NF=="/bin/bash"{print $1,$NF}' /etc/passwd
root /bin/bash
nie /bin/bash
li /bin/bash

利用:分割的最后一段字符包含以bash结尾的条件判断打印username和/bin/bash
awk -F: '$NF ~ /bash$/{print $1,$NF}' /etc/passwd

磁盘空间利用率
df | awk -F "[[:space:]]+|%" '/^\/dev\/sd/{print $1,$5}'

两种取远程连接IP地址的方法
ss -nt | awk -F"[[:space:]]+|:" '/ESTAB/{print $6}'
从后取IP
ss -nt | awk -F"[[:space:]]+|:" '/ESTAB/{print $(NF-2)}'

取远程连接IP大于等于3的IP地址
ss -nt | awk -F"[[:space:]]+|:" '/ESTAB/{print $(NF-2)}'|sort|uniq -c|awk '$1>=3{print $2}'

开始i为空，取反结果为真，第一行打印；第二行i不为空，取反结果为假，第二行不打印；以此类推
[root@centos7 ~]# seq 10 |awk 'i=!i'
1
3
5
7
9

取上个结果的反，结果为偶数
[root@centos7 ~]# seq 10 |awk '!(i=!i)'
2
4
6
8
10

开始i为真，取反结果为假，第一行不打印；第二行i为空，取反结果为真，第二行打印；以此类推
seq 10 |awk -v i=1 'i=!i'
2
4
6
8
10
```
# awk action动作

常用的action分类
- Expressions：算术，比较表达式等
- Control statements：if, while等
- Compound statements：组合语句
- input statements
- output statements：print等

# awk控制语句
{ statements;… } 组合语句  
if(condition) {statements;…}  
if(condition) {statements;…} else {statements;…}  
while(conditon) {statments;…}   
do {statements;…} while(condition)     
for(expr1;expr2;expr3) {statements;…}    
break   
continue   
delete array[index]   
delete array   
exit   

## awk控制语句if-else

语法：
- if(condition){statement;…}[else statement]   
- **if**(condition1){statement1}**else if**(condition2){statement2}**else**{statement3} 

使用场景：对awk取得的整行或某个字段做条件判断

```
多条件判断，与shell类似
awk -v score=66 'BEGIN{if(score <60){print"not good"}else if(score <=80){print "soso"}else{print "good"}}'
soso
awk -v score=36 'BEGIN{if(score <60){print"not good"}else if(score <=80){print "soso"}else{print "good"}}'
not good
awk -v score=87 'BEGIN{if(score <60){print"not good"}else if(score <=80){print "soso"}else{print "good"}}'
good

判断UID大于等于1000
awk -F: '{if($3>=1000)print $1,$3}' /etc/passwd
nfsnobody 65534
nie 1000
li 1001

判断最后一个字段是否等于/bin/bash,打印匹配的username
awk -F: '{if($NF=="/bin/bash")print $1}' /etc/passwd
root
nie
li

判断文件内容字段数量(列号)大于8，打印这些内容
awk '{if(NF>8)print $0}'  /etc/fstab 
# Created by anaconda on Sat Sep 22 10:06:19 2018

判断如果UID大于等于1000就打印common user，如果不是就打印root or sysuser
awk -F: '{if($3>=1000){printf "common user:%s\n",$1}else{printf "root or sysuser:%s\n",$1}}' /etc/passwd
root or sysuser:root
root or sysuser:bin
root or sysuser:daemon

取磁盘空间超过75的硬盘名称
df -h | awk -F% '/^\/dev/{print $1}' | awk '$NF >=75{print $1,$5}'
/dev/sda2 78

多条件判断变量值对应不同结果
awk 'BEGIN{test=100;if(test >90){print "very good"}else if(test >60){print "good"}else{print "no pass"}}'
very good
```

## awk控制语句while循环

语法：while(condition){statement;…}   
条件“真”，进入循环；条件“假”，退出循环   
使用场景：   
对一行内的多个字段逐一类似处理时使用  
对数组中的各元素逐一处理时使用  

```
以第一行的NF字段值为循环，依次统计每个字段的长度
awk -F: 'NR==1{i=1;while(i<=NF){print $i,length($i);i++}}' /etc/passwd
root 4
x 1
0 1
0 1
root 4
/root 5
/bin/bash 9

以任意个空格开头的linux16行的NF字段值为循环，依次统计每个字段的长度
awk '/^[[:space:]]*linux16/{i=1;while(i<=NF){print $i,length($i);i++}}' /etc/grub2.cfg 
linux16 7
/vmlinuz-3.10.0-862.el7.x86_64 30

以任意个空格开头的linux16行的NF字段值为循环，依次统计长度大于等于10个字符的字段的长度
awk '/^[[:space:]]*linux16/{i=1;while(i<=NF){if(length($i)>=10){print $i,length($i)};i++}}' /etc/grub2.cfg 
/vmlinuz-3.10.0-862.el7.x86_64 30
root=UUID=d9c353b1-9e80-4937-b538-6088f983df78 46

生成1000个随机数重定向到f1.txt
for i in {1..1000};do if [ $i -eq 1 ];then echo -e "$RANDOM\c" >>f1.txt;else echo -e ",$RANDOM\c" >>f1.txt;fi;done

给i赋值2,第一个数字作为初始值，即当最大值也当最小值，使用while循环，如果后面的值大于前一个就替换MAX值，如果后面的值小于前一个就替换MIN值，循环结束后输出
awk -F, '{i=2;max=$1;min=$1;while(i<=NF){if($i > max){max=$i}else if($i < min){min=$i};i++}}END{print "max="max,"min="min}' f1.txt 
max=32750 min=35
```
## awk控制语句do while循环

##### 语法：do {statement;…}while(condition)  
意义：无论真假，至少执行一次循环体，再判断后面的条件是否为真，为真继续执行，为假停止

```
初始值为0的sum，先进行一次循环自加，判断小于等于100，直到加到100才停止循环
awk 'BEGIN{sum=0;i=0;do{sum+=i;i++}while(i<=100)print sum}'
5050
```

## awk控制语句for循环

##### 语法：for(expr1;expr2;expr3) {statement;…}
常见用法：   
for(variable assignment;condition;iteration process)
{for-body} 

特殊用法：能够遍历数组中的元素   
语法：for(var in array) {for-body}   
```
使用for循环计算加到100的值
awk 'BEGIN{for(i=1;i<=100;i++)total+=i;print total}'
5050

利用for循环来统计每字段的长度
awk '/^[[:space:]]*linux16/{for(i=1;i<=NF;i++){print $i,length($i)}}' /etc/grub2.cfg 
linux16 7
/vmlinuz-3.10.0-862.el7.x86_64 30
root=UUID=d9c353b1-9e80-4937-b538-6088f983df78 46
```

## awk控制语句switch语句

##### 语法：switch(expression) {case VALUE1 or /REGEXP/: statement1; case VALUE2 or /REGEXP2/: statement2; ...; default: statementn}  
可以支持正则表达式  

**break和continue**
```
判断i=50，continue跳过当次循环，继续后面的循环
awk 'BEGIN{total=0;for(i=1;i<=100;i++){if(i==50)continue;total+=i};print total}'
5000

判断i=50，break结束后面的循环
awk 'BEGIN{total=0;for(i=1;i<=100;i++){if(i==50)break;total+=i};print total}'
1225

判断i的值是否可以整除2，可以的话就跳过当次循环，相当于取1--100的奇数之和
awk 'BEGIN{sum=0;for(i=1;i<=100;i++){if(i%2==0)continue;sum+=i}print sum}'
2500
```
**next**:   
提前结束对本行处理而直接进入下一行处理（awk自身循环）

```
判断行号是否可以整除2，如果可以就跳过当次，打印其它行，相当于打印奇数行
awk -F: '{if(NR%2==0)next;print NR,$0}' /etc/passwd
1 root:x:0:0:root:/root:/bin/bash
3 daemon:x:2:2:daemon:/sbin:/sbin/nologin
5 lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin

不同写法等同于上面的结果
awk -F: 'NR%2==1{print NR,$0}' /etc/passwd

判断行号是否不可以整除2，如果不可以就跳过当次，打印其它行，相当于打印偶数行
awk -F: '{if($3%2!=0)next;print $1,$3}' /etc/passwd
root 0
daemon 2
lp 4
```

# awk数组

##### 关联数组：array[index-expression]
index-expression:
- 可使用任意字符串；字符串要使用双引号括起来
- 如果某数组元素事先不存在，在引用时，awk会自动创建此元素，并将其值初始化为“空串”
- 若要判断数组中是否存在某元素，要使用“index in array”格式进行遍历

**若要遍历数组中的每个元素，要使用for循环**   
for(var in array) {for-body}   
注意：var会遍历array的每个索引   

```
利用数组方式打印
awk 'BEGIN{weekdays["mon"]="Monday";weekdays["tue"]="Tuesday";print weekdays["mon"]}'
Monday

[root@centos7 data]#cat f1
aaa
aaa
abc
ddd
ddd
zcd
bgd
zcd
[root@centos7 data]#awk '!link[$0]++' f1
aaa
abc
ddd
zcd
bgd
第一次读入的行没有赋值，所以为空，取反后为真，所以打印第一行内容，之后与同一行同样的内容已有值，取反后为假，所以不打印同内容行。
达到去重的效果

[root@centos7 data]#awk '{!link[$0]++;print $0,link[$0]}' f1
aaa 1
aaa 2
abc 1
ddd 1
ddd 2
zcd 1
bgd 1
zcd 2
同样内容的行会自加运算，所以可以去重

利用for循环打印weekdays的数组元素
awk 'BEGIN{weekdays["mon"]="Monday";weekdays["tue"]="Tuesday";for(i in weekdays){print weekdays[i]}}'
Tuesday
Monday

利用数组for循环统计链接状态信息
netstat -tan | awk '/^tcp/{state[$NF]++}END{for(i in state){print i,state[i]}}'
LISTEN 9
ESTABLISHED 2

利用数组for循环统计http访问次数
awk '{ip[$1]++}END{for(i in ip){print i,ip[i]}}' /var/log/httpd/access_log

利用数组for循环统计远程访问地址次数
ss -nt | awk -F"[[:space:]]+|:" '/ESTAB/{ip[$(NF-2)]++}END{for(i in ip){print i,ip[i]}}'
192.168.34.1 2

利用数组for循环统计文件系统格式
awk '/^UUID/{file[$3]++}END{for(i in file){print i,file[i]}}' /etc/fstab 
swap 1
xfs 3


cat score 
name  sex score
a     m    90
b	  f    80
c     f    99
d     m    88
利用数组for循环统计男女生平均分
awk 'NR>1{score[$2]+=$3;num[$2]++}END{for(i in score){print i,score[i]/num[i]}}' score 
m 89
f 89.5
```

# awk函数

#### 数值处理： 

rand()：返回0和1之间一个随机数   
#默认初始值固定0.237788   
需配合种子参数srand()生成真正的随机数  
```
生成0-100随机数
awk 'BEGIN{srand();print int(rand()*100)}'

生成10个随机整数
awk 'BEGIN{srand(); for (i=1;i<=10;i++)print int(rand()*100) }'
```
#### 字符串处理：
- length([s])：返回指定字符串的长度
- sub(r,s,[t])：对t字符串搜索r表示模式匹配的内容，并将**第一个匹配**内容替换为s  
`echo "2008:09:05 06:01:03" | awk 'sub(":","-",$1)'
2008-09:05 06:01:03`
- gsub(r,s,[t])：对t字符串进行搜索r表示的模式匹配的内容，并**全部替换**为s所表示的内容  
`echo "2008:09:05 06:01:03" | awk 'gsub(/:/,“-",$1)' 2008-09-05 06:01:03`
- split(s,array,[r])：以r为分隔符，切割字符串s，并将切割后的结果保存至array所表示的数组中，第一个索引值为1,第二个索引值为2,…   
```
以:为分隔符，切分字段，利用数组循环打印每段内容（注意打印顺序不按数字大小排列）
echo "2008:09:05 06:01:03" | awk '{split($0,str,":")}END{for(i in str){print i,str[i]}}'
4 01
5 03
1 2008
2 09
3 05 06

利用两组数组来统计远程链接IP,ip数组[1]取值为IP地址，ip[2]为端口号段
netstat -tn | awk '/^tcp/{split($5,ip,":");count[ip[1]]++}END{for(i in count){print i,count[i]}}'
192.168.34.1 1
```
## 自定义函数格式

定义函数的时候，()中的参数为形参，调用赋值的时候为实参  
function name (parameter, parameter, ...) {  
 statements  
 return expression  
}  

```
利用函数文件实现参数大小对比
函数意义:判断x是否大于y，如果是var等于x，不是var等于y，返回var的值

[root@centos7 data]#cat fun.awk
function max(x,y){
	x>y?var=x:var=y
	return var
}
BEGIN{print max(a,b)}

[root@centos7 data]#awk -v a="32" -v b="24" -f fun.awk
32
```
## awk中system命令调用shell命令

空格是awk中的字符串连接符，如果system中需要使用awk中的变量可以使用空格分隔，或者说除了awk的变量外其他一律用""引用起来

```
awk利用system调用hostname命令
awk 'BEGIN{system("hostname")}'
centos7.localdomain

awk利用system调用echo命令打印
awk 'BEGIN{score=100;system("echo your score is " score)}'
your score is 100

awk利用system调用ls命令显示一个变量，注意引号中的ls后的空格，需要与平时在shell中执行一样的格式，否则报错
awk 'BEGIN{dir="/boot";system("ls " dir)}'
config-3.10.0-862.el7.x86_64				 
grub2						
```
## awk脚本

将awk程序写成脚本，直接调用或执行

```
示例：
打印UID大于1000的username和UID
cat > f1.awk <<EOF
{if($3>=1000)print $1,$3}
EOF
awk -F: -f f1.awk /etc/passwd

利用awk脚本,赋予执行权限后，直接执行
[root@centos7 data]#cat f2.awk
#!/bin/awk -f
#this is awk script
{if($3>=1000){print $1,$3}}
[root@centos7 data]#chmod +x f2.awk
[root@centos7 data]#./f2.awk -F: /etc/passwd
nfsnobody 65534
nie 1000
li 1001
```

## 向awk脚本传递参数

**格式**：   
awkfile var=value var2=value2... Inputfile  

注意：**在BEGIN过程中不可用**。直到首行输入完成以后，变量才可用。可以通过-v参数，让awk在执行BEGIN之前得到变量的值。命令行中每一个指定的变量都需要一个-v参数

```
可以不使用-v定义变量
[root@centos7 data]#cat f2.awk
#!/bin/awk -f
#this is awk script
{if($3>=num){print $1,$3}}
[root@centos7 data]#./f2.awk -F: num=1000 /etc/passwd
nfsnobody 65534
nie 1000
li 1001

cat test.awk
#!/bin/awk –f
{if($3 >=min && $3<=max)print $1,$3}
chmod +x test.awk
test.awk -F: min=100 max=200 /etc/passwd
```
