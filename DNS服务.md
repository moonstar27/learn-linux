# DNS服务
DNS:Domain Name Service 应用层协议   
C/S,53/udp, 53/tcp   

BIND：Bekerley Internat Name Domain  
 ISC （www.isc.org）  
 
本地名称解析配置文件：hosts   
/etc/hosts   
%WINDIR%/system32/drivers/etc/hosts   
122.10.117.2 www.magedu.com   
93.46.8.89 www.google.com   
FQDN=主机名或别名+域名（用点分隔成多个部分）分层化   

# DNS域名
- 根域
- 一级域名：Top Level Domain: tld com, edu, mil, gov, net, org, int,arpa  
三类：组织域、国家域(.cn, .ca, .hk,.tw)、反向域
- 二级域名
- 三级域名  
最多127级域名
- ICANN（The Internet Corporation for Assigned Names and Numbers）
互联网名称与数字地址分配机构，负责在全球范围内对互联网通用顶级域名（gTLD）以及国家和地区顶级域名（ccTLD）系统的管理、以及根服务器系统的管理

# DNS解析
- DNS查询类型：  
**递归查询**  #有结果返回的查询过程   
**迭代查询**  #不一定有结果的查询过程   
- 名称服务器：  
域内负责解析本域内的名称的主机  
根服务器：**13组服务器**  
- 解析类型：  
FQDN --> IP 正向  
IP --> FQDN 反向  
> 注意：正反向解析是两个不同的名称空间，是两棵不同的解析树  
dig、nslookup、host测试DNS解析

# DNS服务器类型  
- DNS服务器的类型：   
主DNS服务器  
从DNS服务器  
缓存DNS服务器（转发器）   
- 主DNS服务器：管理和维护所负责解析的域内解析库的服务器
- 从DNS服务器：从主服务器或从服务器“复制”（区域传输）解析库副本   
序列号：解析库版本号，主服务器解析库变化时，其序列递增  
刷新时间间隔：从服务器从主服务器请求同步解析的时间间隔  
重试时间间隔：从服务器请求同步失败时，再次尝试时间间隔  
过期时长：从服务器联系不到主服务器时，多久后停止服务   
- “通知”机制：主服务器解析库发生变化时，会主动通知从服务器

# 区域传输
- 区域传输：
完全传输：传送整个解析库  
增量传输：传递解析库变化的那部分内容   
- Domain: Fully Qualified Domain Name  
正向：FQDN --> IP  
反向: IP --> FQDN   
- 负责本地域名的正向和反向解析库  
正向区域  
反向区域   

# DNS解析
- 一次完整的查询请求经过的流程：
Client -->hosts文件 -->DNS Service Local Cache --> DNS Server(recursion) --> Server Cache --> iteration(迭代) --> 根--> 顶级域名DNS-->   
二级域名DNS…
- 解析答案：   
肯定答案：   
否定答案：请求的条目不存在等原因导致无法返回结果   
权威答案：   
非权威答案：   

# 资源记录
- 区域解析库：由众多RR组成：  
资源记录：Resource Record, RR  
记录类型：A, AAAA, PTR, SOA, NS, CNAME, MX

选项 | 说明
---|---
SOA：Start Of Authority | 起始授权记录；一个区域解析库有且仅能有一个SOA记录，必须位于解析库的第一条记录
A | internet Address，作用，FQDN --> IP
AAAA| FQDN --> IPv6
PTR|PoinTeR，IP --> FQDN
NS|Name Server，专用于标明当前区域的DNS服务器
CNAME| Canonical Name，别名记录
MX|Mail eXcha 邮件交换器
TXT|对域名进行标识和说明的一种方式，一般做验证记录时会使用此项，如：SPF（反垃圾邮件）记录，https验证等

## 资源记录定义的格式：
语法：name [TTL] IN rr_type（资源类型） value
注意：
1. TTL可从全局继承
1. @可用于引用当前区域的名字
1. 同一个名字可以通过多条记录定义多个不同的值；此时DNS服务器会以轮询
方式响应
1. 同一个值也可能有多个不同的定义名字；通过多个不同的名字指向同一个值进行定义；此仅表示通过多个不同的名字可以找到同一个主机

