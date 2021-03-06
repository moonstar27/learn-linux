# Linux的基础知识和常用命令

------

Linux系统作为一个偏重效率及稳定性的操作系统，命令行模式是其重要的工作模式，所以理解并熟练掌握大多数的常用命令和基础知识是十分必要的：

## Linux的基础知识：

学习Linux首先需要学会安装并运行起底层的环境来进行练习。
以我们学的Centos为例，目前已经发展到了最新的7.5版本，但是实际生产环境中肯定还会有大量的Centos6系统在运行。
这两个版本的许多常用命令和服务都会有不同，所以需要在学习的过程中注意两者差别。

> Centos6发布于2011年，完全更新到2017年第2季度，维护更新到2020年11月30号

> Centos7发布于2014年，完全更新到2020年第4季度，维护更新到2024年6月30号

[参考Centos官方网站](https://wiki.centos.org/About/Product)

------

### 安装运行Linux

**Linux的安装不同于windows server的安装引导过程，在实际服务器中，不需要额外的服务器厂家的引导系统来安装，只需将Linux系统的安装介质插入服务器，可直接进行安装过程，避免很多不兼容和问题的出现**。

1.注意提前规划好系统磁盘所需的空间
必要的分区:  
- / 根 合理分配 作为Linux系统最重要的分区，应留有足够的空间已满足后续的使用
- /boot 启动分区 作为系统引导分区使用
- swap 交换分区  swap类似windows的虚拟内存/page file，内存小于2G时，设置为内存的2倍；内存大于或等于2G时，设置为2G
- **用于正式生产的服务器，切记必须把数据盘单独分区，防止系统出问题时，保证数据的完整性。
比如可以再划分一个/data专门用来存放数据**。
>Centos6模式磁盘格式为ext4，Centos7默认磁盘格式为xfs

2.在选择时区的安装界面，注意取消system clock users UTC 避免出现系统将现有时间当做UTC（格林尼治时间）使用。

3.安装过程中使用组合键 
- ctrl+alt+f1 进入安装命令状态
- ctrl+alt+f2 进入命令行
- ctrl+alt+f3 提示信息
- ctrl+alt+f4 日志信息
- ctrl+alt+f5 安装信息
- ctrl+alt+f6 返回图形化界面

4.默认安装模式是：Minimal(最小) 实际生产环境中常用，作为学习环境可选择Desktop (桌面)

### Linux系统基础 

1.系统编码
- ASCII码：计算机内部，所有信息最终都是一个二进制值。
- Unicode：用于表示世界上所有语言中的所有字符。
- UTF-8是目前互联网上使用最广泛的一种Unicode 编码方式，可变长存储。

2.系统用户
- root 超级用户 *类似windows中的administrator，实际生产环境不要使用root账户登录，避免出现误操作导致系统崩溃*。
- user 普通用户 *权限较低，仅可对系统进行基础操作，无特殊权限*。

3.工作终端terminal
- 设备终端
键盘鼠标显示器
- 物理终端（/dev/console ）
控制台console
- 虚拟终端(tty：teletypewriters，/dev/tty# #为[1-6])
tty可有n个，**Ctrl+Alt+F[1-6]可快读切换终端界面**
- 图形终端（/dev/tty7 ）startx, xwindows 
CentOS 6: `Ctrl + Alt + F7`
CentOS 7: 在哪个终端启动，即位于哪个虚拟终端
runlevel 查看运行级别
init 3 命令行模式
init 5 图形化模式
init 0 关机
inti 6 重启
- 串行终端（/dev/ttyS# ）
ttyS
- 伪终端（pty：pseudo-tty，/dev/pts/# ）
pty, SSH远程连接
- 查看当前的终端设备：
tty

4.交互式接口 *启动终端后，在终端设备附加一个交互式应用程序*
- GUI：Graphic User Interface
X protocol, window manager, desktop
Desktop:
GNOME (C, 图形库gtk)
KDE (C++,图形库qt)
XFCE (轻量级桌面)
- CLI：Command Line Interface
shell程序：sh(bourn 史蒂夫·伯恩)、cshtcshksh(korn)、bash (bourn again shell)GPL、zsh

5.Shell命令
Shell 是Linux系统的用户界面，提供了用户与内核进行交互操作的一种接口。它接收用户输入的命令并把它送入内核去执行。
Shell也被称为LINUX的命令解释器（command interpreter）
Shell是一种高级程序设计语言
![Shell](https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537678381680&di=f70171c636a3e144b70e9564a69a8902&imgtype=0&src=http%3A%2F%2Fwww.tiejiang.org%2Fwp-content%2Fuploads%2F2013%2F07%2F12.jpg%3FimageView2%2F1%2Fw%2F350%2Fh%2F250%2Fq%2F100)
- GNU Bourne-Again Shell(bash)是GNU计划中重要的工具软件之一，目前也是Linux标准的shell，与sh兼容
entOS默认使用
- 显示当前使用的shell
**`echo ${SHELL}`**
- 显示当前系统使用的所有shell
**`cat /etc/shells`**

### 系统日期和时间

1.inux的两种时钟
系统时钟：由Linux内核通过CPU的工作频率进行的
硬件时钟：主板

2.相关命令
- date 显示和设置系统时间
- `date +%s`
- `date -d @1509536033` Wed Nov  1 19:33:53 CST 2017
- date  MMDDhhmmYYYY.ss  月天小时分钟年.秒
- hwclock，clock: 显示硬件时钟
**-s, --hctosys以硬件时钟为准，校正系统时钟**
**-w, --systohc以系统时钟为准，校正硬件时钟**
- 时区：/etc/localtime
- 显示日历：cal–y
- `date -d "-1 day" +%F` 前一天的日期
`date -d "+2 day" +%F` 后天的日期

### Linux系统命令

1.**命令提示符**：
- [root@localhost~]# '#管理员'
- [root@localhost~]$ '$普通用户'
- 显示提示符格式 echo $PS1
- 修改提示符格式
`PS1="\[\e[1;5;41;33m\][\u@\h \W]\\$\[\e[0m\]"   
\e \033\u 当前用户--\h 主机名简称--\H 主机名--\w 当前工作目录--\W 当前工作目录基名--\t 24小时时间格式--\T 12小时时间格式--\! 命令历史数--\# 开机后命令历史数`

2.**Shell命令**：
Shell命令分为内部命令和外部命令
使用`type command`查询

3.**内部命令**：由shell自带的，而且通过某命令形式提供
- help 内部命令列表
- enable cmd 启用内部命令
- enable –n cmd 禁用内部命令
- enable –n  查看所有禁用的内部命令

4.**外部命令**：在文件系统路径下有对应的可执行程序文件
查看路径：which -a |--skip-alias; whereis

5.**命令的读取顺序**：
- alias---builtin--hash表(缓存)---$PATH

| hash | 常见用法 |
| ---- | ---- |
| hash | 显示hash缓存 |
| hash –l | 显示hash缓存，可作为输入使用 |
| hash –p | path name 将命令全路径path起别名为name |
| hash –t | name 打印缓存中name的路径 |
| hash –d | name 清除name缓存 |
| hash –r | 清除缓存 |

6.**命令别名**
- 显示当前shell进程所有可用的命令别名
`alias`
- 定义别名NAME，其相当于执行命令VALUE
`alias NAME='VALUE'`
- 在命令行中定义的别名，仅对当前shell进程有效
- 如果想永久有效，要定义在配置文件中
仅对当前用户：~/.bashrc
对所有用户有效：/etc/bashrc
- 编辑配置给出的新配置不会立即生效
bash进程重新读取配置文件
`source /path/to/config_file`
`. /path/to/config_file`
- 撤消别名：unalias
unalias[-a] name [name ...]
- -a 取消所有别名
- 如果别名同原命令同名，如果要执行原命令，可使用
`\ALIASNAME`
`“ALIASNAME”`
`‘ALIASNAME’`
`command ALIASNAME`
`/path/commmand`

7.**命令格式**
- **`COMMAND [OPTIONS...] [ARGUMENTS...]`**
- 选项：用于启用或关闭命令的某个或某些功能
- 短选项：-c 例如：-l, -h
- 长选项：--word 例如：--all, --human-readable
- 参数：命令的作用对象，比如文件名，用户名等
- 注意：
多个选项以及多参数和命令之间使用空白字符分隔
取消和结束命令执行：Ctrl+c，Ctrl+d
多个命令可以用 `;` 符号分开
一个命令可以用 `\` 分成多行

8.**命令行扩展、被括起来的集合**
- 命令行扩展：$( ) 或``
- 把一个命令的输出打印给另一个命令的参数  
echo"Thissystem'snameis$(hostname)"   
This system 'snameisserver1.example.com'       
echo "iam `whoami`"   
"iam root"
- 括号扩展：{ }
打印重复字符串的简化形式   
echofile{1,3,5}   
结果为：file1file3file5  
rm-ffile{1,3,5}   
echo {1..10}   
echo {a..z}  
echo {000..20..2}

9.**tab键补全命令**
- 命令补全:用户给定的字符串只有一条惟一对应的命令，直接补全;否则，再次Tab会给出列表
- 路径补全:如果惟一：则直接补全;否则：再次Tab给出列表
 
10.**命令行历史**

| 参数 | 含义 | 
| ------ | ------ | 
| 重复前一个命令 | 1、上方向键 2、按!! 3、输入!-1 4、Ctrl+p | 
| !:0 | 执行前一条命令（去除参数）|
| Ctrl+n | 显示当前历史中的下一条命令,但不执行 |
| Ctrl+j | 执行当前命令 |
| **!n** | 执行history命令输出对应序号n的命令 |
| **!-n** | 执行history历史中倒数第n个命令 |
| !string | 重复前一个以“string”开头的命令 |
| !?string | 重复前一个包含string的命令 |
| !string:p | 仅打印命令历史，而不执行 |
| !\$:p | 打印输出!\$ （上一条命令的最后一个参数）的内容 |
| !*:p | 打印输出!*（上一条命令的所有参数）的内容 |
| ^string | 删除上一条命令中的第一个string |
| ctrl-r | 命令历史中搜索命令 |
| Ctrl+g | 从历史搜索模式退出 |
| !$、Esc, .（点击Esc键后松开，然后点击. 键）、Alt+ .（按住Alt键的同时点击. 键） | 重新调用前一个命令中最后一个参数 |

11.**bash的快捷键**

| 参数 | 含义 | 
| ------ | ------ | 
| **Ctrl+l** | 清屏,相当于clear命令 | 
| **Ctrl+o** | 执行当前命令,并重新显示本命令 |
| Ctrl+s | 阻止屏幕输出,锁定 |
| Ctrl+q | 允许屏幕输出 |
| **Ctrl+c** | 终止命令 |
| Ctrl+z | 挂起命令 |
| Ctrl+a | 光标移到命令行首,相当于Home |
| Ctrl+e | 光标移到命令行尾,相当于End |
| Ctrl+f | 光标向右移动一个字符 |
| Ctrl+b | 光标向左移动一个字符 |
| Alt+f | 光标向右移动一个单词尾 |
| Alt+b | 光标向左移动一个单词首 |
| Ctrl+xx | 光标在命令行首和光标之间移动 |
| Ctrl+u | 从光标处删除至命令行首 |
| Ctrl+k | 从光标处删除至命令行尾 |
| Alt+r | 删除当前整行 |
| Ctrl+w | 从光标处向左删除至单词首 |
| Alt+d | 从光标处向右删除至单词尾 |
| Ctrl+d | 删除光标处的一个字符 |
| Ctrl+h | 删除光标前的一个字符 |
| Ctrl+y | 将删除的字符粘贴至光标后 |
| Alt+c | 从光标处开始向右更改为首字母大写的单词 |
| Alt+u | 从光标处开始,将右边一个单词更改为大写 |
| Alt+l | 从光标处开始，将右边一个单词更改为小写 |
| Ctrl+t | 交换光标处和之前的字符位置 |
| Alt+t | 交换光标处和之前的单词位置 |
| Alt+N | 提示输入指定字符后,重复显示该字符N次 |
- 注意：Alt组合快捷键经常和其它软件冲突

### Linux常用命令
| 系统命令 | 含义 | 参数 |
| ------ | ------ | ------ |
| halt, poweroff | 关机 | 
| reboot | 重启 | -f: 强制，不调用shutdown;-p: 切断电源 |
| shutdown | 关机或重启 | -r: reboot; -h: halt; -c：cancel; TIME; now; hh:mm:
| cd | 改变工作目录 | cd ~:用户的主目录、cd ~username切换到指定用户的主目录 |
| pwd | 显示当前目录 |
| ls | 显示指定路径下的文件列表 |-a:显示所有文件（包括隐藏）、-l:显示文件的元数据信息、-h:带字节显示、-d:显示目录本身的属性 |
| cat | 连续的显示文件的内容 | cat file查看文件内容 |
| echo | 回显命令 | -n 不自动换行、-e 启用\字符的解释功能、echo " " 变量会替换，弱引用、echo ' ' 变量不会替换，强引用 |
| which | 显示应用程序文件位置 |
| whatis | 显示命令的帮助信息位置 | Centos6:makewhatis、 Centos7:mandb制作数据库 |
| screen | 窗口管理器的命令行界面版本 | 新会话screen –S、加入screen –x、剥离会话Ctrl+a,d、显示所有会话screen -ls、恢复会话screen -r |
| history | 显示命令的帮助信息位置 | 清空-c、删除指定命令-d、显示最近命令n、追加本次会话新执行的命令历史列表至历史文件-a、读历史文件附加到历史列表-r、读历史文件中未读过的行到历史列表-n |
| HISTSIZE | 命令历史记录的条数 | echo $HISTSIZE |
| HISTFILE | 指定历史文件 | 默认为~/.bash_history |
| HISTFILESIZE | 命令历史文件记录历史的条数 |
| --help | 显示用法总结和参数列表 | date --help |
| man | 提供命令帮助的文件 | 手册页存放在/usr/share/man、man命令的配置文件：/etc/man.config、 man_db.conf、1：**用户命令**、4：**设备文件及特殊文件**、5：**配置文件格式**、8：**管理类的命令**、**man命令的操作方法**：space: 向文件尾翻屏 b: 向文件首部翻屏 d: 向文件尾部翻半屏 u: 向文件首部翻半屏 q: 退出 |
| info | GNU工具info适合通用文档参考 | 方向键，PgUp，PgDn导航、Tab键移动到下一个链接、d 显示主题目录、Home 显示主题首部、Enter进入选定链接、n/p/u/l进入下/前/上一层/最后一个链接、s文字文本搜索、q退出info |
| /usr/share/doc/ | 多数安装了的软件包的子目录,包括了这些软件的相关原理说明 |
