# 存储基础知识---存储网络
## DAS(Direct Attached Storage)直连式存储
存储设备是通过电缆（通常是SCSI接口电缆）直接挂到服务器总线上。   
DAS方案中外接式存储设备目前主要是指RAID、JBOD等。
管理成本较低，实施简单   
• 储时直接依附在服务器上，因此存储共享受到限制   
• CPU必须同时完成磁盘存取和应用运行的双重任务，所以不利于CPU的指令周期的优化，增加系统负担

## NAS(Network Attached Storage)网络附属存储 
通过局域网在多个文件服务器之间实现了互联，基于文件的协议（ FTP、NFS、SMB/CIFS等 ），实现文件共享   
集中管理数据，从而释放带宽、提高性能   
• 可提供跨平台文件共享功能  
• 可靠性较差，适用于局域网或较小的网络  
> 资源存储在远程主机的文件系统上，客户端通过网络连接只能访问这个存储资源，但不可以用文件系统管理这个资源，资源由服务器端管理

## SAN(Storage Area Network) 存储区域网络
利用高速的光纤网络链接服务器与存储设备，基于SCSI，IP，ATM等多种高级协议，实现存储共享    
• 服务器跟储存装置两者各司其职   
• 利用光纤信道来传输数据﹐以达到一个服务器与储存装置之间多对多的高效能、高稳定度的存储环境  
• 实施复杂，管理成本高
> 远程的磁盘映射成为本机的一个块设备，可以在这块磁盘上进行分区、创建文件系统，存储数据等，管理由自己管理。