## SOA记录
- name: 当前区域的名字，例如“magedu.com.”
- value: 有多部分组成
1. 当前区域的主DNS服务器的FQDN，也可以使用当前区域的名字；
2. 当前区域管理员的邮箱地址；但地址中不能使用@符号，一般用.替换
例如：admin.magedu.com
3. 主从服务区域传输相关定义以及否定的答案的统一的TTL
```
例如：
magedu.com. 86400 IN SOA dns（#本域的主DNS名）
nsadmin.magedu.com.(#管理员邮箱) (
2015042201 ;序列号 #主从同步靠序列号，每次修改主配置后，需要手动修改此值（最长10位）
2H ;刷新时间 #同步时间，从服务器拉取记录
10M ;重试时间 #拉取失败后再次尝试时间
1W ;过期时间 #拉取失败后超过此时间，从服务器不可使用
1D ;缓存否定答案的TTL值 #查询不到域名时会提示，会从缓存中读取
)
```
## NS记录
- name: 当前DNS区域的名字
- value: 当前区域的某DNS服务器的名字，例如ns.magedu.com.  
> 注意：一个区域可以有多个NS记录  

例如：    
magedu.com. IN NS dns1.magedu.com.  
magedu.com. IN NS dns2.magedu.com.

> 注意：  
(1) 相邻的两个资源记录的name相同时，后续的可省略  
(2) 对NS记录而言，任何一个ns记录后面的服务器名字，都应该在后续有一个**A记录**

## MX记录
- name: 当前DNS区域的名字
- value: 当前区域的某邮件服务器(smtp服务器)的主机名
- 一个区域内，MX记录可有多个；但每个记录的value之前应该有一个数字(0-99)，表示此服务器的优先级；**数字越小优先级越高** 

例如：  
magedu.com. IN MX 10 mx1.magedu.com.  
            IN MX 20 mx2.magedu.com.

> 注意：对MX记录而言，任何一个MX记录后面的服务器名字，都应该在后续有一个A记录

## A记录
- name: 某主机的FQDN，例如www.magedu.com.
- value: 主机名对应主机的IP地址
```
例如：
www.magedu.com. IN A 1.1.1.1 #同一域名可以有多个A记录
www.magedu.com. IN A 2.2.2.2
mx1.magedu.com. IN A 3.3.3.3
mx2.magedu.com. IN A 4.4.4.4
$GENERATE 1-254 HOST$ A 1.2.3.$ #多地址解析，$替换前面1-254的数字
*.magedu.com. IN A 5.5.5.5 #泛域名解析
magedu.com. IN A 6.6.6.6
```
> 避免用户写错名称时给错误答案，可通过泛域名解析进行解析至某特定地址

## AAAA和PTR
- AAAA:  
name: FQDN  
value: IPv6  
- PTR:  
name: IP，有特定格式，把IP地址反过来写，1.2.3.4，要写作4.3.2.1；而有特定后缀：in-addr.arpa.，所以完整写法为：4.3.2.1.in-addr.arpa.   
value: FQDN   
```
例如：
4.3.2.1.in-addr.arpa. IN PTR www.magedu.com.
如1.2.3为网络地址，可简写成：
4 IN PTR www.magedu.com.
```
> 注意：网络地址及后缀可省略；主机地址依然需要反着写

## CNAME别名
- name: 别名的FQDN
- value: 真正名字的FQDN  
例如：  
 www.magedu.com. IN CNAME websrv.magedu.com.

# 子域
- 子域授权：每个域的名称服务器，都是通过其上级名称服务器在解析库进行授权
- 类似根域授权tld： 
```
.com.    IN NS  ns1.com.
.com.    IN NS  ns2.com.
ns1.com. IN A   2.2.2.1
ns2.com. IN A   2.2.2.2
```
```
magedu.com. 在.com的名称服务器上，解析库中添加资源记录
magedu.com.     IN NS ns1.magedu.com.
magedu.com.     IN NS ns2.magedu.com.
magedu.com.     IN NS ns3.magedu.com.
ns1.magedu.com. IN A  3.3.3.1
ns2.magedu.com. IN A  3.3.3.2
ns3.magedu.com. IN A  3.3.3.3
```
- glue record：粘合记录，父域授权子域的记录

# 互联网域名

# BIND服务

## 安装
BIND的安装配置：   
dns服务程序包:bind，unbound   
程序名：named，unbound   
程序包：yum list all bind*   
bind：服务器   
bind-libs：相关库    
bind-utils:客户端   
bind-chroot: /var/named/chroot/ #配置文件搬家软件，安全性高

