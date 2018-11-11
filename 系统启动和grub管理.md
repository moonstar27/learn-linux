# Linux组成
单内核:linux 所有功能集成在同一程序
微内核:windows 每种功能使用一个单独子系统  

## 内核
模块化: .ko（内核对象）
动态装载和卸载  
例如：/lib/modules/3.10.0-862.14.4.el7.x86_64/kernel/fs/

核心文件：/boot/vmlinuz-VERSION-release  
ramdisk：辅助的伪根系统  
CentOS 5: /boot/initrd-VERSION-release.img  
CentOS 6,7: /boot/initramfs-VERSION-release.img  
模块文件：/lib/modules/VERSION-release  

## 启动流程

1. post 
Power-On-Self-Test，加电自检，是BIOS功能的一个主要部分。
2. ROM
BIOS，Basic Input and Output System，保存着有关计算机系统最重要
的基本输入输出程序，系统信息设置、开机加电自检程序和系统启动自举程序等
3. RAM
CMOS互补金属氧化物半导体，保存各项参数的设定   
4. bootloader   
引导加载器，引导程序  
windows: ntloader，仅是启动OS   
Linux：功能丰富，提供菜单，允许用户选择要启动系统或不同的内核版本；把用户选定的内核装载到内存中的特定空间中，解压、展开，并把系统控制权移交给内核   
LILO：LInux LOader    
GRUB: GRand Unified Bootloader    
GRUB 0.X: GRUB Legacy， GRUB2    

- MBR：第一扇区  
前446字节 bootloader  
中间64字节 分区表  
最后2字节 55AA  
- GRUB  
 1.5阶段  寻找磁盘固定位置的二进制数据  
 2阶段 寻找磁盘分区文件  /boot/grub

5. 加载内核/boot/vmlinuz...   
通过/initramfs....img加载文件系统驱动  
加载硬件驱动程序（借助于ramdisk加载驱动）
以只读方式挂载根文件系统
运行用户空间的第一个应用程序：/sbin/init

> ramdisk：内核中的特性之一：使用缓冲和缓存来加速对磁盘上的文件访问，并加载相应的硬件驱动   
ramdisk --> ramfs 提高速度
CentOS 5: initrd  
工具程序：mkinitrd  
CentOS 6，7: initramfs  
工具程序：mkinitrd, dracut  


---
**系统初始化**：  
POST --> BootSequence (BIOS) --> Bootloader(MBR) -->
kernel(ramdisk) --> rootfs(只读) --> init（systemd）

### ramdisk管理

ramdisk文件的制作：  
- mkinitrd命令   
 为当前正在使用的内核重新制作ramdisk文件   
 #**uname -r生产内核版本号以便制作此文件**  
 `mkinitrd /boot/initramfs-$(uname -r).img $(uname -r) `  
- dracut命令   
为当前正在使用的内核重新制作ramdisk文件   
 `dracut /boot/initramfs-$(uname -r).img $(uname -r) `  

---