## NAS、SAN、DAS特性对比
![NAS](http://blog.51cto.com/attachment/201307/160056769.jpg)  
![SAN](http://img.my.csdn.net/uploads/201211/27/1354025272_7800.png)

# 文件传输协议FTP
- File Transfer Protocol 早期的三个应用级协议之一    
基于C/S结构    
双通道协议：数据和命令连接     
- 数据传输格式：二进制（默认）和文本     
- 两种模式：**服务器角度**   
主动(PORT style)：**服务器主动连接**    
命令（控制）：客户端：随机port---服务器：tcp21   
数据：客户端：随机port---服务器：tcp20    
被动(PASV style)：**客户端主动连接**    
命令（控制）：客户端：随机port ---服务器：tcp21   
数据：客户端：**随机port** ---服务器：**随机port**    
> 服务器被动模式数据端口示例：    
227 Entering Passive Mode (172,16,0,1,224,59)    
服务器数据端口为：224*256+59    

在FTP服务开启之后，命令通道端口就会打开，命令通道负责传输命令以及协商在主动和被动模式下数据通道服务器端的端口号。   
客户端通知服务器端数据通道的端口号是通过命令通道通讯的，数据通道服务器端口只有在传输数据的时候才会打开。   
linux中默认是被动模式，windows中默认是主动模式。   
> 专业硬件防火墙通过连接跟踪link tracke功能来监控命令通道中的随机端口来保持通讯

## 主动(PORT style)模式
![ftp](https://img-blog.csdn.net/20170508181930596?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvemhhbmd5dWFuMTI4MDU=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
## 被动(PASV style)模式
![ftp](https://img-blog.csdn.net/20170508183834824?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvemhhbmd5dWFuMTI4MDU=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
# FTP软件介绍
vsftpd:Very Secure FTP Daemon，CentOS默认FTP服务器       
客户端软件：    
- ftp：支持匿名、系统用户、虚拟用户登录，当用匿名账号登录时，用户名要输入ftp或者anonymous，密码可以不用输入或者随便输入一个就可以     
- lftp:支持匿名登录，可以不用输入用户名和密码直接登录，并且登录后输入命令支持补全，十分方便     
- lftpget：直接下载远程服务器上的单个文件   
- **wget**：用来从指定的URL下载文件   
- curl：可以访问ftp服务器    
```
ftp -A ftpserver port -A主动模式–p 被动模式
lftp –u username ftpserver
lftp username@ftpserver
lftpget ftp://ftpserver/pub/file
```
# FTP服务
- 状态码：    
1XX：信息 125：数据连接打开    
2XX：成功类状态 200：命令OK 230：登录成功    
3XX：补充类 331：用户名OK   
4XX：客户端错误 425：不能打开数据连接  
5XX：服务器错误 530：不能登录    
- 用户认证：    
匿名用户：ftp,anonymous,对应Linux用户ftp   
系统用户：Linux用户,用户/etc/passwd,密码/etc/shadow    
虚拟用户：特定服务的专用用户，独立的用户/密码文件    
nsswitch:network service switch名称解析框架   
pam:pluggable authentication module 用户认证
/lib64/security /etc/pam.d/ /etc/pam.conf

# vsftpd服务
由vsftpd包提供    
不再由xinetd管理     
用户认证配置文件：/etc/pam.d/vsftpd    
服务脚本：   /usr/lib/systemd/system/vsftpd.service    
/etc/rc.d/init.d/vsftpd    
**配置文件**：/etc/vsftpd/vsftpd.conf    
man 5 vsftpd.conf    
格式：option=value   
> 注意：= 前后不要有空格   

匿名用户（映射为系统用户ftp）    
**共享文件位置**：/var/ftp    
系统用户共享文件位置：用户家目录    
虚拟用户共享文件位置：为其映射的系统用户的家目录 

# vsftpd服务配置

配置项 | 配置|说明
---|---|---
监听端口 | listen_port=21|默认监听端口
主动模式端口 | connect_from_port_20=YES|主动模式端口为20
---|ftp_data_port=20 （默认）|指定主动模式的端口
被动模式端口范围|pasv_min_port=6000 |最小从6000开始，0为随机分配
---|pasv_max_port=6010|最大到6010
使用当地时间|use_localtime=YES|使用当地时间（默认为NO，使用GMT），会造成不同客户端的时间差异
匿名用户|anonymous_enable=YES|支持匿名用户
---|no_anon_password=YES|默认NO,匿名用户略过口令检查
---|anon_world_readable_only|默认YES,只能下载全部所有者都可读的文件
---|anon_upload_enable=YES|匿名上传，注意:文件系统权限
---|anon_mkdir_write_enable=YES|匿名建目录
---|anon_umask=0333|指定匿名上传文件的umask，默认077
---|anon_other_write_enable=YES|可删除和修改上传的文件
上传文件的所有者和权限|chown_uploads=YES|默认NO,是否允许改变上传文件的所有者
---|chown_username=nie|设置想要改变的上传文件的所有者
---|chown_upload_modee=0644|设置想要改变的上传文件的权限
Linux系统用户|local_enable=YES|是否允许linux用户登录
---|write_enable=YES|允许linux用户上传文件
---|local_umask=022|指定系统用户上传文件的默认权限，即默认创建的文件权限是755
系统用户映射（优先级高于chroot禁锢）|guest_enable=YES|所有系统用户都映射成guest用户
---|guest_username=ftp|配合上面选项才生效，指定guest用户
---|local_root=/ftproot|guest用户登录所在目录
禁锢所有系统用户在家目录中|chroot_local_user=YES|（默认NO，不禁锢），禁锢系统用户
是否禁锢特定的系统用户在家目录中，与上面设置功能相反|chroot_list_enable=YES|启用禁锢名单功能
---|chroot_list_file=/etc/vsftpd/chroot_list|指定禁锢名单文件路径
---|---|当chroot_local_user=YES时，则chroot_list中**用户不禁锢**
---|---|当chroot_local_user=NO时，则chroot_list中**用户禁锢**
wu-ftp日志|默认启用
---|xferlog_enable=YES|启用记录上传下载日志
---|xferlog_std_format=YES|使用wu-ftp日志格式
---|xferlog_file=/var/log/xferlog|可自动生成
vsftpd日志|默认不启用
---|dual_log_enable=YES|使用vsftpd日志格式，默认不启用
---|vsftpd_log_file=/var/log/vsftpd.log|可自动生成
登录提示信息|ftpd_banner=|设置标题
---|banner_file=/etc/vsftpd/ftpbanner.txt|多行标题文件可使用文件的方式
目录访问提示信息|dirmessage_enable=YES|默认启用，用于标识各个目录的说明
---|message_file=.message|信息存放在指定目录下.message
使用pam模块完成用户认证|pam_service_name=vsftpd|指定pam模块
---|/etc/pam.d/vsftpd|vsftp  pam配置文件
---|/etc/vsftpd/ftpusers|默认文件中用户拒绝登录
是否启用控制用户登录的列表文件|userlist_enable=YES|配置文件默认设置
---|userlist_deny=YES|默认黑名单,不提示口令，NO为白名单
---|userlist_file=/etc/vsftpd/users_list|默认值
vsftpd服务指定用户身份运行|nopriv_user=nobody|默认值
连接数限制|max_clients=0|最大并发连接数
---|max_per_ip=0|每个IP同时发起的最大连接数
传输速率 字节/秒|anon_max_rate=0|匿名用户的最大传输速率
---|local_max_rate=0 |**本地用户**的最大传输速率
连接时间：秒为单位|connect_timeout=60|主动模式数据连接超时时长
---|accept_timeout=60|被动模式数据连接超时时长
---|data_connection_timeout=300|数据连接无数据输超时时长
---|idle_session_timeout=60|无命令操作超时时长
> ftp根目录任何人都不能有写权限，登录会报错  
如果想上传，可以在根目录下创建一个子目录，对这个子目录授权对ftp用户具有写权限

# 实现基于SSL的FTPS
```
查看vsftpd服务是否支持SSL
ldd `which vsftpd` 查看到libssl.so
1、创建自签名证书
cd /etc/pki/tls/certs/           #利用makefile一步生成私钥和证书
make vsftpd.pem
openssl x509 -in vsftpd.pem -noout -text   ---可以查看一下这个证书
mkdir /etc/vsftpd/ssl
mv vsftpd.pem /etc/vsftpd/ssl    #拷贝证书到vsftp路径下
2、修改vsftpd的配置文件
vim /etc/vsftpd/vsftpd.conf 
ssl_enable=YES
allow_anon_ssl=NO
force_local_logins_ssl=YES
force_local_data_ssl=YES
rsa_cert_file=/etc/vsftpd/ssl/vsftpd.pem    #指明证书文件
systemctl restart vsftpd
3、用filezilla等工具测试
加密方式：FTP over TLS
```
# vsftpd虚拟用户
- 虚拟用户：     
所有虚拟用户会统一映射为一个**指定的系统帐号**：访问共享位置，即为此系统帐号的家目录    
各虚拟用户可被赋予不同的访问权限，通过匿名用户的权限控制参数进行指定    
- 虚拟用户帐号的存储方式：    
1. 文件：编辑文本文件，此文件需要被编码为hash格式   
**奇数行为用户名，偶数行为密码**    
`db_load -T -t hash -f vusers.txt vusers.db  `  
1. 关系型数据库中的表中：     
实时查询数据库完成用户认证     
mysql库：pam要依赖于pam-mysql       
/lib64/security/pam_mysql.so   
/usr/share/doc/pam_mysql-0.7/README   
## 实现基于DB文件的FTP虚拟用户
```
1、创建Berkeley DB格式的数据库文件
vim /etc/vsftpd/vusers.txt   #奇数行为用户名，偶数行为密码
ftp1
centos
ftp2
centos
cd /etc/vsftpd/
db_load -T -t hash -f vusers.txt vusers.db   #利用db_load生成db格式的数据库文件
chmod 600 vusers.db                          #为了安全修改一下权限
2、创建一个系统账号，用于代替虚拟账号去访问磁盘的资源
mkdir /data/ftp/
chmod 555 /data/ftp/                         #匿名登录和虚拟用户登录的根目录不能具有写权限
useradd -d /data/ftp -s /sbin/nologin ftpvuser  #创建映射账户
chown ftpvuser.ftpvuser /data/ftp/  #修改根目录所有者和所有组
mkdir download
mkdir upload   #创建可以上传的文件夹
setfacl -m u:ftpvuser:rwx /data/ftp/upload/ 
 #赋予账户可以读写的acl权限
3、创建pam配置文件
vim /etc/pam.d/vsftpd.db
auth required pam_userdb.so db=/etc/vsftpd/vusers   #调用pam_userdb.so这个模块，并指明db数据库文件的路径，注意这里不写vusers.db，直接简写成 vusers
account required pam_userdb.so db=/etc/vsftpd/vusers
4、修改vsftpd的配置文件
vim /etc/vsftpd/vsftpd.conf 
pam_service_name=vsftpd.db              #指明pam配置文件，不用写/etc/pam.d，会自动找到这个目录，pam配置文件都是在这个目录下
guest_enable=YES                             
guest_username=ftpvuser                      #设置将所有虚拟用户映射成一个系统账号ftpvuser
user_config_dir=/etc/vsftpd/vusers.d/        #指明虚拟用户的配置文件的目录
anonymous_enable=NO #设定不允许匿名访问
local_enable=YES #设定本地用户可以访问。注：如使用虚拟宿主用户，在该项目设定为NO的情况下所有虚拟用户将无法访问
chroot_list_enable=YES #此行注释掉
ascii_upload_enable=YES
ascii_download_enable=YES #设定支持ASCII模式的上传和下载功能
pasv_min_port=20000    #设定被动模式下的端口范围，并开启防火墙
pasv_max_port=30000
5、建立虚拟用户各自的配置文件
cd /etc/vsftpd/vusers.d/
vim ftp1           #注意配置文件的名字要和虚拟用户的名字对应   
local_root=/data/ftp       #指定ftp1的根目录
write_enable=YES           #允许系统用户上传
anon_world_readable_only=NO                  #不需要所有人都有读权限就可以下载
anon_upload_enable=YES                       #设置具有上传权限
anon_mkdir_write_enable=YES                  #设置具有创建文件的权限
anon_other_write_enable=YES                  #可以删除和修改上传的文件
vim ftp2
local_root=/data/ftp2                        #指定不同的根目录
anon_upload_enable=YES  
anon_mkdir_write_enable=YES
6、准备ftp2的目录
mkdir -p /data/ftp2/upload
chown ftpvuser /data/ftp2/upload  #使虚拟用户映射后的系统用户对这个目录具有写权限，因为是这个系统用户代替虚拟用户去访问磁盘上资源，可以设置acl权限
7、测试
用filezilla等工具测试访问 ftp 192.168.34.8
通过登录虚拟账号的用户名和密码来登录到服务器上访问响应的资源

可以结合上面的实验使用SSL和虚拟用户一起使用，保证安全和灵活性
```
> 总结：vsftpd服务和httpd服务相似，匿名账号访问的时候都会映射为服务器的一个系统账号。  
vsftpd映射为ftp用户，httpd映射为apache用户，通过系统账号才能访问自己磁盘上的资源，如果无法访问可能是文件系统的权限。限制ftp或者apache用户去访问，或者配置文件中的限制。

## 实现基于MYSQL验证的vsftpd虚拟用户
```
环境：两台centos7主机，一台ftp服务器，一台mysql服务器
1、在ftp服务器
yum groupinstall "development tools"
yum install vsftpd mariadb-devel pam-devel openssl-devel 
2、在ftp服务器编译pam_mysql
tar xvf pam_mysql-0.7RC1.tar.gz 
cd pam_mysql-0.7RC1/
./configure --with-mysql=/usr --with-pam=/usr  --with-pam-mods-dir=/lib64/security
生成的模块路径：
/lib64/security/pam_mysql.so
3、在ftp服务器，准备虚拟用户映射的系统用户
useradd -s /sbin/nologin -d /data/ftp ftpvuser 
chmod 555 /data/ftp
cd /data/ftp
mkdir upload
setfacl –m u:ftpvuser:rwx /data/ftp/upload
4、在mysql 服务器，准备用户和数据表
yum install mariadb-server
systemctl start mariadb
mysql 
>create database vsftpd;      #创建数据库
>create table ftpuser(id int unsigned auto_increment primary key,username char(30) binary not null,password char(48) binary not null);   #创建表,binary参数设置区分字段大小写
>insert ftpuser(username,password) values('ftp1',password('linux')),('ftp2',password('centos'));    #在表中插入用户名和密码，将来为ftp服务用的虚拟用户的账号和密码。password调用加密函数加密密码
>grant select on vsftpd.ftpuser to ftpuser@'192.168.34.7' identified by 'linux';   #授权一个远程的用户去管理这个数据库
5、在ftp服务器上创建PAM配置文件
vim /etc/pam.d/ftp.mysql
auth required pam_mysql.so user=ftpuser passwd=linux host=192.168.34.10 db=vsftpd table=ftpuser usercolumn=username passwdcolumn=password crypt=2
account required pam_mysql.so user=ftpuser passwd=linux host=192.168.34.10 db=vsftpd table=ftpuser usercolumn=username passwdcolumn=password crypt=2
#注：crypt是加密方式，0表示不加密，1表示crypt(3)加密，2表示使用mysql password()函数加密，3表示md5加密，4表示sha1加密
#auth 表示认证
#account 验证账号密码正常使用
#required 表示认证要通过
#pam_mysql.so模块是默认的相对路径，是相对/lib64/security/路径而言，也可以写绝对路径；后面为给此模块传递的参数
#user=vsftpd为登录mysql的用户
#passwd=magedu 登录mysql的的密码
#host=mysqlserver mysql服务器的主机名或ip地址
#db=vsftpd 指定连接msyql的数据库名称
#table=users 指定连接数据库中的表名
#usercolumn=name 当做用户名的字段
#passwdcolumn=password 当做用户名字段的密码
#crypt=2 密码的加密方式为mysql password()函数加密
6、修改vsftpd配置调用新的pam模块
vim /etc/vsftpd/vsftpd.conf
pam_service_name=ftp.mysql    #指明pam的配置文件
guest_enable=YES
guest_username=ftpvuser       #将虚拟用户映射为一个系统账号
user_config_dir=/etc/vsftpd/vusers.conf.d/  #指明每个虚拟用户的配置的目录
7、mkdir /etc/vsftpd/vusers.conf.d/
vim /etc/vsftpd/vusers.conf.d/ftpuser1      #创建每个虚拟用户的配置文件
anon_upload_enable=YES
vim /etc/vsftpd/vusers.conf.d/ftpuser2
local_root=/data/ftp2/                   #改变虚拟用户的根目录
anon_upload_enable=YES
mkdir -pv /data/ftp2/upload              #创建这个根目录
setfacl –m u:ftpvuser:rwx /data/ftp2/upload         #使系统账号对这个目录有控制权限
#备注：如果Selinux是开启的，相关设置在FTP服务器上执行
restorecon -R /lib64/security   ---从seliux数据库中恢复这个目录的安全上下文
setsebool -P ftpd_connect_db 1  
setsebool -P ftp_home_dir 1   ---设置bool值，此项在centos7中没有，centos7中只有上面那一项
chcon -R -t public_content_rw_t /app/ftpsite  ---改变根目录的安全标签
8、使用软件测试连接
```
## ftp自动上传脚本
```
!/bin/bash
cd /data
ftp -n -i 192.168.34.7 <<EOF  #目标ftp服务器
user ftp1 linux    #登录用户和密码
cd upload
mput *.log         #批量上传.log文件
mget *.txt         #批量下载.txt文件
bye
EOF
```
# NFS服务
NFS：Network File System 网络文件系统，基于内核的文件系统。Sun公司开发，通过使用NFS，用户和程序可以像访问本地文件一样访问远端系统上的文件，基于RPC（Remote Procedure Call Protocol远程过程调用）实现。   
NFS优势：节省本地存储空间，将常用的数据,如home目录,存放在NFS服务器上且可以通过网络访问，本地终端将可减少自身存储空间的使用。  
![nfs](http://image.mamicode.com/info/201803/20180304233736523670.png)
# NFS服务介绍
- 软件包：nfs-utils    
Kernel支持:nfs.ko    
端口：**2049(nfsd)**, 其它端口由portmap|rpcbind(111)分配      
查看已注册的信息：`rpcinfo -p`   
- 配置文件：**/etc/exports**,/etc/exports.d/*.exports    
CentOS7不支持同一目录同时用nfs和samba共享，因为使用锁机制不同   
- 相关软件包:rpcbind（必须），tcp_wrappers   
CentOS6开始portmap进程由rpcbind代替   
- NFS服务主要进程：   
rpc.nfsd 最主要的NFS进程，管理客户端是否可登录   
rpc.mountd 挂载和卸载NFS文件系统，包括权限管理   
rpc.lockd 非必要，管理文件锁，避免同时写出错   
rpc.statd 非必要，检查文件一致性，可修复文件   
- 日志：/var/lib/nfs/
> rpcbind服务用于管理nfs服务的端口，它可以给nfs各服务分配端口并记录下来，客户端不是直接去访问nfs，因为nfs服务由很多服务组成，并且各个服务的端口不是固定的，所以客户端首先去访问rpcbind服务的111端口，通过rpcbind服务找到nfs服务的各个端口，所以安装nfs服务的同时要安装rpcbind服务才可以，centos6上要把rpcbind服务也要设置成开机启动，不然启动了nfs服务也没用，客户端找不到端口，centos7中可以不设置成开机启动，在开启nfs服务的同时会把依赖的服务rpcbind服务同时开启。

# NFS配置文件
vim /etc/exports  
/dir 主机1(opt1,opt2) 主机2(opt1,opt2)...
- 主机格式：   
    - 单个主机：ipv4，ipv6，FQDN   
    - IP networks：两种掩码格式均支持   
        - 172.18.0.0/255.255.0.0   
        - 172.18.0.0/16   
    - wildcards：主机名通配，例如*.magedu.com，IP不可以  
    - netgroups：NIS域的主机组，@group_name  
    - anonymous：表示使用*通配所有客户端   
```
挂载本机的两个NFS目录
vim /etc/exports
/data/nfs1 *
/data/nfs2 *(rw) 
```
- 每个条目指定目录导出到的哪些主机，及相关的权限和选项    
• 默认选项：(ro,sync,root_squash,no_all_squash)   
• ro,rw 只读和读写   
• async 异步，数据变化后不立即写磁盘，性能高   
• sync（1.0.0后为默认）同步，数据在请求时立即写入共享   
• no_all_squash （默认）保留共享文件的UID和GID   
• **all_squash** 所有远程用户(**包括root**)都变成nfsnobody   
• root_squash （默认）远程root映射为nfsnobody,UID为65534
• no_root_squash 远程root映射成root用户    
• anonuid和anongid 指明匿名用户映射为特定用户UID和组GID，而非nfsnobody,可配合all_squash使用    
`/data/nfs1 *(rw,all_squash,anonuid=1000,anongid=1000) `  

nfs服务，当客户端以root身份去访问nfs共享时，默认是压榨(squash)为nfsnobody的身份去访问共享资源，也就是在服务器端会看到客户端上传的文件的所有者和所属组都是nfsnobody，权限降低了，但以普通用户身份去访问nfs共享时，普通用户在服务器端被映射成为id相同的用户，如果服务器端没有和客户端id相同的用户，则客户端上传的文件不显示属主和属组，只显示id号。
> all_squash设置会覆盖root的设置并和普通用户一起被映射为nfsnobody

# NFS工具
- rpcinfo   
rpcinfo -p hostname   
rpcinfo –s hostname 查看RPC注册程序   
- exportfs   
    - –v 查看本机所有NFS共享   
    - –r 重读配置文件，并共享目录   
    - –a 输出本机所有共享  
    - –au 停止本机所有共享  
- 客户端查看NFS服务器的共享目录  
**showmount -e hostname**  
- mount.nfs 挂载工具   
NFSv4支持通过挂载NFS服务器的共享“根”，从而浏览NFS服务器上的共享目录列表  
mount nfsserver:/ /mnt/nfs  

> NFS可以看到共享主机真实的磁盘路径
```
查看网络上的NFS服务器共享资源
[root@7 ~]# showmount -e 192.168.34.7
Export list for 192.168.34.7:
/data/nfs2 *
/data/nfs1 *

挂载网络NFS到本地
[root@7 ~]# mount 192.168.34.7:/data/nfs1 /mnt/nfsdir1
[root@7 ~]# mount 192.168.34.7:/data/nfs2 /mnt/nfsdir2

默认选项中，root是被限制权限并被设置为squash，会映射成NFS服务器的nfsnobody用户
[root@centos7 ~]#exportfs -v
/data/nfs1    	<world>(ro,sync,wdelay,hide,no_subtree_check,sec=sys,secure,root_squash,no_all_squash)
/data/nfs2    	<world>(rw,sync,wdelay,hide,no_subtree_check,sec=sys,secure,root_squash,no_all_squash)
客户端如果要在NFS文件目录有权限需要设置两点：
1、NFS配置要设置rw
vim /etc/exports
/data/nfs2 *(rw)
2、给nfsnobody用户设置对目录的读写权限
[root@centos7 ~]#setfacl -m u:nfsnobody:rwx /data/nfs2
```
生产环境中由于NFS一般使用场景是公司内网，所以可以将root取消压榨并限制某些主机访问  
`/data/nfs2 192.168.34.10(rw,no_root_squash) 192.168.34.0/24(ro)`
# 客户端NFS挂载
- 基于安全考虑，建议使用nosuid,nodev,noexec挂载选项    
- NFS相关的挂载选项：   
    - fg（默认）前台挂载，bg后台挂载    
    - hard（默认）持续请求，soft 非持续请求   
    - intr 和hard配合，请求可中断    
    - rsize和wsize 一次读和写数据最大字节数，rsize=32768    
    - _netdev 无网络不挂载    
- 示例：   
`mount -o rw,nosuid,fg,hard,intr 172.16.0.1:/nfsdir /mnt/nfs/`  
开机挂载:写入/etc/fstab文件   
`192.168.34.7:/data/nfs2  /mnt/nfsdir2  nfs  defaults 0 0`
# 自动挂载
可使用autofs按需要挂载NFS共享，在空闲时自动卸载   
由autofs包提供    
系统管理器指定由/etc/auto.master自动挂载器守护进程控制的挂载点   
自动挂载监视器访问这些目录并按要求挂载文件系统   
文件系统在失活的指定间隔**5分钟**后会自动卸载    
为所有导出到网络中的NFS启用特殊匹配 -host 至“browse”   
参看帮助：man 5 autofs   
支持含通配符的目录名   
 * server:/export/&  
 ## 相对路径法
 1. 主配置文件:  
 规定子配置文件的路径  
 /etc/auto.master  
 2. 修改子配置文件：  
 修改添加nfs资源：  
 vim /etc/auto.misc  
 `nfs   -fstype=nfs 192.168.34.7:/data/nfs2`   
 3. 直接访问即可挂载网络nfs资源   
 cd /misc/nfs
## 绝对路径法
1. 修改主配置文件，定义子配置文件   
 vim /etc/auto.master   
`/-      /etc/nfs.auto`  
2. 定义子配置文件  
vim /etc/nfs.auto   
`/data/nfs_auto   -fstype=nfs 192.168.34.7:/data/nfs2`   
3. 重启autofs服务，验证    
systemctl restart autofs   
ls /data/nfs_atuo   
## auto.net自动挂载
利用系统自带的规则文件，直接进入net文件夹并切换到网络的nfs服务器，即可自动挂载nfs资源
```
[root@7 mnt]# cd /net
[root@7 net]# cd 192.168.34.7
[root@7 192.168.34.7]# ls
data
```
# SAMBA服务
- SMB：Server Message Block服务器消息块，IBM发布，最早是DOS网络文
件共享协议    
- Cifs：common internet file system，微软基于SMB发布    
- SAMBA:1991年Andrew Tridgell,实现windows和UNIX相通    
- SAMBA的功能：   
• 共享文件和打印，实现在线编辑  
• 实现登录SAMBA用户的身份认证   
• 可以进行NetBIOS名称解析  
• 外围设备共享   
- 计算机网络管理模式：  
• 工作组WORKGROUP：计算机对等关系，帐号信息各自管理  
• 域DOMAIN:C/S结构，帐号信息集中管理，DC,AD  
# SAMBA介绍
- 相关包：   
Samba 提供smb服务   
Samba-client 客户端软件   
samba-common 通用软件   
cifs-utils smb客户端工具  
samba-winbind 和AD相关   
- 相关服务进程：   
smbd 提供smb（cifs）服务 **TCP:139,445**   
nmbd NetBIOS名称解析 **UDP:137,138**   
- 主配置文件：/etc/samba/smb.conf   
帮助参看：man smb.conf  
- 语法检查： testparm [-v] [/etc/samba/smb.conf]   
- 客户端工具：smbclient,mount.cifs   
# SAMBA服务器配置
- smb.conf继承了.ini文件的格式，用[ ] 分成不同的部分
- 全局设置：   
[global] 服务器通用或全局设置的部分  
- 特定共享设置：   
[homes] 用户的家目录共享   
[printers] 定义打印机资源和服务  
[sharename] 自定义的共享目录配置  
- 其中：#和;开头的语句为注释，大小写不敏感
- 宏定义：

参数|说明
---|---
%m| 客户端主机的NetBIOS名 
%M |客户端主机的FQDN
%H |当前用户家目录路径 
%U |当前用户用户名
%g| 当前用户所属组
%h| samba服务器的主机名
%L| samba服务器的NetBIOS名 
%I |客户端主机的IP
%T |当前日期和时间 
%S| 可登录的用户名
## SAMBA配置文件
选项|说明
---|---
workgroup| 指定工作组名称
server string |主机注释信息
netbios name |指定NetBIOS名
interfaces |指定服务侦听接口和IP
hosts allow |可用“,”，空格，或tab分隔，默认允许所有主机访问，也可在每个共享独立配置，如在[global]设置，将应用并覆盖所有共享设置
---|IPv4 network/prefix: 172.25.0.0/24 IPv4前缀: 172.25.0.
---|IPv4 network/netmask: 172.25.0.0/255.255.255.0
---|主机名: desktop.example.com，以example.com后缀的主机名:.example.com。示例：hosts allow = 172.25. hosts allow = 172.25. .example.com
hosts deny| 拒绝指定主机访问
**config file=/etc/samba/conf.d/%U** |用户独立的配置文件
**Log file=/var/log/samba/log.%m** |不同客户机采用不同日志
**log level = 2** |日志级别，默认为0，不记录日志
max log size=50 |日志文件达到50K，将轮循rotate,单位KB
Security三种认证方式：|share：匿名(CentOS7不再支持)
---|user：samba用户（采有linux用户，samba的独立口令）
---|domain：使用DC（DOMAIN CONTROLLER)认证
passdb backend = tdbsam |密码数据库格式
> 建议启用日志
## 管理SAMBA用户
实现samba用户：   
包： samba-common-tools   
工具：smbpasswd pdbedit   
**samba用户须是Linux用户，建议使用/sbin/nologin**   
`useradd -s /sbin/nologin smbuser1`   
`useradd -s /sbin/nologin smbuser2`
- 添加samba用户   
smbpasswd -a <user>  
pdbedit -a -u <user>  
```
把系统用户加入Samba用户组
smbpasswd -a smbuser1
smbpasswd -a smbuser2
[root@centos7 ~]# pdbedit -L
smbuser1:1004:
smbuser2:1005:
```
- 修改用户密码  
smbpasswd <user>  
- 删除用户和密码：  
smbpasswd –x <user>  
pdbedit –x –u <user>  
- 查看samba用户列表：  
/var/lib/samba/private/passdb.tdb  
pdbedit –L –v  
- 查看samba服务器状态  
smbstatus  
## 配置目录共享
每个共享目录应该有独立的[ ]部分   
[共享名称] 远程网络看到的共享名称    

参数|说明
---|---
comment| 注释信息
**path** |所共享的目录路径
public| 能否被guest访问的共享，默认no，和guest ok 类似
browsable |是否允许所有用户浏览此共享,默认为yes,no为隐藏
writable=yes |可以被所有用户读写，默认为no
**read only=no** |和writable=yes等价，如与以上设置冲突，放在后面的设置生效，默认只读
write list |三种形式：用户，@组名、+组名,用"，"分隔。如writable=no，列表中用户或组可读写，不在列表中用户只读
valid users |特定用户才能访问该共享，如为空，将允许所有用户，**用户名之间用空格分隔**

### 配置同一目录共享
```
服务器端操作
[root@centos7 etc]#mkdir /data/smb  #创建一个共享目录
[root@centos7 etc]#cd /data/smb/
[root@centos7 smb]#touch f1
[root@centos7 smb]#vim /etc/samba/smb.conf
[share]   #共享目录名
        comment = testshare       #注释信息
        path = /data/smb          #共享目录的路径
        create mask = 0644        #表示用户在客户端登录后上传文件的权限是0644
        writable = no             #不可以写
        write list = @smbusers    #只有在这个组里的用户才可以写
[root@centos7 share2]#testparm    #用来检查主配置文件的语法
[root@centos7 smb]#chomod 777 /data/smb/     #设置目录文件系统的权限
[root@centos7 smb]#useradd -s /sbib/nologin/ smb1
[root@centos7 smb]#useradd -s /sbib/nologin/ smb2
[root@centos7 smb]#useradd -s /sbib/nologin/ smb3
[root@centos7 smb]#smbpasswd -a smb1
[root@centos7 smb]#smbpasswd -a smb2
[root@centos7 smb]#smbpasswd -a smb3
[root@centos7 smb]#pdbedit -L   #创建三个samba用户
smb1:1004:
smb3:1006:
smb2:1005:
[root@centos7 smbshare]#groupadd smbusers    #创建组
[root@centos7 smbshare]#gpasswd -a smb1 smbusers  #将用户加入组
Adding user smb1 to group smbusers
[root@centos7 smbshare]#gpasswd -a smb2 smbusers
[root@centos7 smbshare]#groupmems -l -g smbusers  #显示组中用户
smb1  smb2 

客户端操作
[root@centos6 ~]#smbclient -L 192.168.34.8       #查看一下有哪些共享
[root@centos6 ~]#smbclient //192.168.34.8/share -U smb1%123   #登录到这个共享，可以上传文件，注意这里是UNC路径
[root@centos6 ~]#smbclient //192.168.34.8/share -U smb3%123   #smb3不可以上传，因为不在组里
```

### 实现客户端不同的samba用户登录时访问的共享目录不同，但共享目录的名字是相同的
```
创建好samba用户smb1和smb2
vim /etc/samba/smb.conf
[global]
config file = /etc/samba/conf.d/%U   #设置成每个用户有单独配置文件，%U表示文件名为samba用户名
mkdir /etc/samba/conf.d
cd /etc/samba/conf.d
vim smb1
[share]
path=/data/share1/
comment=testshare1
vim smb2
[share]
path=/data/share2/
comment=testshare2
mkdir /data/share1
mkdir /data/share2
touch /data/share1/f1
touch /data/share2/f2

[root@centos7 ~]#smbclient //192.168.34.8/share/ -U smb1%123
Domain=[WORKGROUP] OS=[Windows 6.1] Server=[Samba 4.8.3]
smb: \> ls
  .                                   D        0  Tue Oct 17 20:47:01 2017
  ..                                  D        0  Tue Oct 17 20:47:39 2017
  f1                                           0  Tue Oct 17 20:47:01 2017
smb: \> quit
在客户端访问共享发现每个smb1和smb2访问的目录不同
```
### 挂载CIFS文件系统
```
smbclient -L 192.168.34.8         #挂载之前先看一下有哪些共享
挂载的时候需要安装mount.cifs工具，来自cifs-utils包
mount -t cifs -o username=smb1,password=123 //192.168.34.8/share /mnt
开机自动挂载需要写到文件
vim /etc/fstab 
//192.168.34.8/share   /mnt   cifs   credentials=/etc/smb.txt 0 0  #利用文件来存用户名和密码
vim /etc/smb.txt     #创建一个这样的文件避免账号和密码泄露
username=smb1
password=123
chomd 600 /etc/smb.txt    #注意安全设置权限
mount -a 
[root@centos6 ~]#cd /mnt
[root@centos6 mnt]#ll
total 4
-rw-r--r-- 1 root root   0 Oct 17  2017 f2
-rwxr--r-- 1 1005 1005 512 Oct 17  2017 mbr

在服务器端
[root@centos7 share2]#ll /data/share2
total 4
-rw-r--r-- 1 root root   0 Oct 17 20:46 f2
-rwxr--r-- 1 smb2 smb2 512 Oct 17 20:49 mbr
可以看到samba服务和nfs服务一样，也是通过id号识别身份的
```

# 数据的实时同步
- 实现实时同步
    - 要利用监控服务（inotify），监控同步数据服务器目录中信息的变化
    - 发现目录中数据产生变化，就利用rsync服务推送到备份服务器上
- 实现实时同步的方法
    - inotify+rsync 方式实现数据同步
    - sersync ：金山公司周洋在 inotify 软件基础上进行开发的，功能更加强大
- inotify：
    - 异步的文件系统事件监控机制，利用事件驱动机制，而无须通过诸如cron等的轮询机制来获取事件，linux内核从2.6.13起支持inotify，通过inotify可以监控文件系统中添加、删除，修改、移动等各种事件
- 实现inotify软件：   
    - inotify-tools，sersync，lrsyncd  
# inotify和rsync实现实时同步
- inotify+rsync使用方式  
inotify 对同步数据目录信息的监控  
rsync 完成对数据的同步  
利用脚本进行结合  
# inotify和rsync实现实时同步
- 查看服务器内核是否支持inotify
    - Linux下支持inotify的内核最小为2.6.13
    - ll /proc/sys/fs/inotify #列出下面的文件，说明服务器内核支持inotify
    ```
    -rw-r--r-- 1 root root 0 Dec 7 10:10 max_queued_events
    -rw-r--r-- 1 root root 0 Dec 7 10:10 max_user_instances
    -rw-r--r-- 1 root root 0 Dec 6 05:54 max_user_watches
    ```
- inotify内核参数
    - 参数说明：参看man 7 inotify
    - max_queued_events：inotify事件队列最大长度，如值太小会出现 Event Queue Overflow 错误，默认值：16384
    - max_user_watches：可以监视的文件数量（单进程），默认值：8192
    - max_user_instances：每个用户创建inotify实例最大值，默认值：128
- inotify参考文档   
https://github.com/rvoicilas/inotify-tools/wiki  
- 安装：基于epel源   
yum install inotify-tools   
- Inotify-tools包主要文件：   
**inotifywait**： 在被监控的文件或目录上等待特定文件系统事件（open close delete等）发生，常用于实时同步的目录监控    
inotifywatch：收集被监控的文件系统使用的统计数据，指文件系统事件发生的次数统计     
## inotifywait命令常见选项
参数|选项
---|---
-m, --monitor| 始终保持事件监听
-d, --daemon| 以守护进程方式执行，和-m相似，配合-o使用
-r, --recursive|递归监控目录数据信息变化
-q, --quiet |输出少量事件信息
--timefmt <fmt>| 指定时间输出格式
--format <fmt> |指定的输出格式；即实际监控输出内容
--exclude <pattern>|指定排除文件或目录，使用扩展的正则表达式匹配的模式实现
--excludei <pattern> |和exclude相似，不区分大小写
-o, --outfile <file>|打印事件到文件中，相当于标准正确输出
-s, --syslogOutput |发送错误到syslog相当于标准错误输出
--**timefmt** <fmt>|时间格式，参考 man 3 strftime
---|%Y 年份信息，包含世纪信息
---|%y 年份信息，不包括世纪信息
---|%m 显示月份，范围 01-12
---|%d 每月的第几天，范围是 01-31
---|%H 小时信息，使用 24小时制，范围 00-23
---|%M 分钟，范围 00-59 
示例：|--timefmt "%Y-%m-%d %H:%M"
--**format** <fmt>| 格式定义
---|%T 输出时间格式中定义的时间格式信息，通过 --timefmt option 语法格式指定时间信息
---|%w 事件出现时，监控文件或目录的名称信息
---|%f 事件出现时，将显示监控目录下触发事件的文件或目录信息，否则为空
---|%e 显示发生的事件信息，不同的事件默认用逗号分隔
---|%Xe显示发生的事件信息，不同的事件指定用X进行分隔
示例：|--format "%T %w%f event: %;e"、--format '%T %w %f'
**-e** |指定监听指定的事件，如果省略，表示所有事件都进行监听
---|create 文件或目录创建
---|delete 文件或目录被删除
---|modify 文件或目录内容被写入
---|attrib 文件或目录属性改变
---|close_write 文件或目录关闭，在写入模式打开之后关闭的
---|close_nowrite 文件或目录关闭，在只读模式打开之后关闭的
---|close 文件或目录关闭，不管读或是写模式
---|open 文件或目录被打开
---|moved_to 文件或目录被移动到监控的目录中
---|moved_from 文件或目录从监控的目录中被移动
---|move 文件或目录不管移动到或是移出监控目录都触发事件
---|access 文件或目录内容被读取
---|delete_self 文件或目录被删除，目录本身被删除
---|unmount 取消挂载
示例：| -e create,delete,moved_to,close_write
## inotify常用示例：
- 监控一次性事件   
`inotifywait /data`
- 持续监控   
`inotifywait -mrq /data`
- 持续后台监控，并记录日志   
`inotifywait -o /root/inotify.log -drq /data --timefmt "%Y-%m-%d
%H:%M" --format "%T %w%f event: %e"`
- 持续后台监控特定事件   
`inotifywait -mrq /data --timefmt "%F %H:%M" --format "%T %w%f event: %;e" -e create,delete,moved_to,close_write,attrib`
## rsync服务器端配置
1. 修改配置文件
```
配置 rsync 服务器端的配置文件
vim /etc/rsyncd.conf
uid = root          #运行者用户身份
gid = root          #运行者组身份
use chroot = no     #
max connections = 0 #最大连接数不限制
ignore errors       #忽略错误
exclude = lost+found/ #排除文件
log file = /var/log/rsyncd.log #日志文件路径
pid file = /var/run/rsyncd.pid #pid文件路径
lock file = /var/run/rsyncd.lock #lock文件路径
reverse lookup = no   #禁止反向域名解析
hosts allow = 192.168.34.0/24  #允许网段访问

[backup]            #同步备份的文件夹标识
path = /data/files     #同步文件夹的路径
comment = backup    #描述信息
read only = no      #是否只读
auth users = rsyncuser #运行同步的虚拟账户
secrets file = /etc/rsync.pass #虚拟同步账户的密码文件
```
2. 服务器端生成验证文件   
```
echo "rsyncuser:magedu" > /etc/rsync.pass
chmod 600 /etc/rsync.pass
```
3. 服务器端准备目录    
`mkdir /data/files`
4. 服务器端启动rsync服务    
`rsync --daemon` #可加入/etc/rc.d/rc.local实现开机启动
5. 客户端配置密码文件
```
echo "magedu" > /etc/rsync.pass
chmod 600 /etc/rsync.pass
```
6. 客户端测试同步数据
`rsync -avz --password-file=/etc/rsync.pass /data/backup/ rsyncuser@192.168.34.8::backup`
## 创建inotify_rsync.sh脚本
```
#!/bin/bash
SRC='/data/backup'
DEST='rsyncuser@192.168.34.8::backup'
inotifywait -mrq --timefmt '%Y-%m-%d %H:%M' --format '%T %w %f' -e attrib,create,delete,moved_to,close_write ${SRC} |while read DATE TIME DIR
FILE;do
FILEPATH=${DIR}${FILE}
rsync -az --delete --password-file=/etc/rsync.pass $SRC $DEST && echo "At ${TIME} on ${DATE}, file $FILEPATH was backuped up via rsync" >> /var/log/changelist.log
done
```