## 服务相关
- 服务脚本和名称：/etc/rc.d/init.d/named /usr/lib/systemd/system/named.service
- 主配置文件：/etc/named.conf, /etc/named.rfc1912.zones, /etc/rndc.key
- 解析库文件：/var/named/ZONE_NAME.ZONE
> 注意：  
(1) 一台物理服务器可同时为多个区域提供解析  
(2) 必须要有根区域文件；named.ca  
(3) 应该有两个（如果包括ipv6的，应该更多）实现localhost和本地回环地址的解析库  
- rndc：remote name domain controller  
默认与bind安装在同一主机，且只能通过127.0.0.1连接named进程提供辅助性的管理功能；953/tcp

## 配置文件
- 主配置文件：  
全局配置：options {};  
日志子系统配置：logging {};  
区域定义：本机能够为哪些zone进行解析，就要定义哪些zone  
zone "ZONE_NAME" IN {};  

> 注意：任何服务程序如果期望其能够通过网络被其它主机访问，至少应该监听在一个能与外部主机通信的IP地址上  
options中写上localhost默认监听本机所有地址

- 缓存名称服务器的配置：  
监听外部地址即可  
dnssec: 建议关闭dnssec，设为no  

# rndc命令
rndc --> rndc (953/tcp)  
rndc COMMAND

选项 | 说明
---|---
reload | 重载主配置文件和区域解析库文件
reload zonename | 重载区域解析库文件
retransfer zonename | 手动启动区域传送，而不管序列号是否增加
notify zonename| 重新对区域传送发通知
reconfig | 重载主配置文件
querylog | 开启或关闭查询日志文件/var/log/message
trace | 递增debug一个级别
trace LEVEL | 指定使用的级别
notrace |将调试级别设置为 0
flush | 清空DNS服务器的所有缓存记录

## 配置主DNS服务器
- 主DNS名称服务器：  
1. 在主配置文件中定义区域  
zone "ZONE_NAME" IN {  
type {master|slave|hint|forward};  
file "ZONE_NAME.zone";  
};  
1. 定义区域解析库文件  
出现的内容   
宏定义  
资源记录  
- 主配置文件语法检查：  
**named-checkconf**  
- 解析库文件语法检查：  
named-checkzone "magedu.com"   /var/named/magedu.com.zone  
- 重新载入配置文件并重启服务  
**rndc** status|reload ;service named reload  
```
1、安装bind包、关闭防火墙和selinux
 yum install bind
systemctl start named 
systemctl enable named
2、修改配置文件
 vim /etc/named.conf
 listen-on port 53 { any; };   ---any指监听本机的所有ip，也可以注释掉，默认是监控所有ip
 allow-query     { any; };   ---允许所有主机查询本机的dns，也可以额指定某个ip，也可以注释掉，默认是允许任何主机访问
 recursion yes;   ---表示允许递归迭代，改为no就是不到根上去查找了
 dnssec-enable no;
 dnssec-validation no;   ----这两行的yes改为no

这里需要注意的是：要先开启dns服务，再去修改配置文件，否则服务开启不了。

3、修改区域解析库的配置文件
vim /etc/named.rfc1912.zones
zone "nie.com" IN {
        type master;
        file "nie.com.zone";  ---区域解析库文件的名字
};

4、创建区域解析库文件
cd /var/named
cp -a named.localhost nie.com.zone  ---
一定要加上-a选项，不然复制过来的文件对于named用户没有读权限，解析的时候named用户要读这个文件，一定要注意
vim /var/named/nie.com.zone   ---这个文件名要和前面的一样
$TTL 1D
@       IN SOA  dns1 admin.nie.com. (
                                0       ; serial 
                                1D      ; refresh
                                1H      ; retry
                                2H      ; expire
                                3H )    ; minimum
@       NS      dns1
dns1    A       192.168.34.10
websrv  A       192.168.34.76
www     CNAME   websrv
@       MX   10 mailsrv
mailsrv A       6.6.6.6

5、检查语法、重新加载服务
named-checkconf   --检查/etc/named.conf和/etc/named.rfc1912.zones文件的语法
named-checkzone magedu.com /var/named/magedu.com.zone  ---检查区域数据库文件的语法
rndc reload    ---重新加载服务，如果不行就重启服务

6、测试
dig www.nie.com   
dig -t ns nie.com @192.168.34.10   -t可以指定解析哪条记录，这里解析的是ns记录，也就是解析当前域的dns服务器的名字是什么
dig -t MX nie.com    --解析nie.com域的邮件服务器的名字
dig +trace www.nie.com   --跟踪解析过程
```
## 主区域示例
```
$TTL 86400
$ORIGIN magedu.com.
@ IN SOA ns1.magedu.com. admin.magedu.com (
2015042201
1H
5M
7D
1D )
IN NS ns1  #两台dns服务器
IN NS ns2
IN MX 10 mx1
IN MX 20 mx2
ns1 IN A 172.16.100.11  #指明DNS服务器的地址
ns2 IN A 172.16.100.12
mx1 IN A 172.16.100.13
mx2 IN A 172.16.100.14
websrv IN A 172.16.100.11
websrv IN A 172.16.100.12
www IN CNAME websrv  #使用别名
```
## 测试命令
### dig
dig [-t type] name [@SERVER] [query options]  
dig只用于测试dns系统，不会查询hosts文件进行解析
- 查询选项：  
+[no]trace：跟踪解析过程 : dig +trace magedu.com  
+[no]recurse：进行递归解析  
- 测试反向解析：  
dig -x IP = dig –t ptr reverseip.in-addr.arpa  
- 模拟区域传送：  
dig -t axfr ZONE_NAME @SERVER  
dig -t axfr magedu.com @10.10.10.11  
dig –t axfr 100.1.10.in-addr.arpa @172.16.1.1  
dig -t NS . @114.114.114.114  
dig -t NS . @a.root-servers.net  
> 返回信息最详细，便于排错  

