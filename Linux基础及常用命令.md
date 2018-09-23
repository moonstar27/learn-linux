# Linux的基础知识和常用命令

------

Linux系统作为一个偏重效率及稳定性的操作系统，命令行模式是其重要的工作模式，所以理解并熟练掌握大多数的常用命令和基础知识是十分必要的：

## Linux的基础知识：

学习Linux首先需要学会安装并运行起底层的环境来进行练习。
以我们学的Centos为例，目前已经发展到了最新的7.5版本，但是实际生产环境中肯定还会有大量的Centos6系统在运行。
这两个版本的许多常用命令和服务都会有不同，所以需要在学习的过程中注意两者差别。

> Centos6发布于2011年，完全更新到2017年第2季度，维护更新到2020年11月30号。
>Centos7发布于2014年，完全更新到2020年第4季度，维护更新到2024年6月30号
[参考Centos官方网站](https://wiki.centos.org/About/Product)

------

### 1. 安装运行Linux

**Linux的安装不同于windows server的安装引导过程，在实际服务器中，不需要额外的服务器厂家的引导系统来安装，只需将Linux系统的安装介质插入服务器，可直接进行安装过程，避免很多不兼容和问题的出现**。

- 注意提前规划好系统磁盘所需的空间
必要的分区:  
1./ 根 合理分配 作为Linux系统最重要的分区，应留有足够的空间已满足后续的使用。
2./boot 启动分区 作为系统引导分区使用
3.swap 交换分区  swap类似windows的虚拟内存/page file，内存小于2G时，设置为内存的2倍；内存大于或等于2G时，设置为2G
**用于正式生产的服务器，切记必须把数据盘单独分区，防止系统出问题时，保证数据的完整性。
比如可以再划分一个/data专门用来存放数据**。
>Centos6模式磁盘格式为ext4，Centos7默认磁盘格式为xfs

- 在选择时区的安装界面，注意取消system clock users UTC 避免出现系统将现有时间当做UTC（格林尼治时间）使用。

- 安装过程中使用组合键 
ctrl+alt+f1 进入安装命令状态
ctrl+alt+f2 进入命令行
ctrl+alt+f3 提示信息
ctrl+alt+f4 日志信息
ctrl+alt+f5 安装信息
ctrl+alt+f6 返回图形化界面

- 默认安装模式是：Minimal(最小) 实际生产环境中常用，作为学习环境可选择Desktop (桌面)

### 2. Linux系统基础 
- 系统用户
root 超级用户 *类似windows中的administrator，实际生产环境不要使用root账户登录，避免出现误操作导致系统崩溃*。
user 普通用户 *权限较低，仅可对系统进行基础操作，无特殊权限*。

- 工作终端terminal
1.设备终端
键盘鼠标显示器
2.物理终端（/dev/console ）
控制台console
3.虚拟终端(tty：teletypewriters，/dev/tty# #为[1-6])
tty可有n个，**Ctrl+Alt+F[1-6]可快读切换终端界面**
4.图形终端（/dev/tty7 ）startx, xwindows 
CentOS 6: Ctrl + Alt + F7
CentOS 7: 在哪个终端启动，即位于哪个虚拟终端
runlevel 查看运行级别
init 3 命令行模式
init 5 图形化模式
init 0 关机
inti 6 重启
5.串行终端（/dev/ttyS# ）
ttyS
6.伪终端（pty：pseudo-tty，/dev/pts/# ）
pty, SSH远程连接
查看当前的终端设备：
tty

- 交互式接口 *启动终端后，在终端设备附加一个交互式应用程序*
GUI：Graphic User Interface
X protocol, window manager, desktop
Desktop:
GNOME (C, 图形库gtk)
KDE (C++,图形库qt)
XFCE (轻量级桌面)
CLI：Command Line Interface
shell程序：sh(bourn 史蒂夫·伯恩)、cshtcshksh(korn)、bash (bourn again shell)GPL、zsh

- Shell命令
Shell 是Linux系统的用户界面，提供了用户与内核进行交互操作的一种接口。它接收用户输入的命令并把它送入内核去执行
Shell也被称为LINUX的命令解释器（command interpreter）
Shell是一种高级程序设计语言
![Shell](https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537678381680&di=f70171c636a3e144b70e9564a69a8902&imgtype=0&src=http%3A%2F%2Fwww.tiejiang.org%2Fwp-content%2Fuploads%2F2013%2F07%2F12.jpg%3FimageView2%2F1%2Fw%2F350%2Fh%2F250%2Fq%2F100)

