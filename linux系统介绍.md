# 重新深入的认识和学习Linux系统

------

作为一个运维工作者**Linux**是一个必须需要熟练掌握的系统 —— Linux占据了绝大多数的企业运维环境中最重要的底层环境，现在系统的从头开始来学习并理解Linux相关的知识：

![Linux-logo](https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537629780293&di=1d1e9c1cebf12459800ecd963626c44e&imgtype=0&src=http%3A%2F%2Fbpic.588ku.com%2Felement_origin_min_pic%2F16%2F12%2F28%2Fda530dbb798e3d7440539194a9f43d86.jpg)

**linux的官方网站**：

### [Linux](https://www.linux.org)
**Linux常用的发型版本官网网站**：

### [Redhat](https://www.redhat.com/)
### [Centos](https://www.centos.org)
### [Ubuntu](https://www.ubuntu.com)
### [Debian](https://www.debian.org)
等等...
> 由于Centos在企业环境中的普遍采用，所以作为学习的版本选用。

------

## 什么是 Linux

Linux是一套免费使用和自由传播的类**Unix**操作系统，是一个基于POSIX和UNIX的多用户、多任务、支持多线程和多CPU的操作系统。它能运行主要的**UNIX**工具软件、应用程序和网络协议。它支持32位和64位硬件。Linux继承了**Unix**以网络为核心的设计思想，是一个性能稳定的多用户网络操作系统。
Linux操作系统诞生于1991 年10 月5 日（这是第一次正式向外公布时间）。Linux存在着许多不同的Linux版本，但它们都使用了Linux内核。Linux可安装在各种计算机硬件设备中，比如手机、平板电脑、路由器、视频游戏控制台、台式计算机、大型机和超级计算机。
严格来讲，Linux这个词本身只表示Linux内核，但实际上人们已经习惯了用Linux来形容整个基于Linux内核，并且使用GNU 工程各种工具和数据库的操作系统。
##由于Linux的免费开源属性和优秀的性能及安全性，使得世界上绝大多数的服务器系统及各种设备采取它或它的变种系统来运行各种服务。

### 1. Linux哲学思想 

- 一切都是一个文件（包括硬件）
- 小型，单一用途的程序
- 链接程序，共同完成复杂的任务
- 避免令人困惑的用户界面
- 配置数据存储在文本中

### 2. 操作系统的功能

- 硬件驱动
- 进程管理
- 内存管理
- 网络管理
- 安全管理
- 文件管理
>分为：服务器操作系统、桌面操作系统、移动操作系统

### 3. 用户和内核空间

- **用户空间**：User space
用户程序的运行空间。为了安全，它们是隔离的，即使用户的程序崩溃，内核也不受影响
只能执行简单的运算，不能直接调用系统资源，必须通过系统接口（ system call），才能
向内核发出指令
- **内核空间**：Kernel space
是 Linux 内核的运行空间
可以执行任意命令，调用系统的一切资源
示例：
str = “hello world" // 用户空间
x = x + 100 // 用户空间
file.write(str) // 切换到内核空间
y = x + 200 // 切换回用户空间
说明：第一行和第二行都是简单的赋值运算，在 User space 执行。第三行需要写入文件，就
要切换到 Kernel space，因为用户不能直接写文件，必须通过内核安排。第四行又是赋值运算，
就切换回 User space
![用户空间和内核空间](https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=4258514813,3599729641&fm=26&gp=0.jpg)

### 4. Linux内核 [内核版本](https://www.kernel.org)

- Linux的内核版本由3部分组成 
Kernel:3.10.0-693.el7
- 主版本号:3
次版本号:10
末版本号:0
打包版本号:693
厂商版本:el7

### 5. 开源协议 
![开源协议](https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537634263356&di=733bdac7b101907e436a4f789b3f6a63&imgtype=0&src=http%3A%2F%2Fwww.zhixing123.cn%2Fuploads%2Fallimg%2F151228%2F1_151228214756_1.JPG)