### host
host [-t type] name [SERVER]  
host –t NS magedu.com 172.16.0.1  
host –t soa magedu.com  
host –t mx magedu.com  
host –t axfr magedu.com  
host 1.2.3.4  

### nslookup命令
nslookup [-option] [name | -] [server]  
• 交互式模式：  
nslookup>  
server IP: 指明使用哪个DNS server进行查询  
set q=RR_TYPE: 指明查询的资源记录类型  
NAME: 要查询的名称  

## 反向区域
区域名称：网络地址反写.in-addr.arpa.  
172.16.100. --> 100.16.172.in-addr.arpa.  
1. 定义区域  
zone "ZONE_NAME" IN {  
type {master|slave|forward}；  
file "网络地址.zone"  
};  
1. 定义区域解析库文件  
注意：不需要MX,以PTR记录为主  
```
$TTL 86400  #等同于1D
$ORIGIN 100.16.172.in-addr.arpa. #解析网段，倒写IP段
@ IN SOA ns1.magedu.com. admin.magedu.com. (
                2015042201
                1H
                5M
                7D
                1D )
IN NS ns1.magedu.com.
IN NS ns2.magedu.com.
11 IN PTR ns1.magedu.com.  #只写主机ID值 #11.100.16.172.in-addr.arpa. 完整写法
11 IN PTR www.magedu.com.
12 IN PTR mx1.magedu.com.
12 IN PTR www.magedu.com.
13 IN PTR mx2.magedu.com.
```
```
1、vim /etc/named.rfc1912.zones ---修改区域解析库的配置文件
zone "34.168.192.in-addr.arpa" IN { #34.168.192.in-addr.arpa是反向解析的域名，解析192.168.34这个网段，要反着写。
        type master;
        file "192.168.34.zone";  # 指明反向解析库的名字
};

2、vim /var/named/192.168.34.zone #注意配置文件的用户组named
$TTL 1D
@ IN SOA dns1 admin.nie.com. (0 1D 1H 30M 3H )

@ IN NS dns1
dns1 A 192.168.34.10
10 IN PTR  dns1.nie.com.  #只需补全最后主机地址，不能像正向解析库一样省略后面的域名，写的时候不要忘记加上后面的点
188 IN PTR www.nie.com.

3、重新加载后测试
rndc reload
dig -x 192.168.34.10 
dig -x 192.168.34.188 
```
## 允许动态更新
使用不多仅做了解
```
指定的zone语句块中：Allow-update {any;}; #最好指定到单台主机IP，安全性更好
chmod 770 /var/named
setsebool -P named_write_master_zones on #设置selinux
nsupdate #使用nsupdate更新
• >server 127.0.0.1
• >zone magedu.com
• >update add ftp.magedu.com 88888 IN A 8.8.8.8
• >send
• >update delete www.magedu.com A
• >send

测试：dig ftp.magedu.com @127.0.0.1
ll /var/named/magedu.com.zone.jnl
cat /var/named/magedu.com.zone
```
## 实现平衡负载和泛域名解析
```
vim nie.com.zone 
$TTL 1D
@       IN SOA  dns1 admin.nie.com. (
                                        0       ; serial
                                        1H      ; refresh
                                        1H      ; retry
                                        1W      ; expire
                                        3H )    ; minimum
@       NS      dns1
dns1    A       192.168.34.10
www     CNAME   websrv
websrv  A       192.168.34.7   ---一个域名指向两个ip地址，有两个web服务器，这样用户在访问www.nie.com时会轮流给用户解析这两个ip地址，轮流访问这两个主机，达到负载平衡。
websrv  A       192.168.34.6
*       A       192.168.34.7     ---泛域名解析，只要输入的是以nie.com结尾的域名，都解析成6.6.6.6的ip地址
@       A   192.168.34.7    ---用户不输入www，只写nie.com 也会解析

测试：dig www.nie.com   ---负载平衡，解析两个ip地址
dig wwww.nie.com    ---泛域名解析
dig nie.com @127.0.0.1    ---用户只输入nie.com也可以解析
```

