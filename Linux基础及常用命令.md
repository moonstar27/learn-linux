# Linux的基础知识和常用命令

------

Linux系统作为一个偏重效率及稳定性的操作系统，命令行模式是其重要的工作模式，所以理解并熟练掌握大多数的常用命令和基础知识是十分必要的：

## Linux的基础知识：

学习Linux首先需要学会安装并运行起底层的环境来进行练习。
以我们学的Centos为例，目前已经发展到了最新的7.5版本，但是实际生产环境中肯定还会有大量的Centos6系统在运行。
这两个版本的许多常用命令和服务都会有不同，所以需要在学习的过程中注意两者差别。

> Centos6发布于2011年，完全更新到2017年第2季度，维护更新到2020年11月30号。
> Centos7发布于2014年，完全更新到2020年第4季度，维护更新到2024年6月30号
[参考Centos官方网站](https://wiki.centos.org/About/Product)

------

### 安装运行Linux

**Linux的安装不同于windows server的安装引导过程，在实际服务器中，不需要额外的服务器厂家的引导系统来安装，只需将Linux系统的安装介质插入服务器，可直接进行安装过程，避免很多不兼容和问题的出现**。

1.注意提前规划好系统磁盘所需的空间
必要的分区:  
- / 根 合理分配 作为Linux系统最重要的分区，应留有足够的空间已满足后续的使用。
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
CentOS 6: Ctrl + Alt + F7
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
显示当前使用的shell
**`echo ${SHELL}`**
显示当前系统使用的所有shell
**`cat /etc/shells`**

### 系统日期和时间

1.inux的两种时钟
系统时钟：由Linux内核通过CPU的工作频率进行的
硬件时钟：主板
2.相关命令
- date 显示和设置系统时间
date +%s
date -d @1509536033 Wed Nov  1 19:33:53 CST 2017
date  MMDDhhmmYYYY.ss  月天小时分钟年.秒
- hwclock，clock: 显示硬件时钟
**-s, --hctosys以硬件时钟为准，校正系统时钟**
**-w, --systohc以系统时钟为准，校正硬件时钟**
- 时区：/etc/localtime
- 显示日历：cal–y
- `date -d "-1 day" +%F` 前一天的日期
`date -d "+2 day" +%F` 后天的日期

### Linux系统命令

**命令提示符**：
- [root@localhost~]#
#管理员
$普通用户
- 显示提示符格式
[root@localhost~]#echo $PS1
修改提示符格式
`PS1="\[\e[1;5;41;33m\][\u@\h \W]\\$\[\e[0m\]"`
\e \033\u 当前用户
\h 主机名简称\H 主机名
\w 当前工作目录\W 当前工作目录基名
\t 24小时时间格式\T 12小时时间格式
\! 命令历史数\# 开机后命令历史数

**Shell命令**：
Shell命令分为内部命令和外部命令
使用`type command`查询
**内部命令**：由shell自带的，而且通过某命令形式提供
- help 内部命令列表
- enable cmd 启用内部命令
- enable –n cmd 禁用内部命令
- enable –n  查看所有禁用的内部命令
**外部命令**：在文件系统路径下有对应的可执行程序文件
查看路径：which -a |--skip-alias; whereis
**命令的读取顺序**：
- alias（别名） =1、hash表(缓存)  2、$PATH
- hash常见用法
hash 显示hash缓存
hash –l 显示hash缓存，可作为输入使用
hash –p path name 将命令全路径path起别名为name
hash –t name 打印缓存中name的路径
hash –d name 清除name缓存
hash –r 清除缓存
**命令别名**
- 显示当前shell进程所有可用的命令别名
`alias`
- 定义别名NAME，其相当于执行命令VALUE
`alias NAME='VALUE'`
- 在命令行中定义的别名，仅对当前shell进程有效
如果想永久有效，要定义在配置文件中
仅对当前用户：~/.bashrc
对所有用户有效：/etc/bashrc
- 编辑配置给出的新配置不会立即生效
bash进程重新读取配置文件
`source /path/to/config_file`
`. /path/to/config_file`
- 撤消别名：unalias
unalias[-a] name [name ...]
-a 取消所有别名
- 如果别名同原命令同名，如果要执行原命令，可使用
`\ALIASNAME`
`“ALIASNAME”`
`‘ALIASNAME’`
`command ALIASNAME`
`/path/commmand`
**命令格式**
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
**命令行扩展、被括起来的集合**
- 命令行扩展：$( ) 或``
- 把一个命令的输出打印给另一个命令的参数
`echo"Thissystem'snameis$(hostname) "
Thissystem'snameisserver1.example.com
echo "iam `whoami`"
"iam root"`
- 括号扩展：{ }
打印重复字符串的简化形式
echofile{1,3,5} 结果为：file1file3file5
rm-ffile{1,3,5}
echo {1..10}
echo {a..z}
echo {000..20..2}
**tab键补全命令**
- 命令补全:用户给定的字符串只有一条惟一对应的命令，直接补全;否则，再次Tab会给出列表
- 路径补全:如果惟一：则直接补全;否则：再次Tab给出列表
**命令行历史**
- 保存你输入的命令历史。可以用它来重复执行命令
- 登录shell时，会读取命令历史文件中记录下的命令"~/.bash_history"
- 登录进shell后新执行的命令只会记录在缓存中；这些命令会用户退出时“追加”至命令历史文件中
- 重复前一个命令，有4种方法
重复前一个命令使用上方向键，并回车执行
按!! 并回车执行
输入!-1 并回车执行
按Ctrl+p并回车执行
- !:0 执行前一条命令（去除参数）
- Ctrl + n 显示当前历史中的下一条命令，但不执行
- Ctrl + j 执行当前命令
- !n 执行history命令输出对应序号n的命令
- !-n 执行history历史中倒数第n个命令
- !string 重复前一个以“string”开头的命令
- !?string 重复前一个包含string的命令
- !string:p仅打印命令历史，而不执行
- !$:p 打印输出!$ （上一条命令的最后一个参数）的内容
- !*:p打印输出!*（上一条命令的所有参数）的内容
- ^string删除上一条命令中的第一个string
- ^string1^string2将上一条命令中的第一个string1替换为string2
- !:gs/string1/string2将上一条命令中所有的string1都替换为string2
- 使用up（向上）和down（向下）键来上下浏览从前输入的命令
- ctrl-r来在命令历史中搜索命令
（reverse-i-search）`’：
- Ctrl+g：从历史搜索模式退出
- 要重新调用前一个命令中最后一个参数
!$ 表示
Esc, .（点击Esc键后松开，然后点击. 键）
Alt+ .（按住Alt键的同时点击. 键）
**bash的快捷键**
- Ctrl + l清屏，相当于clear命令
- Ctrl + o执行当前命令，并重新显示本命令
- Ctrl + s阻止屏幕输出，锁定
- Ctrl + q允许屏幕输出
- Ctrl + c终止命令
- Ctrl + z挂起命令
- Ctrl + a光标移到命令行首，相当于Home
- Ctrl + e光标移到命令行尾，相当于End
- Ctrl + f光标向右移动一个字符
- Ctrl + b光标向左移动一个字符
- Alt + f光标向右移动一个单词尾
- Alt + b光标向左移动一个单词首
- Ctrl + xx光标在命令行首和光标之间移动
- Ctrl + u从光标处删除至命令行首
- Ctrl + k从光标处删除至命令行尾
- Alt + r 删除当前整行
- Ctrl + w从光标处向左删除至单词首
- Alt + d从光标处向右删除至单词尾
- Ctrl + d删除光标处的一个字符
- Ctrl + h删除光标前的一个字符
- Ctrl + y将删除的字符粘贴至光标后
- Alt + c从光标处开始向右更改为首字母大写的单词
- Alt + u从光标处开始，将右边一个单词更改为大写
- Alt + l从光标处开始，将右边一个单词更改为小写
- Ctrl + t交换光标处和之前的字符位置
- Alt + t交换光标处和之前的单词位置
- Alt + N提示输入指定字符后，重复显示该字符N次
- 注意：Alt组合快捷键经常和其它软件冲突

### Linux常用命令
1.halt, poweroff 关机
2.reboot 重启
-f: 强制，不调用shutdown
-p: 切断电源
3.shutdown 关机或重启
- shutdown [OPTION]... [TIME] [MESSAGE]
*-r: reboot*
*-h: halt*
*-c：cancel*
*TIME：无指定，默认相当于+1（CentOS7）
now: 立刻,相当于+0
+m: 相对时间表示法，几分钟之后；例如+3
hh:mm: 绝对时间表示，指明具体时间*
4.whoami: 显示当前登录有效用户
5.who: 系统当前所有的登录会话
w: 系统当前所有的登录会话及所做的操作
6.nano:文本编辑器 ctrl+x 退出编辑
7.echo：echo [-neE][字符串]
- -E （默认）不支持\解释功能
- -n 不自动换行
- -e 启用\字符的解释功能
- 显示变量
- echo "$VAR_NAME” 变量会替换，弱引用
- echo '$VAR_NAME’ 变量不会替换，强引用
- 启用命令选项-e，若字符串中出现以下字符，则特别加以处理，而不会将它当成一般文字输出
- \a 发出警告声
- \b 退格键
- \c 最后不加上换行符号
- \n 换行且光标移至行首
- \r 回车，即光标移至行首，但不换行
- \t 插入tab
- \\插入\字符
8.screen：
- 创建新screen会话
screen –S [SESSION]
- 加入screen会话
screen –x [SESSION]
- 退出并关闭screen会话
exit
- 剥离当前screen会话
Ctrl+a,d
- 显示所有已经打开的screen会话
screen -ls
- 恢复某screen会话
screen -r [SESSION]
9.history:
- history [-c] [-d offset] [n]
history -anrw[filename]
history -psarg[arg...]
- -c: 清空命令历史
- -d offset: 删除历史中指定的第offset个命令
-  n: 显示最近的n条历史
- -a: 追加本次会话新执行的命令历史列表至历史文件
- -r: 读历史文件附加到历史列表
- -w: 保存历史列表到指定的历史文件
- -n: 读历史文件中未读过的行到历史列表
- -p: 展开历史参数成多行，但不存在历史列表中
- -s: 展开历史参数成一行，附加在历史列表后
- HISTSIZE：命令历史记录的条数 `echo $HISTSIZE`
- HISTFILE：指定历史文件，默认为~/.bash_history
- HISTFILESIZE：命令历史文件记录历史的条数
- HISTTIMEFORMAT=“%F %T “ 显示时间
- HISTIGNORE=“str1:str2*:… “ 忽略str1命令，str2开头的历史
- 控制命令历史的记录方式：
- 环境变量：HISTCONTROL
- ignoredups默认，忽略重复的命令，连续且相同为“重复”
- ignorespace忽略所有以空白开头的命令
- ignoreboth相当于ignoredups, ignorespace的组合
- erasedups删除重复命令
- export 变量名="值“
- 存放在/etc/profile 或~/.bash_profile


### 读取系统帮助 
1.whatis
- 显示命令的简短描述
使用数据库
刚安装后不可立即使用
makewhatis| mandb制作数据库
使用示例：whatis cal
2.command--help
- 显示用法总结和参数列表
示例：date --help
3.man
`man –a keyword`、`man [章节] keyword`
- 提供命令帮助的文件
- 手册页存放在/usr/share/man
- 几乎每个命令都有man的“页面”
- man页面分组为不同的“章节”
- man命令的配置文件：/etc/man.config| man_db.conf
1：**用户命令**
2：系统调用
3：C库调用
4：**设备文件及特殊文件**
5：**配置文件格式**
6：游戏
7：杂项
8：**管理类的命令**
9：Linux 内核API
- man命令的操作方法：
space: 向文件尾翻屏
b: 向文件首部翻屏
d: 向文件尾部翻半屏
u: 向文件首部翻半屏
q: 退出
4.info
- info 页面的结构就像一个网站
方向键，PgUp，PgDn导航
Tab键移动到下一个链接
d 显示主题目录
Home 显示主题首部
Enter进入选定链接
n/p/u/l进入下/前/上一层/最后一个链接
s文字文本搜索
q退出info
5./usr/share/doc/
- 多数安装了的软件包的子目录,包括了这些软件的相关原理说明