实验：误删除initramfs文件恢复(centos6)  
1. 系统重启后故障画面  
![init](https://note.youdao.com/yws/api/personal/file/0CD7FC55A5994D949AD0892648AC784C?method=download&shareKey=c20a90f2e62b9c2458e6c4b7f719c0bf)
2. 使用系统版本对应的光盘进入救援模式
3. 切根后输入`mkinitrd /boot/initramfs-$(uname -r).img $(uname -r) `重新恢复文件
![init](https://note.youdao.com/yws/api/personal/file/1CDA0129FFD5489BA9A276F087F8D772?method=download&shareKey=69d9d9e9211be19612fe609be3a7964c)

> 修复后注意sync写入磁盘，避免出现故障  

### init初始化 
init读取其初始化文件：/etc/inittab  
初始运行级别(RUN LEVEL)  
系统初始化脚本  
对应运行级别的脚本目录  
捕获某个关键字顺序  
定义UPS电源终端/恢复脚本  
在虚拟控制台生成getty  
在运行级别5初始化X  

- 启动配置文件  
**centos6** init程序:Upstart  
/etc/inittab   
/etc/init/*.conf  
**centos7**: systemd   
/usr/lib/systemd/system   
/etc/systemd/system  
> 设置开机启动模式systemctl set-default runlevel3.target

runlevel就是各个服务的集合
```
运行级别：为系统运行或维护等目的而设定；0-6：7个级别
0：关机
1：单用户模式(root自动登录), single, 维护模式（无网络维护模式）可破解root口令
2: 多用户模式，启动网络功能，但不会启动NFS；维护模式
3：多用户模式，正常模式；文本界面
4：预留级别；可同3级别
5：多用户模式，正常模式；图形界面
6：重启
默认级别：3, 5
切换级别：init #
查看级别：runlevel ; who -r
```
> 修复init设置错误  
1、在系统倒计时时按任意键   
2、进入内核选择界面，选择 “a” 编辑内核文件  
3、在文件结尾添加想要进入的运行模式，比如3（文件为/etc/boot/grub.conf),临时进入系统跳过系统设置的错误值

- 系统初始化脚本
/etc/rc.d/rc.sysinit: 系统初始化脚本  
1、设置主机名   
2、设置欢迎信息   
3、激活udev和selinux  
4、挂载/etc/fstab文件中定义的文件系统  
5、检测根文件系统，并以读写方式重新挂载根文件系统  
6、设置系统时钟  
7、激活swap设备  
8、根据/etc/sysctl.conf文件设置内核参数  
9、激活lvm及software raid设备  
10、加载额外设备的驱动程序  
11、清理操作  

- 按照设定的runlevel运行相对应的脚本  
**说明：rc N --> 意味着读取/etc/rc.d/rcN.d/**  
K*: K##*：##运行次序；数字越小，越先运行；数字越小的服务，通常为
依赖到别的服务  
S*: S##*：##运行次序；数字越小，越先运行；数字越小的服务，通常为
被依赖到的服务  
```
for srv in /etc/rc.d/rcN.d/K*; do
    $srv stop
done
for srv in /etc/rc.d/rcN.d/S*; do
    $srv start
done
```
> /etc/rc.d/rcN.d/中的文件都是软链接文件，对应/etc/init.d/中的文件  
切换各runlevel会运行脚本停止或启动各个服务

## chkconfig配置命令

- ntsysv设置开机启动的服务 每次只能修改一种运行级别的服务  
ntsysv --level 

- chkconfig  

查看服务在所有级别的启动或关闭设定情形：  
chkconfig [--list] [name]  
添加：chkconfig --add name  
删除：chkconfig --del name   
```
chkconfig --level 35 atd on  #修改atd在runlevel 3和5的启动  
chkconfig --list atd  

常用的方式
chkconfig atd on 默认设置2345模式下的开机启动  
```
**service命令调用的/etc/init.d/中的命令来管理服务**

> 自定义的启动脚本服务建议放置在S开头靠后的位置   
/etc/init.d/rc*.**d目录下的文件时由文件开头的字符排序得到**，不是数字排序  

```
#!/bin/bash
#简单启动脚本示例
#chkconfig: 35 98 03 #想要开机运行的runlevel S开头的排序号 K开头的排序号
#description: test services

. /etc/init.d/functions #引用系统函数
case $1 in

start)
        touch /var/lock/subsys/testsrv #如果是运行命令，就创建文件并打印启动服务
        action "Starting testsrv" true
        ;;
stop)
        rm -f /var/lock/subsys/testsrv #如果是停止命令，就删除文件并打印停止服务
        action "Stopping testsrv" true
        ;;
restart)
        action "Stopping testsrv" true
        action "Starting testsrv" true
        ;;
status)
        if [ -f /var/lock/subsys/testsrv ];then #判断启动模式，通过运行命令创建的文件是否存在得知
                echo testsrv is running...
        else
                echo testsrv is stopped
        fi
        ;;
*)
        echo Usage: /etc/init.d/testsrv {start|stop|restart|status} #打印服务管理命令
esac

运行效果：
[root@Centos6 init.d]# ./testsrv start
Starting testsrv                       [  OK  ]
[root@Centos6 init.d]# ./testsrv status
testsrv is running...
[root@Centos6 init.d]# ./testsrv stop
Stopping testsrv                       [  OK  ]
[root@Centos6 init.d]# ./testsrv status
testsrv is stopped
``` 

通过chkconfig --add testsrv   就可以添加到管理列表中，并会在设置的runlevel3和5中创建相应的软链接文件
![chkconfig](https://note.youdao.com/yws/api/personal/file/6A199844416C49E6B278F811636AA0E9?method=download&shareKey=d7d41f383404c1e8f5e5bee2adc566fd)                 

可以使用chkconfig --del testsrv删除服务列表  
对应的操作：删除了/etc/rc*.d/中的软链接文件  

## xinetd

瞬态(Transient)服务被xinetd进程所管理  
进入的请求首先被xinetd代理   
配置文件：  
/etc/xinetd.conf  
/etc/xinetd.d/<service>   
与libwrap.so文件链接   
用chkconfig控制的服务：   
示例：chkconfig tftp on  

超级守护进程centos6

> xinted代理人 负责唤醒其它服务   
非独立服务、适合不经常启动的服务、开机不启动  

启动xinetd服务即可管理受控服务，会自动唤醒被管理的服务


---
S99local **/etc/rc.d/rc/local** 可以接管所有不想写启动脚本的服务   
默认可以启动脚本内的服务，**但不能通过service管理**，只能通过kill关闭  


---
CentOS 6启动流程：
POST 

```
Boot Sequence(BIOS) --> Boot Loader --> Kernel(ramdisk) -->rootfs --> switchroot --> /sbin/init -->(/etc/inittab,/etc/init/*.conf) --> 设定默认运
行级别 --> 系统初始化脚本rc.sysinit --> 关闭或启动对应级别的服务 --> 启动终端
```
![boot](http://s4.51cto.com/wyfs02/M02/87/20/wKiom1fVBELjXsvaAAUkuL83t2Q304.jpg)
# grub

grub: GRand Unified Bootloader   
grub 0.97: grub legacy  #老版本 centos6   
grub 2.x: grub2 #新版本 centos7   
grub legacy:   
stage1: mbr   
stage1_5: mbr之后的扇区，让stage1中的bootloader能识别stage2所在
的分区上的文件系统   
stage2：磁盘分区(/boot/grub/)   

实验：   
1.5阶段的MBR启动分区被破坏的修复   
1、启动分区的MBR前446字节被破坏
![MBR](https://note.youdao.com/yws/api/personal/file/B2A4879AABCF4E9693BF818DE53BAB04?method=download&shareKey=94e10b7f39acf2a892f159365f9be860)   
2、重启之后直接会进入光盘界面，等待被修复  
![MBR](https://note.youdao.com/yws/api/personal/file/C40BDABCC8E6483591B9F9949593CE08?method=download&shareKey=af1d56b45fd76a65fe46719dc69f2dc1)   
修复方法一：    
3、进入修复界面切换根目录chroot /mnt/sysimage运行 grub-install /dev/sda   
![MBR](https://note.youdao.com/yws/api/personal/file/938A5C0206EC449792DA5AC99FC287AF?method=download&shareKey=9e551d61078dbfe3994926a48ed5da88)  
> 也可以使用grub-install命令在没有重启的情况下修复，而且不依赖/etc/grub中的文件，更为通用

修复方法二：
在没有重启的情况下，可以直接修复
使用grub命令进入交互式  
grub> root (hd#,#)    #boot所在的磁盘、分区序号    
grub> setup (hd#) #MBR写入的硬盘序列号  
![MBR](https://note.youdao.com/yws/api/personal/file/7C303012D3364865AB817AA355ACDBF2?method=download&shareKey=e993d64c0643904a6691d8b5b804842d)  
> 此修复方法依赖/etc/grub中的文件


- 修复过的扇区文件和初始安装的状态并不一样，初始安装的512之后的删除都是空白扇区

- /boot/grub中的文件除grub.conf外是硬盘分区时段的备份文件

- 使用grub-install修复过的硬盘如果再次破坏/etc/grub中的文件，将导致不能引导   
![MBR](https://note.youdao.com/yws/api/personal/file/A4670032045945A9AA3FD8F25A0F1F76?method=download&shareKey=426a1841bbbf45835d3bdb926f7184a8)

- rhgb 图形界面启动画面  建议修改为字符界面 修改/boot/gurb/grub.conf(centos6) 删除rhbg字符

## grub legacy

配置文件：/boot/grub/grub.conf <--/etc/grub.conf  
stage2及内核等通常放置于一个基本磁盘分区  
功用：
- 提供启动菜单、并提供交互式接口
a：内核参数
e: 编辑模式，用于编辑菜单
c: 命令模式，交互式接口
- 加载用户选择的内核或操作系统
允许传递参数给内核
可隐藏启动菜单
- 为菜单提供了保护机制
为编辑启动菜单进行认证
为启用内核或操作系统进行认证

> 识别硬盘设备(hd#,#)  
hd#: 磁盘编号，用数字表示；从0开始编号  
#: 分区编号，用数字表示; 从0开始编号  
(hd0,0) 第一块硬盘，第一个分区  

```
手动在grub命令行接口启动系统
grub> root (hd#,#) #MBR所在磁盘和分区
grub> kernel /vmlinuz-VERSION-RELEASE ro root=/dev/DEVICE #内核的文件路径
grub> initrd /initramfs-VERSION-RELEASE.img
grub> boot #文件系统驱动路径
```

### grub legacy配置文件

配置文件：/boot/grub/grub.conf  
**default**=#: 设定默认启动的菜单项；落单项(title)编号从0开始   
**timeout**=#：指定菜单项等待选项选择的时长   
splashimage=(hd#,#)/PATH/XPM_FILE：菜单背景图片文件路径   
password [--md5] STRING: 启动菜单编辑认证   
hiddenmenu：隐藏菜单   
**title** TITLE：定义菜单项“标题”, 可出现多次   
**root** (hd#,#)：查找stage2及kernel文件所在设备分区；为grub的根   
**kernel** /PATH/TO/VMLINUZ_FILE [PARAMETERS]：启动的内核   
**initrd** /PATH/TO/INITRAMFS_FILE: 内核匹配的ramfs文件   
password [--md5|--encrypted ] STRING: 启动选定的内核或操作系统时进行认证   

> 注意配置文件的顺序，initrd和kernel必须是kernel在前，否则不能启动  

---

**实验**：配置文件顺序开机错误

1. 配置文件顺序错误后的报错画面   
![MBR](https://note.youdao.com/yws/api/personal/file/E6B9626CF445464FA22B7670A685EC99?method=download&shareKey=6b42af323e9b7a8f929c0b47fbec5582)  
修复方法：  
1. 进入内核选择界面，按“e”，编辑启动文件   
![MBR](https://note.youdao.com/yws/api/personal/file/72F87AB9BB4149CD99D0E6C4D29CA2F7?method=download&shareKey=dbf59d5cba671c6b9696ee1b2e2c847c)  
2. 看到错误顺序的启动文件，选中顺序错误的inird行，按“d”删除   
![MBR](https://note.youdao.com/yws/api/personal/file/7D42E4FE0219487B9EB838E393476468?method=download&shareKey=f20706c9bfe1d6de19627c2d61eb9fac)  
3. 按“o”--“e”，重新编辑一行initrd   
![MBR](https://note.youdao.com/yws/api/personal/file/68B51ECEE14549D3A9645C783F0CBAC9?method=download&shareKey=5c537e8f3b8b51b7f6c1f7ce903c68ec)  
4. 按“b”重启即可   
![MBR](https://note.youdao.com/yws/api/personal/file/64BF10FA4F95476AACFBDA2E730699B7?method=download&shareKey=b90098a9032ef033117d2f6d5f5dd97c)  
5. 进入系统记得修改错误的/etc/grub.conf文件

---

## grub加密

生成grub口令
- grub-md5-crypt
- grub-crypt  

在/etc/grub.conf中添加密码行  
password --md5 生成的密码  
password --encrypted 生成的密码  

破解root口令：  
启动系统时，设置其运行级别1
进入单用户模式：
- 编辑grub菜单(选定要编辑的title，而后使用a 或 e 命令)
- 在选定的kernel后附加
1, s, S，single 都可以
- 在kernel所在行，键入“b”命令

---
**实验**：误删boot目录后恢复
1. 重启后直接进入grub编辑界面，由于找不到配置文件引起的错误   
![MBR](https://note.youdao.com/yws/api/personal/file/E08C46E12F744A5AB9A5E0051549A2B2?method=download&shareKey=a5db3a9c2f91a9f45f7774920f8030e6)  
2. 光盘重启进入救援模式，使用rpm -ivh /mnt/cdrom/Packages/kerner-2.6.*** --root=/mnt/sysimage/ --force重新安装内核文件，chroot /mnt/sysimage后使用grub-install /dev/sda命令生成grub文件  
![MBR](https://note.youdao.com/yws/api/personal/file/2809E213C7E7494DA271939462793816?method=download&shareKey=16727eb21caf61d8d185c371500130d7)   
3. 进入/boot/grub/ 重新编辑grub文件，内核和initrd文件过长，可以使用r!ls /boot/vm... /boot/init...调用，避免出错。  
![MBR](https://note.youdao.com/yws/api/personal/file/5B8259E5E66A4F369284AAB192A815DD?method=download&shareKey=a744532040f63ca69c764d4751b634c7)  

> 最后最好再检查一下/etc/selinux/config中的运行状态是disabled。

---

实验：fstab文件和/boot目录被破坏，恢复 错误代码15  
1. blkid查看分区和UUID   
2. fdisk -l查看分区大小，mkdir /mnt/rootfs，使用mount挂载后查看有可能的分区 
![MBR](https://note.youdao.com/yws/api/personal/file/B195491CBB99413199FA16D97EB88931?method=download&shareKey=bb04c0f8879f9ed890c084c17f7d0b42)  
3. 修复fstab文件   
![MBR](https://note.youdao.com/yws/api/personal/file/96B803C6BECB43E88B02AAF02E2CFE68?method=download&shareKey=54f893a80f1394e727241d7b1e4f47f4)  
4. 重新光盘启动，即可发现系统分区   
5. 重新安装kernel、grub-install   
![MBR](https://note.youdao.com/yws/api/personal/file/2809E213C7E7494DA271939462793816?method=download&shareKey=16727eb21caf61d8d185c371500130d7)    
6. 重新配置grub.conf文件   
![MBR](https://note.youdao.com/yws/api/personal/file/5B8259E5E66A4F369284AAB192A815DD?method=download&shareKey=a744532040f63ca69c764d4751b634c7)  

> 最后最好再检查一下/etc/selinux/config中的运行状态是disabled  
如果提前chroot切根后，使用 rpm -ivh /mnt/cdrom/kernel-... --force强行安装内核
---

实验：lv逻辑卷分区fstab文件和/boot目录破坏，恢复   
1. lvs查看现有逻辑卷的分区、lvdisplay查看逻辑卷状态   
2. 不能使用mount挂载，逻辑卷组被禁用状态  
![MBR](https://note.youdao.com/yws/api/personal/file/D25B195394F640F3ABA8BE18DE8A5A7B?method=download&shareKey=e790fe9d597c3dc4a19957d37dd97494)  
3. 首先需要vgchage -ay激活逻辑卷  
![MBR](https://note.youdao.com/yws/api/personal/file/B1F4A0ABEAA04A3D9F1AB263A3E1A25C?method=download&shareKey=83a34cba0bb5b20c36e9d05092d40a79)  
4. mkdir /mnt/rootfs  mount挂载分区  
![MBR](https://note.youdao.com/yws/api/personal/file/F776A2636CD24B2EB8BB72D7D0862F0E?method=download&shareKey=6a59e083e06e193173817e615c341cde)   
5. 重写fstab文件  
![MBR](https://note.youdao.com/yws/api/personal/file/AF66100F829D4A84B57CA1F88EE91055?method=download&shareKey=b17aab7d323cdc25cc628b88345c6b3e)  
6. 光盘重启，进入常规修复 
7. 重新安装kernel、grub-install 
![MBR](https://note.youdao.com/yws/api/personal/file/AE219E055193453EBACA5B612745B1A9?method=download&shareKey=48be84cd2f79549e1d5eba511875dd59)
8. 重新配置grub.conf文件  
![MBR](https://note.youdao.com/yws/api/personal/file/0B91B27A84FD41F8852A0FB956EDBF78?method=download&shareKey=d49501fa22958f26f4a0586ebdf2426f)  
> 注意grub.conf中逻辑卷的root目录写法  

# /proc目录

内核把自己内部状态信息及统计信息，以及可配置参数通过proc伪文件系统加以输出  

/proc/sys
- sysctl命令用于查看或设定此目录中诸多参数  
sysctl -w path.to.parameter=VALUE  
sysctl -w kernel.hostname=mail.magedu.com  
- echo命令通过重定向方式也可以修改大多数参数的值  
echo "VALUE" > /proc/sys/path/to/parameter  
echo “websrv” > /proc/sys/kernel/hostname  

sysctl命令：  
默认配置文件：**/etc/sysctl.conf**（centos6）  
- 设置某参数  
**sysctl -w** parameter=VALUE  
- 通过读取配置文件设置参数(一些修改过的值需重启才可生效)   
**sysctl -p** [/path/to/conf_file]  
- 查看所有生效参数  
**sysctl -a**  

常用的几个参数：默认0为关闭或忽略  1为启用  
#内核路由转发功能  
net.ipv4.ip_forward   
#内核忽略ICMP响应  
net.ipv4.icmp_echo_ignore_all   
#清理内核缓存  
vm.drop_caches 

# /sys目录

- sysfs：为用户使用的伪文件系统，输出内核识别出的各硬件设备的相关属性信息，也有内核对硬件特性的设定信息；有些参数是可以修改的，用于调整硬件。

工作特性
- udev通过此路径下输出的信息动态为各设备创建所需要设备文件，udev是运行用户空间程序。

专用工具：udevadmin, hotplug
- udev为设备创建设备文件时，会读取其事先定义好的规则文件，一般在`/etc/udev/rules.d`及`/usr/lib/udev/rules.d`目录下

# 内核编译  

单内核体系设计、但充分借鉴了微内核设计体系的优点，为内核引入模块化机制

内核组成部分：  

- kernel：内核核心，一般为bzImage，通常在/boot目录下，名称为 vmlinuz-VERSION-RELEASE  
只集成必要的常用模块

- kernel object：内核对象，一般放置于
**/lib/modules/VERSION-RELEASE/**  
非必要的模块，按需启动，例如大量的驱动程序  
[ ]: N 不启用  
[M]: M 存放在/lib/modules中  
[*]: Y 启用到kernel中

- 辅助文件：ramdisk initrd initramfs

---

**查看内核信息**
uname | 说明
---|---
-n | 显示节点名称
-r | 显示VERSION-RELEASE
-a | 显示所有信息
 |
lsmod | 显示由核心已经装载的内核模块
--- | 显示的内容来自于/proc/modules文件 
|
modinfo | 显示模块的详细描述信息
-n | 只显示模块文件路径
-p | 显示模块参数
-a | 作者
-d | 描述 

## 内核模块管理

硬件模块的信息，不常修改  

- modprobe命令：装载或卸载内核模块，自动解决依赖性    
modprobe [ -C config-file ] [ modulename ] [ module parame-ters... ]  
modprobe [ -r ] modulename…  
配置文件：/etc/modprobe.conf, /etc/modprobe.d/*.conf

- depmod命令：内核模块依赖关系文件及系统信息映射文件的生成工具  

- insmod命令 指定模块文件，不自动解决依赖模块
insmod [ filename ] [ module options... ]  
insmod `modinfo –n exportfs`  
lnsmod `modinfo –n xfs`  
- rmmod命令：卸载模块  
rmmod [ modulename ]  
rmmod xfs  
rmmod exportfs  

## 编译内核

前提：  
1. 准备好开发环境  
2. 获取目标主机上硬件设备的相关信息  
3. 获取目标主机系统功能的相关信息  
 例如:需要启用相应的文件系统  
4. 获取内核源代码包  
 www.kernel.org
> 使用lscpu、lsblk等可以方便的查看硬件信息

编译流程：
- 安装开发包组 #yum groupinstall "development tools"
- 下载源码文件
- .config：准备文本配置文件  
可以参考现有系统的配置文件，将/boot下的.config文件cp到准备编译的目录下
- make menuconfig：图形化配置内核选项
- make [-j #] #指定线程数提高效率
- make modules_install：安装模块
- make install ：安装内核相关文件  
安装bzImage为/boot/vmlinuz-VERSION-RELEASE  
生成initramfs文件  
编辑grub的配置文件
```
示例
tar xf linux-3.10.67.tar.xz -C /usr/src
cd /usr/src
ln -sv linux-3.10.67 linux
cd /usr/src/linux
cp /boot/config-$(uname -r) ./.config
make help
make menuconfig #图形化配置
make -j 2 #指定线程数提高效率
make modules_install
make install
reboot
```
- 配置内核选项  
支持“更新”模式进行配置：make help  
(a) make config：基于命令行以遍历的方式配置内核中可配置的每个选项   
(b) make menuconfig：基于curses的文本窗口界面  
(c) make gconfig：基于GTK (GNOME）环境窗口界面  
(d) make xconfig：基于QT(KDE)环境的窗口界面  
支持“全新配置”模式进行配置   
(a) make defconfig：基于内核为目标平台提供的“默认”配置进行配置  
(b) make allyesconfig: 所有选项均回答为“yes“    
(c) make allnoconfig: 所有选项均回答为“no“  

- 编译  
全编译:make [-j #]   
编译内核的一部分功能：   
(a) 只编译某子目录中的相关代码   
cd /usr/src/linux   
make dir/   
(b) 只编译一个特定的模块   
cd /usr/src/linux   
make dir/file.ko   
示例：只为e1000编译驱动：写出准确的编译路径   
make drivers/net/ethernet/intel/e1000/e1000.ko

- 如何交叉编译内核：  
编译的目标平台与当前平台不相同  
make ARCH=arch_name  
要获取特定目标平台的使用帮助  
make ARCH=arch_name help  
示例：  
make ARCH=arm help  

### 清理编译文件

在已经执行过编译操作的内核源码树做重新编译

需要事先清理操作：  
**make clean**：清理大多数编译生成的文件，但会保留config文件等   
**make mrproper**: 清理所有编译生成的文件、config及某些备份文件  
**make distclean**：mrproper、清理patches以及编辑器备份文件   

### 卸载内核
删除/lib/modules/目录下不需要的内核库文件  
删除/usr/src/linux/目录下不需要的内核源码  
删除/boot目录下启动的内核和内核映像文件  
更改grub的配置文件，删除不需要的内核启动列表  

# Centos7 systemd

开机流程  
`POST --> Boot Sequence --> Bootloader --> kernel + initramfs(initrd) --> rootfs --> /sbin/init`  
init: 各版本区别   
CentOS 5 SysV init  
CentOS 6 Upstart  
CentOS 7 Systemd  

Systemd：系统启动和服务器守护进程管理器，负责在系统启动或运行时，激活系统资源，服务器进程和其它进程

Systemd新特性  
- 系统引导时实现服务并行启动  
- 按需启动守护进程  
- 自动化的服务依赖关系管理  
- 同时采用socket式与D-Bus总线式激活服务  
- 系统状态快照  
> 并行启动服务大幅提高启动速度，利用socket解决服务依赖性

- 核心概念：**unit**  
unit表示不同类型的systemd对象，通过配置文件进行标识和配置；文件中主要包含了系统服务、监听socket、保存的系统快照以及其它与init相关的信息  
- 配置文件  
**/usr/lib/systemd/system**:每个服务最主要的启动脚本设置，类似于之前的/etc/init.d/  
**/run/systemd/system**：系统执行过程中所产生的服务脚本，比上面目录优先运行  
**/etc/systemd/system**：管理员建立的执行脚本，类似于/etc/rcN.d/Sxx的功能，比上面目录优先运行

## Unit类型

systemctl -t help 查看unit类型
- **service** unit: 文件扩展名为.service, 用于定义系统服务
- **Target** unit:文件扩展名为.target，用于模拟实现运行级别
- Device unit: .device, 用于定义内核识别的设备
- Mount unit: .mount, 定义文件系统挂载点
- **Socket** unit: .socket, 用于标识进程间通信用的socket文件，也可在系统启动时，延迟启动服务，**实现按需启动**
- Snapshot unit: .snapshot, 管理系统快照
- Swap unit: .swap, 用于标识swap设备
- Automount unit:.automount，文件系统的自动挂载点
- Path unit: .path，用于定义文件系统中的一个文件或目录使用,常用于当文件系统变化时，延迟激活服务，如：spool 目录

---

- 关键特性：  
基于socket的激活机制：socket与服务程序分离  
基于d-bus的激活机制：   
基于device的激活机制：   
基于path的激活机制：    
系统快照：保存各unit的当前状态信息于持久存储设备中    
向后兼容sysv init脚本   
- 不兼容：  
systemctl命令固定不变，不可扩展  
不是由systemd启动的服务，systemctl无法与之通信和控制

## 管理服务

**管理系统服务**：   
CentOS 7: service unit
注意：能兼容早期的服务脚本  

命令：systemctl COMMAND name.service   
- 启动：service name start ==> systemctl start name.service  
- 停止：service name stop ==> systemctl stop name.service  
- 重启：service name restart ==> systemctl restart name.service  
- 状态：service name status ==> systemctl status name.service  

> 与service不同的是命令的所在位置，使用systemctl 可以同时启动或停止多个命令  

- 禁止自动和手动启动：  
systemctl mask name.service  
- 取消禁止：  
systemctl unmask name.service  
> 创建一个软链接到/dev/null，临时禁用服务  

**服务查看**

- 查看某服务当前激活与否的状态：  
systemctl is-active name.service
- 查看所有已经激活的服务：  
systemctl list-units --type|-t service
- 查看所有服务：  
systemctl list-units --type service --all|-a

chkconfig命令的对应关系：

- 设定某服务开机自启：  
chkconfig name on ==> **systemctl enable name.service**
- 设定某服务开机禁止启动：  
chkconfig name off ==> **systemctl disable name.service**  
- 查看所有服务的开机自启状态：  
chkconfig --list ==> **systemctl list-unit-files** --type service
- 用来列出该服务在哪些运行级别下启用和禁用：  
chkconfig sshd –list ==>
 ls /etc/systemd/system/*.wants/sshd.service
- 查看服务是否开机自启：  
**systemctl is-enabled** name.service
- 其它命令：
查看服务的依赖关系：  
systemctl list-dependencies name.service
- 杀掉进程：  
**systemctl kill** unitname

**服务状态**  

systemctl list-unit-files --type service --all显示状态
- loaded Unit配置文件已处理
- active(running) 一次或多次持续处理的运行
- active(exited) 成功完成一次性的配置
- active(waiting) 运行中，等待一个事件
- inactive 不运行
- enabled 开机启动
- disabled 开机不启动
- static 开机不启动，但可被另一个启用的服务激活

## service unit文件格式

/etc/systemd/system：系统管理员和用户使用  
/usr/lib/systemd/system：发行版打包者使用  
以"#"开头的行后面的内容会被认为是注释。   
相关布尔值，1、yes、on、true都是开启，0、no、off、false 都是关闭。   
时间单位默认是秒，所以要用毫秒（ms）分钟（m）等须显式说明。  

service unit file文件通常由三部分组成：  
- **[Unit]**：定义与Unit类型无关的通用选项；用于提供unit的描述信息、unit行
为及依赖关系等
- **[Service]**：与特定类型相关的专用选项；此处为Service类型
- **[Install]**：定义由“systemctl enable”以及"systemctl disable“命令在
实现服务启用或禁用时用到的一些选项

**[Unit]**段的常用选项：   
- Description：描述信息  
- After：定义unit的启动次序，表示当前unit应该晚于哪些unit启动，其功能与Before相反  
- Requires：依赖到的其它units，强依赖，被依赖的units无法激活时，当前unit也无法激活  
- Wants：依赖到的其它units，弱依赖  
- Conflicts：定义units间的冲突关系   

**[Service]**段的常用选项：
- Type：定义影响ExecStart及相关参数的功能的unit进程启动类型
- simple：默认值，这个daemon主要由ExecStart接的指令串来启动，启动后常驻于内存中
- forking：由ExecStart启动的程序透过spawns延伸出其他子程序来作为此
daemon的主要服务。原生父程序在启动结束后就会终止
- oneshot：与simple类似，不过这个程序在工作完毕后就结束了，不会常驻在内存中
- dbus：与simple类似，但这个daemon必须要在取得一个D-Bus的名称后，才会继续运作.因此通常也要同时设定BusNname= 才行
- notify：在启动完成后会发送一个通知消息。还需要配合 NotifyAccess 来让Systemd 接收消息
- idle：与simple类似，要执行这个daemon必须要所有的工作都顺利执行完毕后才会执行。这类的daemon通常是开机到最后才执行即可的服务
- EnvironmentFile：环境配置文件
- ExecStart：指明启动unit要运行命令或脚本的绝对路径
- ExecStartPre： ExecStart前运行
- ExecStartPost： ExecStart后运行
- ExecStop：指明停止unit要运行的命令或脚本
- Restart：当设定Restart=1 时，则当次daemon服务意外终止后，会再次自动
启动此服务

**[Install]**段的常用选项：
- Alias：别名，可使用systemctl command Alias.service
- RequiredBy：被哪些units所依赖，强依赖
- WantedBy：被哪些units所依赖，弱依赖
- Also：安装本服务的时候还要安装别的相关服务

> 注意：对于新创建的unit文件，或者修改了的unit文件，要通知systemd重载此配置文件,而后可以选择重启   
systemctl daemon-reload

```
备份服务Unit示例
vim /etc/systemd/system/bak.service
[Unit]
Description=backup /etc
Requires=atd.service
[Service]
Type=simple #单次执行
ExecStart=/bin/bash -c "echo /testdir/bak.sh|at now" #激活后立即执行备份
[Install]
WantedBy=multi-user.target #运行在runlevel3

systemctl daemon-reload
systemctl start bak
```
## 运行级别

**target units**：   
unit配置文件：.target   
ls /usr/lib/systemd/system/*.target   
systemctl list-unit-files --type target --all   

**运行级别**：   
0 ==> runlevel0.target, poweroff.target  
1 ==> runlevel1.target, rescue.target  
2 ==> runlevel2.target, multi-user.target  
3 ==> runlevel3.target, multi-user.target  
4 ==> runlevel4.target, multi-user.target  
5 ==> runlevel5.target, graphical.target  
6 ==> runlevel6.target, reboot.target  

**查看依赖性**：  
systemctl list-dependencies graphical.target

**级别切换**：  
init N ==> systemctl isolate name.target  
例如：systemctl isolate multi-user.target    
注：只有/lib/systemd/system/*.target文件中AllowIsolate=yes 才能切换   
> 修改文件需执行systemctl daemon-reload才能生效

**查看target**：  
runlevel ;who -r  
systemctl list-units --type target  

**获取默认运行级别**：  
/etc/inittab ==> systemctl get-default

**修改默认级别**：  
/etc/inittab ==> systemctl set-default name.target   
例如：  
systemctl set-default multi-user.target   
ls –l /etc/systemd/system/default.target   

## 其它命令

- 切换至紧急救援模式：  
systemctl rescue  
- 切换至emergency模式：  
systemctl emergency  
- 其它常用命令：  
传统命令init，poweroff，halt，reboot都成为
systemctl的软链接   
关机：systemctl halt、systemctl poweroff  
重启：systemctl reboot  
挂起：systemctl suspend  
休眠：systemctl hibernate  
休眠并挂起：systemctl hybrid-sleep  


# Centos7引导顺序  

1. UEFi或BIOS初始化，运行POST开机自检
2. 选择启动设备
3. 引导装载程序, centos7是grub2
4. 加载装载程序的配置文件：  
/etc/grub.d/  
/etc/default/grub  
/boot/grub2/grub.cfg #不需要手工编辑
1. 加载initramfs驱动模块
1. 加载内核选项
1. 内核初始化，centos7使用systemd代替init
1. 执行initrd.target所有单元，包括挂载/etc/fstab
1. 从initramfs根文件系统切换到磁盘根目录
1. systemd执行默认target配置，配置文件/etc/systemd/system/default.target
1. systemd执行sysinit.target初始化系统及basic.target准备操作系统
1. systemd启动multi-user.target下的本机与服务器服务
1. systemd执行multi-user.target下的/etc/rc.d/rc.local
1. Systemd执行multi-user.target下的getty.target及登录服务
1. systemd执行graphical需要的服务

> systemd-analyze plot  查看详细的启动流程和时间花费  
systemd-analyze plot >boot.html 重定向可以方便的使用网页查看

设置内核参数，只影响当次启动
- 启动时，在linux16行后添加systemd.unit=multi-user.target #指定运行在字符界面
- systemd.unit=emergency.target #急救模式
- systemd.unit=rescue.target  #维护模式 类似runlevel 1
- rescue.target 比emergency支持更多的功能，例如日志等
- systemctl default 进入默认target

> 在启动界面修改运行级别时使用ctrl+x重启

## 启动排错

- 文件系统损坏
先尝试自动修复，失败则进入emergency shell，提示用户修复
- 在/etc/fstab不存在对应的设备和UUID
等一段时间，如不可用，进入emergency shell
- 在/etc/fstab不存在对应挂载点
systemd 尝试创建挂载点，否则提示进入emergency shell.
- 在/etc/fstab不正确的挂载选项
提示进入emergency shell

进入emergency shell后
1. 输入root密码
2. 重新修改错误的/etc/fstab
3. 进行其它的排错  

---

实验：破解centos7口令方法一
1. 启动时任意键暂停启动
1. 按e键进入编辑模式
1. 将光标移动linux16开始的行，添加内核参数rd.break，按ctrl-x启动  
![grub](https://note.youdao.com/yws/api/personal/file/DA739FDF9E9B43EDA33725D294597BBC?method=download&shareKey=156437265744ec1f8469721c9e801d53)  
1. mount –o remount,rw /sysroot
1. chroot /sysroot   
![grub](https://note.youdao.com/yws/api/personal/file/49B4F43525CF4C71B90206024F394B78?method=download&shareKey=b99e7af27353de5750e1b409bf339af0)    
1. passwd root
1. touch /.autorelabel #如果selinux开启需执行
1. exit
1. reboot

---

实验：破解centos7口令方法二
1. 启动时任意键暂停启动
1. 按e键进入编辑模式
1. 将光标移动linux16开始的行，改为rw init=/sysroot/bin/sh，按ctrl-x启动   
![grub](https://note.youdao.com/yws/api/personal/file/EED58C583CFF4853A6E34B3A6C0F1018?method=download&shareKey=445e770c01196284d1f50b8ebb93a255)  
1. chroot /sysroot
1. passwd root
1. touch /.autorelabel
1. exit
1. reboot

> 如果selinux开启，需touch /.autorelable

---
实验：修复GRUB2   
GRUB“the Grand Unified Bootloader”   
引导提示时可以使用命令行界面   
可从文件系统引导   
主要配置文件 /boot/grub2/grub.cfg

修复配置文件
grub2-mkconfig -o /boot/grub2/grub.cfg

修复grub
grub2-install /dev/sda BIOS环境
grub2-install UEFI环境

调整默认启动内核
vim /etc/default/grub
GRUB_DEFAULT=0

1. /boot下的grub文件被破坏  
![grub](https://note.youdao.com/yws/api/personal/file/D83C6433B5204592A567FB1690D6F7DE?method=download&shareKey=3a2251b22f4c8f4db54e4fc5d2cca40a)  
2. 进入光盘恢复模式
3. chroot /mnt/sysimage
4. grub2-install /dev/sda   
![grub](https://note.youdao.com/yws/api/personal/file/16087F504E3147AC9A3930BC9B1EA3BA?method=download&shareKey=36cbea592b6a5d81fd752e8c243e2a24)  
5. grub2-mkconfig -o /boot/grub2/grub.cfg  
![grub](https://note.youdao.com/yws/api/personal/file/3FACB6C698404BBF8E9F183738E7A0C0?method=download&shareKey=3c505fbb9fc7ac321bf475e6cba74caa)  
6. exit 
7. reboot

> grub2-setpassword 配置grub启动密码  
  

---

实验：误删/boot/文件，恢复 
1. 光盘进入救援模式
2. chroot /mnt/sysimage
3. mount /dev/sr0 /mnt
4. rpm -ivh /mnt/Packages/kernel-3.10... --force   
![grub](https://note.youdao.com/yws/api/personal/file/B94EAD135CB54F47811F06CD26C610D0?method=download&shareKey=f693ef2238883bbfbb067bc88ab046a4)  
5. grub2-install /dev/sda   
![grub](https://note.youdao.com/yws/api/personal/file/16087F504E3147AC9A3930BC9B1EA3BA?method=download&shareKey=36cbea592b6a5d81fd752e8c243e2a24)  
6. grub2-mkconfig -o /boot/grub2/grub.cfg  
![grub](https://note.youdao.com/yws/api/personal/file/3FACB6C698404BBF8E9F183738E7A0C0?method=download&shareKey=3c505fbb9fc7ac321bf475e6cba74caa)  
7. exit 
8. reboot