# 从服务器
实现主从复制**安全性**，定义好从服务器的IP地址 
vim /etc/named.conf
主服务器  
allow-transfer {从服务器IP;};  
从服务器   
allow-transfer {none;};
```
1、更改主dns服务器的区域解析库文件
vim /var/named/nie.com.zone
$TTL 1D
@ IN SOA dns1 admin.nie.com. (20181130 10M 1H 30M 3H )

@   IN NS dns1
@   IN NS dns2
dns1 IN A 192.168.34.10
dns2 IN A 192.168.34.8
www IN A 192.168.2.188
www IN A 192.168.2.58
* A 192.168.2.188
@ A 192.168.2.188
@ MX 10 mailserver1
@ MX 20 mailserver2
mailserver1 A 192.168.34.50
mailserver2 A 192.168.34.18


2、更改从dns服务器区域解析库的配置文件
vim /etc/named.rfc1912.zones #192.168.34.7
zone "nie.com" IN { #必须与主服务器域名相同
    type slave;
    masters {192.168.34.10;};
    file "slaves/nie.com.zone"; #可以与主服务名称不一致
};

3测试
rndc reload
dig www.nie.com 
```
实现主从复制**安全性**，定义好从服务器的IP地址 
vim /etc/named.conf
主服务器  
allow-transfer {从服务器IP;};  
从服务器   
allow-transfer {none;};
```
dig -t axfr nie.com #此命令可以抓取dns服务器的区域解析库文件中的所有信息
如何避免类似情况发生应做如下配置

1、更改主dns服务器的配置文件，增加一行内容
vim /etc/named.conf
allow-transfer { 192.168.34.8;};   #指明允许哪个主机可以从我这里复制区域解析库文件
service named restart   #重启服务才能生效

2、更改从dns服务器的配置文件，增加一行
vim /etc/named.conf
  allow-transfer { none; }; #设置为任何人都不允许复制
rndc reload
3、测试
dig -t axfr nie.com @192.168.34.10
dig -t axfr nie.com @192.168.34.8
发现从这两个服务器都抓取不了了，更改一下主dns服务器的区域解析库文件中的版本号，重启一下服务，发现仍然可以复制给从dns服务器。
```

> TCP53主从复制  
UDP53负责查询

