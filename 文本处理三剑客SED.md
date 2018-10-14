# 文本处理三剑客SED
sed是一种流编辑器,它一次处理一行内容。处理时,把当前处理的行存储在临时
缓冲区中,称为“模式空间”(pattern space),接着用sed命令处理缓冲区中的
内容,处理完成后,把缓冲区的内容送往屏幕。然后读入下行,执行下一个循环。  
主要用来自动编辑一个或多个文件,简化对文件的反复操作,编写转换程序等。

## sed用法
sed [option]... 'script' inputfile...
```
常用选项:
-n:不输出模式空间内容到屏幕,即不自动打印
-e:多点编辑
-f /PATH/SCRIPT_FILE:从指定文件中读取编辑脚本
-r:支持使用扩展正则表达式
-i.bak:备份文件并原处编辑

script:'地址命令'
```
## 地址定界

地址范围 | 说明
---|---
不给地址 | 对全文进行处理
单地址 | #:指定的行,$:最后一行
正则表达式 |/pattern/:被此处模式所能够匹配到的每一行
地址范围 | #,#、#,+#、/pat1/,/pat2/ `sed -n '/^ftp/,/^sa/p' /etc/passwd`、#,/pat1/
~步进 | `1~2 奇数行、2~2 偶数行` `sed -n '1~2p'`

## 编辑命令

命令 | 说明
---|---
d | 删除模式空间匹配的行,并立即启用下一轮循环 `sed '/^#/d' f1`
p | 打印当前模式空间内容,追加到默认输出之后 `sed -n '/^#/p' f1`
a [\]text | 在指定行*后面*追加文本,支持使用\n实现多行追加 `seq 10|sed '2axxx\nyyy\nzzz'`、`sed '/^root/aadmin' /etc/passwd `
i [\]text | 在行*前面*插入文本 `sed '/^root/i\  admin' /etc/passwd `
c [\]text | 替换行为单行或多行文本 `sed '/^Listen 80/cListen 8080' /etc/httpd/conf/httpd.conf`
w /path/file | 保存模式匹配的行至指定文件 `sed -n '/^UUID/w f1' /etc/fstab`
r /path/file | 读取指定文件的文本至模式空间中匹配到的行后`sed '/^UUID/r /etc/issue' /etc/fstab`
= | 为模式空间中的行打印行号 `sed '/^UUID/=' /etc/fstab`
! | 模式空间中匹配行取反处理 `sed -n '/^UUID/!p' /etc/fstab`
s/// | 查找替换,支持使用其它分隔符,s@@@,s###。`替换标记:g行内全局替换、p显示替换成功的行、w /PATH/FILE 将替换成功的行保存至文件中`
例如 | `sed  's/UUID/uuid/' /etc/fstab`、`sed  -n 's/mapper/Mapper/gp' /etc/fstab`

### sed扩展练习  
```bash
1. 修改selinux配置文件  
`sed -i '/^SELINUX=/cSELINUX=disabled' /etc/selinux/config`  

2. IP地址获取  
`ifconfig enp3s0 | sed -nr 's/.*inet (.*)  netmask.*/\1/p'`
`ifconfig ens33 | sed -n '2p' | sed 's/.*inet //'|sed 's/ net.*$//'` 
通用写法
 2!d 对地址2以外的内容删除  
`ifconfig ens33 | sed -r '2!d;s/.*inet (addr:)?//;s/ .*//'` 

3. 获取基名和文件夹名
echo /etc/sysconfig/network-scripts/ |sed -r 's@(^.*/)([^/].*)/?@\2@'

4. 替换文件内不为#开头的行 增加#注释
sed -r 's/^[^#]/#&/' /etc/fstab 

5. 替换文件内字母大小写
sed -r 's/[[:alpha:]]/\u&/g' /etc/fstab 替换为大写
sed -r 's/[[:alpha:]]/\l&/g' /etc/fstab 替换为小写

6. 为特定行尾增加字段
sed -nr '/.*CMDLINE.*/s/(.*)"/\1 net.ifnames=0"/p' /etc/default/grub

7. 判断系统版本后修改特定文件内容
systemnum=`cat /etc/redhat-release |sed -nr 's/.* ([0-9]+)\..*/\1/'`
[ $systemnum -eg 7] && sed -nr '/.*CMDLINE.*/s/(.*)"/\1 net.ifnames=0"/p' /etc/default/grub

8. sed中调用变量的写法
str=abc
sed -nr '/.*CMDLINE.*/s/(.*)"/\1 '''$str'''"/p' /etc/default/grub

9. 删除文件中的注释行和空白行
sed -r '/^#|^$/d' /etc/httpd/conf/httpd.conf

10. 显示行号并删除2-5行
nl /etc/passwd | sed ‘2,5d’

```