# 子域委派
方式一：主域和子域在相同主机 
```
1、只需修改主DNS服务器的区域配置文件
vim vim /etc/named.rfc1912.zones
添加一条主域信息
zone "beijing.nie.com" IN {
        type master;
        file "beijing.nie.com.zone";
};      

2、修改新的配置文件将DNS和页面解析写好
cp -a /var/named/nie.com.zone /var/named/beijing.nie.com.zone
vim /var/named/beijing.nie.com.zone
$TTL 1D
@ IN SOA dns1 admin.nie.com. (20181130 10M 1H 30M 3H )

@   IN NS dns1
dns1 IN A 192.168.34.10
www IN A 192.168.2.188
www IN A 192.168.2.58

3、测试
rndc reload

dig www.nie.com
dig www.beijing.nie.com
```
方式二：主域和子域在不相同主机
```
1、只需修改主DNS服务器区域配置文件
vim /var/named/nie.com.zone
$TTL 1D
@ IN SOA dns1 admin.nie.com. (20181131 10M 1H 30M 3H )

@   IN NS dns1
@   IN NS dns2
shanghai IN NS dns3  #添加不同子域的DNS记录
dns1 IN A 192.168.34.10
dns2 IN A 192.168.34.8
dns3 IN A 192.168.34.50  #重要是要写明子域的DNS服务器IP
www IN A 192.168.2.188
www IN A 192.168.2.58

2、在子域的主机上配置bind服务
修改主配置文件
vim /etc/named.conf
options {
//      listen-on port 53 { 127.0.0.1; }; #注销即可监听所有IP
        listen-on-v6 port 53 { ::1; };
        directory       "/var/named";
        dump-file       "/var/named/data/cache_dump.db";
        statistics-file "/var/named/data/named_stats.txt";
        memstatistics-file "/var/named/data/named_mem_stats.txt";
//      allow-query     { localhost; };  #注销即可查询所有IP
        recursion yes;
        dnssec-enable no;  #关闭此选项，避免错误
        dnssec-validation no;

在区域文件中添加子域的信息
vim /etc/named.rfc1912.zones
zone "shanghai.nie.com" IN {
        type master;
        file "shanghai.nie.com.zone";
};

scp 192.168.34.10:/var/named/nie.com.zone /var/named/shanghai.nie.com.zone
chgrp named shanghai.nie.com.zone #修改文件所属组为named
chmod 640 shanghai.nie.com.zone  #修改文件的权限
vim /var/named/shanghai.nie.com.zone
$TTL 1D
@ IN SOA dns1 admin.nie.com. (1 10M 1H 30M 3H )

@   IN NS dns1
dns1 IN A 192.168.34.50  #指向本地DNS
www IN A 192.168.3.134
www IN A 192.168.3.67
service named start

3、测试
dig www.shanghai.nie.com
```

# 转发服务器
适用于集团内部专线连接，通过统一的DNS出口查询，可以将各地的本地DNS指向总部的DNS服务器

forward only 只转发一次，下一服务器没有即报错误  
forward first  转发下一个服务器，如果找不到，发起请求的主机会去互联网查询  
forwarders {下一转发的IP;};

注意：被转发的服务器需要能够为请求者做递归，否则转发请求不予进行
1. 全局转发: 对非本机所负责解析区域的请求，全转发给指定的服务器  
Options {  
forward first|only;  
forwarders { ip;};  
};  
```
1、在另外主机上创建一个li.com域的dns服务器
修改区域文件并创建相应的区域文件

2、在主DNS上操作如下
vim /etc/named.conf     ---在配置文件中增加如下两条内容
    forward only;    ---表示转发后没有找到对应域的权威dns服务器，就不去根上寻找，直接回复客户端否定结果
    forwarders {192.168.34.8;};   ----表示转发给哪个dns服务器
named-checkconf 
重启服务
systemctl restart named

3、测试
dig www.li.com 

```
1. 特定区域转发：仅转发对特定的区域的请求，比全局转发优先级高  
zone "ZONE_NAME" IN {  
type forward;  
forward first|only;  
forwarders { ip;};  
};  
```
1、在两个主机上分别创建ss.com域的dns和li.com域的dns服务器

2、在主DNS上执行如下操作
vim /etc/named.rfc1912.zones
zone "li.com" IN {
    type forward;
    forward first;
    forwarders{192.168.34.8;};  #访问li.com域就转发给192.168.34.8
};
zone "ss.com" IN {
    type forward;
    forward first;
    forwarders{192.168.34.50;}; #访问ss.com域就转发给192.168.34.50
};
systemctl restart named

3、测试
dig www.ss.com 
dig www.li.com 
```
> 注意：关闭dnssec功能  
dnssec-enable no;  
dnssec-validation no;  

## bind中ACL
bind中基础的安全相关的配置：   
acl: 把一个或多个地址归并为一个集合，并通过一个统一的名称调用  
格式：  
acl acl_name {  
ip;  
net/prelen;  
……  
};  
```
将相同属性（按地区分类）的IP短写成一个名词来调用
示例：
acl mynet {
172.16.0.0/16;
10.10.10.10;
};
```
### bind有四个内置的acl:
none 没有一个主机  
any 任意主机  
localhost 本机  
localnet 本机的IP同掩码运算后得到的网络地址  
> 注意：只能先定义后使用；因此一般定义在配置文件中，处于options的前面

# 智能DNS bind view
CDN: Content Delivery Network内容分发网络
view:视图：实现智能DNS：  
一个bind服务器可定义多个view，每个view中可定义一个或多个zone  
每个view用来匹配一组客户端  
多个view内可能需要对同一个区域进行解析，但使用不同的区域解析库文件   
> 注意：  
1、一旦启用了view，所有的zone都只能定义在view中  
2、仅在允许递归请求的客户端所在view中定义根区域  
3、客户端请求到达时，是自上而下检查每个view所服务的客户端列表  

格式：
```
view VIEW_NAME {
    match-clients { testacl; };
    zone “magedu.com” {
        type master;
        file “magedu.com.zone”; };
    include “/etc/named.rfc1912.zones”;
};
```
```
智能DNS实验

1、修改主DNS服务器配置文件
vim /etc/named.conf
#在options选项前写好ACL，规划好各地的IP段所能访问的服务器
acl bjnet {
        192.168.34.0/24;
};
acl shnet {
        192.168.2.0/24;
};
acl sznet {
        any;
};

#在配置文件中写好智能DNS的view
view view_bj {
        match-clients {bjnet;}; #匹配的acl名词要与文件开始定义的匹配
        include "/etc/named.rfc1912.zones"; #引用系统文件来定义各地访问的服务器地址
};

view view_sh {
        match-clients {shnet;};
        include "/etc/named.rfc1912.zones.sh";
};

view view_sz {
        match-clients {sznet;};
        include "/etc/named.rfc1912.zones.sz";
};

#只要启用view，配置所有的zone信息必须写到view的{}中，所以将配置文件中的
zone "." IN {
        type hint;
        file "named.ca";
};
拷贝到/etc/named.rfc1912.zones各文件中

2、准备好各地区的区域库文件
#修改各地区中区域文件的指向
bj：
vim /etc/named.rfc1912.zones
zone "nie.com" IN {
        type master;
        file "nie.com.zone.bj";
};
vim /var/named/nie.com.zone.bj
$TTL 1D
@ IN SOA dns1 admin.nie.com. (20181130 10M 1H 30M 3H )

@   IN NS dns1
dns1 IN A 192.168.34.10
www IN A 192.168.66.43   #定义好本地区所提供的服务器IP
www IN A 192.168.66.45

sh：
vim /var/named/nie.com.zone.sh
zone "nie.com" IN {
        type master;
        file "nie.com.zone.sh";
};
vim /var/named/nie.com.zone.sh
$TTL 1D
@ IN SOA dns1 admin.nie.com. (20181130 10M 1H 30M 3H )

@   IN NS dns1
dns1 IN A 192.168.34.10
www IN A 192.168.77.38  #定义好本地区所提供的服务器IP
www IN A 192.168.77.35

sz:
vim /var/named/nie.com.zone.sz
zone "nie.com" IN {
        type master;
        file "nie.com.zone.sz";
};
vim /var/named/nie.com.zone.sz
$TTL 1D
@ IN SOA dns1 admin.nie.com. (20181130 10M 1H 30M 3H )

@   IN NS dns1
dns1 IN A 192.168.34.10
www IN A 192.168.88.67  #定义好本地区所提供的服务器IP
www IN A 192.168.88.63

3、测试
rndc reload

dig www.nie.com @192.168.34.10
dig www.nie.com @192.168.2.188
dig www.nie.com @127.0.0.1
```


# DNS排错
#dig A example.com  
; <<>> DiG 9.9.4-RedHat-9.9.4-14.el7 <<>> A example.com   
;; global options: +cmd  
;; Got answer:  
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 30523  

1. SERVFAIL:The nameserver encountered a problem while processing the query.  
可使用dig +trace排错，可能是网络和防火墙导致  
2. NXDOMAIN：The queried name does not exist in the zone.  
可能是CNAME对应的A记录不存在导致  
3. REFUSED：The nameserver refused the client's DNS request due to policy
restrictions.  
可能是DNS策略导致

NOERROR不代表没有问题，也可以是过时的记录  
查看是否为权威记录，**flags:aa标记判断**  
被删除的记录仍能返回结果，可能是因为*记录存在  
如：*.example.com． IN A 172.25.254.254   

**注意“.”的使用**  

避免CNAME指向CNAME记录，可能产生回环    
test.example.com. IN CNAME lab.example.com.  
lab.example.com. IN CNAME test.example.com.  

正确配置PTR记录，许多服务依赖PTR，如sshd,MTA  
正确配置轮询round-robin记录  


