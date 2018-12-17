# TCP/IP协议
![TCP](http://images.cnitblog.com/blog/313639/201312/03183510-aea7f7f34a2c495283e241f2c9a56dc7.jpg)

# Socket套接字
- Socket:套接字，进程间通信IPC的一种实现，允许位于不同主机（或同一主机）上不同进程之间进行通信和数据交换。
- Socket API：封装了内核中所提供的socket通信相关的系统调用  
- Socket Domain：根据其所使用的地址   
AF_INET：Address Family，IPv4   
AF_INET6：IPv6   
AF_UNIX：同一主机上不同进程之间通信时使用   
- Socket Type：根据使用的传输层协议   
SOCK_STREAM：流，tcp套接字，可靠地传递、面向连接   
SOCK_DGRAM：数据报，udp套接字，不可靠地传递、无连接   
SOCK_RAW: 裸套接字,无须tcp或udp,APP直接通过IP包通信   
## 客户/服务器程序的套接字函数
![SOCKET](https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544544880279&di=a51b47235f14b46815f56773315d64e7&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D1910668465%2C1238969875%26fm%3D214%26gp%3D0.jpg)
## 套接字相关的系统调用
socket(): 创建一个套接字   
bind()： 绑定IP和端口  
listen()： 监听  
accept()： 接收请求  
connect()： 请求连接建立  
write()： 发送  
read()： 接收 
close(): 关闭连接  
> fd 文件描述符 创建socket文件，交换数据
# HTTP服务通信过程
![HTTP](http://images2015.cnblogs.com/blog/789055/201705/789055-20170504102138226-300361617.jpg)
## HTTP相关术语
http: Hyper Text Transfer Protocol, 80/tcp   #超文本协议   
html: Hyper Text Markup Language  #超文本标记语言，编程语言    
CSS: Cascading Style Sheet #层叠样式表   
js: javascript  #直译式脚本语言   
MIME： Multipurpose Internet Mail Extensions  #多用途互联网邮件扩展 centos6:/etc/mime.types   
格式：    
major/minor   
text/plain   
text/html   
text/css   
image/jpeg   
image/png   
video/mp4   
application/javascript   
> 参考：http://www.w3school.com.cn/media/media_mimeref.asp
# HTTP协议
HTTP协议的主要特点:
1. 支持**客户/服务器模式**。
2. **简单快速**：客户向服务器请求服务时，只需传送请求方法和路径。请求方法常用的有GET、HEAD、POST。每种方法规定了客户与服务器联系的类型不同。由于HTTP协议简单，使得HTTP服务器的程序规模小，因而通信速度很快。
3. **灵活**：HTTP允许传输任意类型的数据对象。正在传输的类型由**Content-Type**加以标记。
4. **无连接**：无连接的含义是限制每次连接只处理一个请求。服务器处理完客户的请求，并收到客户的应答后，即断开连接。采用这种方式可以节省传输时间。
5. **无状态**：HTTP协议是无状态协议。无状态是指协议对于事务处理没有记忆能力。缺少状态意味着如果后续处理需要前面的信息，则它必须重传，这样可能导致每次连接传送的数据量增大。另一方面，在服务器不需要先前信息时它的应答就较快。
## HTTP常见协议对比
http/1.0：1996年5月,支持cache, MIME, method  
http/1.1：1997年1月  
http/2.0：2015年  

对比|HTTP1.0 | HTTP1.1 | 
---|---|---
缓存处理 | 使用header里的If-Modified-Since,Expires来做为缓存判断的标准 |引入了更多的缓存控制策略例如Entity tag，If-Unmodified-Since, If-Match, If-None-Match等更多可供选择的缓存头来控制缓存策略
带宽优化及网络连接的使用 | 存在一些浪费带宽的现象，例如客户端只是需要某个对象的一部分，而服务器却将整个对象送过来了，并且不支持断点续传功能 |在请求头引入了range头域，它允许只请求资源的某个部分，即返回码是206（Partial Content），这样就方便了开发者自由的选择以便于充分利用带宽和连接。这是支持文件断点续传的基础
错误通知的管理 | 基础返回码|新增了24个错误状态响应码，如409（Conflict）表示请求的资源与资源的当前状态发生冲突；410（Gone）表示服务器上的某个资源被永久性的删除
Host头处理|认为每台服务器都绑定一个唯一的IP地址。因此，请求消息中的URL并没有传递主机名（hostname）|虚拟主机技术的发展，在一台物理服务器上可以存在多个虚拟主机（Multi-homed Web Servers），并且它们共享一个IP地址。请求消息和响应消息都支持Host头域，且请求消息中如果没有Host头域会报告一个错误（400 Bad Request）
长连接|每个TCP连接只能发送一个请求。发送数据完毕，连接就关闭，如果还要请求其他资源，就必须再新建一个连接。|HTTP 1.1支持长连接（PersistentConnection）和请求的流水线（Pipelining）处理，在一个TCP连接上可以传送多个HTTP请求和响应，减少了建立和关闭连接的消耗和延迟，在HTTP1.1中默认开启Connection:keep-alive。
动作命令|引入了POST命令和HEAD命令|新增动词方法：PUT,OPTIONS,DELETE..
缺点|连接无法复用和head of line blocking。连接无法复用会导致每次请求都经历三次握手和慢启动。三次握手在高延迟的场景下影响较明显，慢启动则对文件类大请求影响较大。head of line blocking会导致带宽无法被充分利用，以及后续健康请求被阻塞。|所有的数据通信是按次序进行的。服务器只有处理完一个回应，才会进行下一个回应。要是前面的回应特别慢，后面就会有许多请求排队等着。这称为"队头堵塞"

#### HTTP2
HTTP/2 通过让所有数据流共用同一个连接，可以更有效地使用 TCP 连接，让高带宽也能真正的服务于 HTTP 的性能提升。
特点 | 说明
---|---
新的二进制格式|在应用层(HTTP/2)和传输层(TCP or UDP)之间增加一个二进制分帧层。会将所有传输的信息分割为更小的消息和帧（frame）,并对它们采用二进制格式的编码。
多路复用 (Multiplexing) | 在一个连接里，客户端和浏览器都可以同时发送多个请求或回应，而且不用按照顺序一一对应，这样就避免了"队头堵塞"。
首部压缩（Header Compression） | 因为HTTP协议不带状态，所以请求的很多字段都是重复的，比如cookie，User Agent，每次请求都必须附带，会很浪费宽带也影响速度，对此作出了优化。一方面：头信息使用gzip或compress压缩后再发送；另一方面：客户端和服务器同时维护一张头信息表，所有字段都会存入这个表，生成一个索引号，以后就不发送同样字段了，只发送索引号，这样就提高速度了。
服务端推送（Server Push）|允许服务器未经请求，主动向客户端发送资源

#### HTTP2.0的多路复用和HTTP1.X中的长连接复用区别
- HTTP/1.0 一次请求-响应，建立一个连接，用完关闭；每一个请求都要建立一个连接；   
- HTTP/1.1 Pipeling解决方式为，若干个请求排队串行化单线程处理，后面的请求等待前面请求的返回才能获得执行机会，一旦有某请求超时等，后续请求只能被阻塞，毫无办法，也就是人们常说的队头阻塞；     
- HTTP/2多个请求可同时在一个连接上并行执行。某个请求任务耗时严重，不会影响到其它连接的正常执行；    
具体如图：   
![HTTP2](https://upload-images.jianshu.io/upload_images/138606-37ea7846b10ea092.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600/format/webp)

# HTTP工作机制
- 工作机制：   
http请求：http request   
http响应：http response   
一次http事务：请求<-->响应    
- Web资源：web resource  
一个网页由多个资源构成，打开一个页面，会有多个资源展示出来，但是每个资源都要单独请求。因此，一个“Web 页面”通常并不是单个资源，而是一组资源
的集合   
静态文件：无需服务端做出额外处理   
文件后缀：.html, .txt, .jpg, .js, .css, .mp3, .avi   
动态文件：服务端执行程序，返回执行的结果    
文件后缀：.php, .jsp ,.asp    
- 提高HTTP连接性能  
**并行连接**：通过多条TCP连接发起并发的HTTP请求    
**持久连接**：keep-alive,长连接，重用TCP连接，以消除连接和关闭的时延,以事务个数和时间来决定是否关闭连接    
**管道化连接**：通过共享TCP连接发起并发的HTTP请求    
**复用的连接**：交替传送请求和响应报文   

# URI
URI: Uniform Resource Identifier **统一资源标识**，分为URL和URN
- URN: Uniform Resource Naming，**统一资源命名**   
示例： P2P下载使用的磁力链接是URN的一种实现    
magnet:?xt=urn:btih:660557A6890EF888666
- URL: Uniform Resorce Locator，**统一资源定位符**，用于描述某服务器某特
定资源位置   
- 两者区别：URN如同一个人的名称，而URL代表一个人的住址。  
  换言之，URN定义某事物的身份，而URL提供查找该事物的方法。URN仅用于命名，而不指定地址。

## URL组成
<scheme>://<user>:<password>@<host>:<port>/<path>;<params>?<query>#<frag>
- scheme:**方案**，访问服务器以获取资源时要使用哪种**协议**。#http、https、ftp等等
- user:用户，某些方案访问资源时需要的用户名  #较少使用
- password:密码，用户对应的密码，中间用":"分隔  #较少使用
- Host:**主机**，资源宿主服务器的**主机名**或**IP地址**  #一般为FQDN
- port:**端口**,资源宿主服务器正在监听的**端口号**，很多方案有默认端口号
- path:**路径**,服务器资源的本地名，由一个/将其与前面的URL组件分隔
- params:参数，指定输入的参数，参数为名/值对，多个参数，用;分隔
- query:**查询**，传递参数给程序，如数据库，**用？分隔,多个查询用&分隔**
- frag:片段,一小片或一部分资源的名字，此组件在客户端使用，**用#分隔**
```
https://list.jd.com/list.html?cat=670,671,672&ev=149_2992&sort=sort_t #? &查询
http://apache.org/index.html#projects-list                            #查询
```
# 网站访问量
- **IP(独立IP)**：即Internet Protocol,指独立IP数。**一天内来自相同客户机IP地址只计算一次**，记录远程客户机IP地址的计算机访问网站的次数，是衡量网站流量的重要指标
- **PV(访问量)**： 即Page View, 页面浏览量或点击量，**用户每次刷新即被计算一次**，PV反映的是浏览某网站的页面数，PV与来访者的数量成正比，PV并不是页面的来访者数量，而是网站被访问的页面数量
- **UV(独立访客)**：即Unique Visitor,访问网站的一台电脑为一个访客。**一天内相同的客户端只被计算一次**。可以理解成访问某网站的电脑的数量。网站判断来访电脑的身份是通过来访电脑的cookies实现的。如果更换了IP后但不清除cookies，再访问相同网站，该网站的统计中UV数是不变的
```
示例：
甲乙丙三人在同一台通过ADSL上网的电脑上（中间没有断网），分别访问www.test.com网站，并且每人各浏览了2个页面，那么网站的流量统计是：
 IP: 1 PV:6 UV：1
若三人都是ADSL重新拨号后,各浏览了2个页面，则
 IP: 3 PV:6 UV：1
```
- **QPS**：request per second，每秒请求数
- PV，QPS,并发连接数换算公式    
QPS= PV* 页⾯衍⽣连接次数/ 统计时间（86400） #页⾯衍⽣连接次数:页面包含的所有资源数   
并发连接数 =QPS * http平均响应时间     
- 峰值时间：每天80%的访问集中在20%的时间里，这20%时间为峰值时间
- 峰值时间每秒请求数(QPS)=( 总PV数 *页⾯衍⽣连接次数）*80% ) / ( 每天秒数* 20% ) 

# Web服务请求处理步骤
![web](http://zhangqifei.top/picture/httpd/4.jpg)
1. 建立连接：接收或拒绝连接请求   
1. 接收请求：接收客户端请求报文中对某资源的一次请求的过程    
Web访问响应模型（Web I/O）    
- 单进程I/O模型：启动一个进程处理用户请求，而且一次只处理一个，多个请求被串行响应   
- 多进程I/O模型(apache)：并行启动多个进程,每个进程响应一个连接请求    
- 复用I/O结构(nginx)：启动一个进程，同时响应N个连接请求    
实现方法：多线程模型和事件驱动    
多线程模型：一个进程生成N个线程，每线程响应一个连接请求     
事件驱动：一个进程处理N个请求     
- 复用的多进程I/O模型：启动M个进程，每个进程响应N个连接请求，同时接收M*N个请求    
![web](http://zhangqifei.top/picture/httpd/5.jpg)
3. 处理请求：服务器对请求报文进行解析，并获取请求的资源及请求方法等相关信息，根据方法，资源，首部和可选的主体部分对请求进行处理    
元数据：请求报文首部     
<method> <URL> <VERSION>    
HEADERS 格式 name:value    
<request body>    
示例：   
Host: www.test.com 请求的主机名称   
Server: Apache/2.4.7    
HTTP常用请求方式，Method   
GET、POST、HEAD、PUT、DELETE、TRACE、OPTIONS
4. 访问资源：     
服务器获取请求报文中请求的资源web服务器，即存放了web资源的服务器，负责向请求者提供对方请求的静态资源，或动态运行后生成的资源     
资源放置于本地文件系统特定的路径：DocRoot   
DocRoot /var/www/html    
/var/www/html/images/logo.jpg    
http://www.test.com/images/logo.jpg       
web服务器资源路径映射方式：  
(a) docroot   
(b) alias   
(c) 虚拟主机docroot     
(d) 用户家目录docroot    
5. 构建响应报文：    
一旦Web服务器识别除了资源，就执行请求方法中描述的动作，并返回响应报文。响应报文中包含有响应状态码、响应首部，如果生成了响应主体的话，还包
括响应主体    
1）响应实体：如果事务处理产生了响应主体，就将内容放在响应报文中回送过去。    
响应报文中通常包括：    
 描述了响应主体MIME类型的Content-Type首部    
 描述了响应主体长度的Content-Length     
 实际报文的主体内容    
2）URL重定向：web服务构建的响应并非客户端请求的资源，而是资源另外一个访问路径   
3）MIME类型：    
 Web服务器要负责确定响应主体的MIME类型。多种配置服务器的方法可将    
MIME类型与资源管理起来    
 魔法分类：Apache web服务器可以扫描每个资源的内容，并将其与一个已知模式表(被称为魔法文件)进行匹配，以决定每个文件的MIME类型。这样做可能比较慢，但很方便，尤其是文件没有标准扩展名时    
 显式分类：可以对Web服务器进行配置，使其不考虑文件的扩展名或内容，强制特定文件或目录内容拥有某个MIME类型    
 类型协商： 有些Web服务器经过配置，可以以多种文档格式来存储资源。在这种情况下，可以配置Web服务器，使其可以通过与用户的协商来决定使用哪种格式(及相关的MIME类型)"最好"   
6. 发送响应报文    
Web服务器通过连接发送数据时也会面临与接收数据一样的问题。服务器可能有很多条到各个客户端的连接，有些是空闲的，有些在向服务器发送数据，还有一些在向客户端回送响应数据。服务器要记录连接的状态，还要特别注意对持久连接的处理。对非持久连接而言，服务器应该在发送了整条报文之后，关闭自己这一端的连接。对持久连接来说，连接可能仍保持打开状态，在这种情况下，服务器要正确地计算Content-Length首部，不然客户端就无法知道响应什么时候结束了    
7. 记录日志     
最后，当事务结束时，Web服务器会在日志文件中添加一个条目，来描述已执行的事务    
# HTTP服务器应用
- http服务器程序   
httpd apache   
nginx   
lighttpd   
- 应用程序服务器   
IIS .asp   
tomcat .jsp    
jetty 开源的servlet容器，基于Java的web容器   
Resin CAUCHO公司，支持servlets和jsp的引擎   
webshpere(IBM), weblogic(BEA), jboss,oc4j(Oracle)   
# Apache Httpd介绍
httpd     
20世纪90年代初，国家超级计算机应用中心NCSA开发
1995年开源社区发布apache（a patchy server）   
ASF: apache software foundation    
FSF：Free Software Foundation   
特性：      
高度模块化：core + modules   
DSO: Dynamic Shared Object 动态加/卸载   
MPM：multi-processing module多路处理模块    
# MPM多路处理模块工作模式
- prefork：多进程I/O模型，每个进程响应一个请求，**默认模型**
 一个主进程：生成和回收n个子进程，创建套接字，不响应请求    
 多个子进程：工作work进程，每个子进程处理一个请求；系统初始时，预先生成多个空闲进程，等待请求，最大不超过1024个 
![mpm](https://www.nmirage.com/content/uploadfile/201705/thum-4e181495095344.jpg)
- worker：复用的多进程I/O模型,多进程多线程，IIS使用此模型    
一个主进程：生成m个子进程，每个子进程负责生个n个线程，每个线程响应一个请求，并发响应请求：m*n    
![mpm](https://www.nmirage.com/content/uploadfile/201705/thum-83e81495095458.jpg)
- event：事件驱动模型（worker模型的变种）    
一个主进程：生成m个子进程，每个进程直接响应n个请求，并发响应请求：m*n，有专门的线程来管理这些keep-alive类型的线程，当有真实请求时，将请求传递给服务线程，执行完毕后，又允许释放。这样增强了高并发场景下的请求处理能力   
![mpm](https://www.nmirage.com/content/uploadfile/201705/thum-c0071495095513.jpg)

# HTTPD worker进程
![worker](https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544612636370&di=9076db9e56ab65d5f0c6d26a94e31d04&imgtype=0&src=http%3A%2F%2Fwww.myexception.cn%2Fimg%2F2015%2F05%2F17%2F16291238.png)
# httpd功能特性
虚拟主机 利用IP、Port、FQDN    
CGI：Common Gateway Interface，通用网关接口   
反向代理  
负载均衡   
路径别名   
丰富的用户认证机制   
basic   
digest   
支持第三方模块   

# Httpd-2.4
新特性
- MPM支持运行为DSO机制；以模块形式按需加载
- event MPM生产环境可用
- 异步读写机制
- 支持每模块及每目录的单独日志级别定义
- 每请求相关的专用配置
- 增强版的表达式分析式
- 毫秒级持久连接时长定义
- 基于FQDN的虚拟主机不需要NameVirutalHost指令
- 新指令，AllowOverrideList
- 支持用户自定义变量
- 更低的内存消耗

# Httpd常见配置
建议在/etc/httpd/conf.d下创建一个独立的配置文件来设置httpd服务器
## 显示服务器版本信息   
ServerTokens Prod #仅显示软件名称   
## 监听端口  
1. 可以监听多个端口  
`listen 8080`  
`listen 80`   
2. 可以将指定IP地址与端口绑定   
`listen 192.168.2.188:8080`
>  省略IP表示为本机所有IP
## 持久连接
Persistent Connection  
断开条件：时间限制：以秒为单位，默认5s，httpd-2.4 支持毫秒级   
`keepalive on|off `  
`KeepAliveTimeout 15`
## MPM多路处理模块   
1. 切换MPM修改配置文件    
`/etc/httpd/conf.modules.d/00-mpm.conf`    
默认为`LoadModule mpm_prefork_module modules/mod_mpm_prefork.so`
2. 查看静态编译的模块   
`httpd -l`   
3. 查看静态编译和动态装载的模块   
`httpd -M`
>  动态模块加载不需要重启   
动态模块路径：/usr/lib64/httpd/modules  
- prefork的配置：   
StartServers 8    
MinSpareServers 5     #保证最小的空闲链接数
MaxSpareServers 20    
ServerLimit 256 最多进程数,最大20000    
MaxRequestsPerChild 4000 子进程最多能处理的请求数量。在处理MaxRequestsPerChild 个请求之后,子进程将会被父进程终止，这时候子进程占用的内存就会释放(为0时永远不释放）
- worker的配置：   
ServerLimit 16   
StartServers 2   
MaxRequestWorkers 150   
MinSpareThreads 25   #最小空闲线程
MaxSpareThreads 75   
ThreadsPerChild 25  

## DSO Dynamic Shared Object
加载动态模块配置   
/etc/httpd/conf/httpd.conf  
Include conf.modules.d/*.conf   
配置指定实现模块加载格式：   
LoadModule <mod_name> <mod_path>   
LoadModule auth_basic_module modules/mod_auth_basic.so
## Main server页面路径
默认网页主页路径：  
`DocumentRoot "/var/www/html"`   
修改首页文件位置：
1. /data下新建文件夹并创建index.html
2. 修改配置文件
```
DocumentRoot "/data/www"
<directory /data/www>
require all granted
</directory>
```
3. 重启服务验证
## 定义站点主页文件
默认设置：  
`DirectoryIndex /var/www/html/index.html`  
首次启动页面：  
`/etc/httpd/conf.d/welcome.conf  `
> 自定义首页文件时，需要注意注释原配置文件内容  
加载配置文件按顺序命令顺序加载  
## 站点访问控制
两种控制方式：
1. 基于IP控制
2. 基于访问用户  

### 基于IP的访问控制:   
无明确授权的目录，**默认拒绝**   
允许所有主机访问：Require all granted    
拒绝所有主机访问：Require all denied    
控制特定的IP访问：    
Require ip IPADDR：授权指定来源的IP访问    
Require not ip IPADDR：拒绝特定的IP访问    
控制特定的主机访问：    
Require host HOSTNAME：授权特定主机访问    
Require not host HOSTNAME：拒绝    
HOSTNAME：   
FQDN：特定主机    
domin.tld：指定域名下的所有主机   
```
示例：
<directory /data/www>
<requireall>                 #requireall
require all granted
require not ip 192.168.34.8  #拒绝特定IP
</requireall>
</directory>

<directory /data/www>
<requireany>                 #requireany
require all denied
require ip 192.168.34.8      #允许特定IP
</requireany>
</directory>
```
### 对二级页面设置权限
```
<directory /data/www> #首页允许访问
require all granted
</directory>
<directory /data/www/sports>  #二级页面sports拒绝访问
require all denied
</directory>
```
### <Directory>中“基于源地址”实现访问控制
#### Options indexes   
指明的URL路径下不存在与定义的主页面资源相符的资源文件时，返回索引列表给用户  
实现类似yum源网站的页面
1. 重命名或移除原有默认网页文件  
`mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.bak`  
`mv /data/www/index.html /data/www/index.html.bak`
2. 修改配置文件添加选项启用
```
vim /etc/httpd/conf.d/test.conf
DocumentRoot "/data/www"
<directory /data/www>
options indexes       #添加此选项启用indexes
require all granted
</directory>
```
3. 重启服务验证

#### Options indexes FollowSymLinks
允许访问符号链接文件所指向的源文件  
在网页文件夹中创建软链接
ln -s /etc  /data/www/etcdir
```
vim /etc/httpd/conf.d/test.conf
DocumentRoot "/data/www"
<directory /data/www>
options indexes  FollowSymLinks  #添加此选项启用软链接
require all granted
</directory>
```
### AllowOverride
与访问控制相关的哪些指令可以放在指定目录下的.htaccess（由AccessFileName指定）文件中，覆盖之前的配置指令     
只对<directory>语句有效    
AllowOverride All: .htaccess中所有指令都有效  
AllowOverride None： .htaccess 文件无效   
AllowOverride AuthConfig Indexes    除了AuthConfig 和Indexes的其它指令都无法覆盖  

## 日志设定
日志文件：   
/var/log/httpd   
access_log：访问日志  
error_log：错误日志  

主配置文件里提供了两种日志的模板：common和combined    
```
<IfModule log_config_module>
LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
LogFormat "%h %l %u %t \"%r\" %>s %b" common
```

参数 | 说明
---|---
%h | 远端主机
%l | 远端登录名(由identd而来，如果支持的话)，除非IdentityCheck设为"On"，否则将得到一个"-"。
%u | 远程用户名(根据验证信息而来；如果返回status(%s)为401，可能是假的)
%t | 时间，用普通日志时间格式(标准英语格式)
%r | 请求的第一行
%s | 状态。对于内部重定向的请求，这个状态指的是原始请求的状态。%>s则指的是最后请求的状态。
%b | 以CLF格式显示的除HTTP头以外传送的字节数，也就是当没有字节传送时显示’-'而不是0。
%{Referer}i | 记录本次访问来源
%{User-Agent}i | 客戶端的浏览器状态
COMBINED 日志模板详解
```
LogFormat "%h  %l  %u  %t  \"%r\"  %>s  %b  \"%{Referer}i\"  \"%{User-Agent}i\"" combined

它记录的样子是这样的：

192.168.34.1 - - [12/Dec/2018:22:13:44 +0800] "GET / HTTP/1.1" 403 202 "-" "Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko"

说明如下：
1. 192.168.34.1 是访问网页的客户端IP
2. 第一个 '-' 是 %l 因为此网页不必认证，所以logname 为空
3. 第二個 '-' 是 %u 因为此网页不必认证，所以username 为空
4. [12/Dec/2018:22:13:44 +0800] 是时间
5. "GET / HTTP/1.1" 为客户端的request，请求访问的资源
6. 403  %s 是状态，%>s是取得最后请求的状态，数字403代表权限拒绝
7. 202 排除掉HTTP的headers后的长度(Bytes)
8. "-" 记录referer。也就是导航到此request页面的跳转页，这里可以当来源分析。"-"代表直接访问
9. "Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko" 是客戶端的浏览器状态。
```
## 设定默认字符集
AddDefaultCharset UTF-8 此为默认值   
中文字符集：GBK, GB2312, GB18030
## 定义路径别名
格式：Alias /URL/ "/PATH/"   
实现同一域名路径下的不同网页文件的调用  
```
alias /tv   /media/www/   #将/tv二级目录指向/media/www/
<directory /media/www>   #授权文件夹访问权限
require all granted
</directory>
```
## 基于用户的访问控制
- 认证质询：WWW-Authenticate：响应码为401，拒绝客户端请求，并说明要求客户端提供账号和密码
- 认证：Authorization：客户端用户填入账号和密码后再次发送请求报文；认证通过时，则服务器发送响应的资源
- 认证方式两种：   
basic：明文  
digest：消息摘要认证,兼容性差    
- 安全域：需要用户认证后方能访问的路径；应该通过名称对其进行标识，以便于告知用户认证的原因
- 用户的账号和密码   
**虚拟账号**：仅用于访问某服务时用到的认证标识      
存储：文本文件，SQL数据库，ldap目录存储，nis等
### 提供账号和密码存储（文本文件）
使用专用命令完成此类文件的创建及用户管理    
htpasswd [options] /PATH/HTTPD_PASSWD_FILE username    
-c **自动创建文件，仅应该在文件不存在时使用**  
-p 明文密码   
-d CRYPT格式加密，默认   
-m md5格式加密   
-s sha格式加密  
-D 删除指定用户  
```
htpasswd -c /etc/httpd/conf.d/httppwd  testuser1   #-c第一创建文件
htpasswd  /etc/httpd/conf.d/httppwd  testuser2
[root@7 ~]# cat /etc/httpd/conf.d/httppwd 
testuser1:$apr1$tjb70SaX$nohbo6SRz4riyjQh.cxXY.
testuser2:$apr1$T4IG1mh9$ZYpx.F.wNvYVTQ9Ho63nr.
chmod 600 /etc/httpd/conf.d/httppwd                #修改权限，仅root可读写
setfacl -m u:apache:r /etc/httpd/conf.d/httppwd  #实际运行进程的用户apache需要单独设置可读权限才可以访问
```
> 只需在第一次创建时加-c，之后不需再加
### 用户定义安全域   
```
示例：
<directory /data/www/admin>              #需要验证的二级目录
AuthType Basic                           #采用的验证方式
AuthName "Please Auth"                   #标题描述信息
AuthUserFile "/etc/httpd/conf.d/httppwd" #存储验证用户的文件路径
Require user  testuser1                  #可以授权访问的用户
</directory>
```
> 允许账号文件中的所有用户登录访问：   
Require valid-user
### 组定义安全域
```
1. 创建用户账号和组账号文件
vim /etc/httpd/conf.d/httpgroup
admingrp:testuser1 testuser2

2. 修改配置文件
vim /etc/httpd/conf.d/test.conf

<directory /data/www/admin>
AuthType Basic
AuthName "Please Auth"
AuthUserFile "/etc/httpd/conf.d/httppwd"    #写明存储验证用户的文件路径
AuthGroupFile "/etc/httpd/conf.d/httpgroup" #写明存储验证用户组的文件路径
Require group  admingrp                     #组文件中可以授权的组
</directory>
```
## 远程客户端和用户验证的控制
Satisfy ALL|Any   
ALL：客户机IP和用户验证都需要通过才可以   
Any：客户机IP和用户验证,有一个满足即可   
## 实现用户家目录的http共享
基于模块mod_userdir.so实现   
`httpd -M | grep userdir`
1. 修改模块配置文件
```
vim /etc/httpd/conf.d/userdir.conf

<IfModule mod_userdir.c>
UserDir enabled          #启用模块功能
UserDir public_html      #共享的文件夹
</IfModule>
采用验证访问的方式
<directory /home/nie/public_html>        #授权访问的目录
authtype basic                           #采用的验证方式
authname "nie home"                      #标题描述信息
authuserfile "/etc/httpd/conf.d/httppwd" #存储验证用户的文件路径
require user testuser2                   #可以授权访问的用户
</directory>
```
2. 重启httpd服务   
`systemctl restart httpd`
3. 创建用户家目录并设置权限
```
su - nie                                 #切换用户家目录
mkdir public_html                        #创建文件夹
echo nie home > public_html/index.html   #文件中需要有index主页文件
setfacl -m u:apache:x /home/nie          #一定要给apache账户访问用户家目录的执行权限，这样才可以读取文件夹中的文件
```
4. 验证访问   
http://192.168.34.10/~nie/index.html   
使用testuser2登录
## 错误页面提示ServerSignature
当客户请求的网页并不存在时，服务器将产生错误档，缺省情况下由于打开了ServerSignature选项，错误文档的最后一行将包含服务器的名字、Apache的版本等信息   
httpd2.4 已经默认关闭    
`ServerSignature On | Off`
## status页面
基于模块mod_status.so实现   
`httpd -M | grep status`
修改配置文件启用模块  
```
<location /status>       #页面的访问路径
sethandler server-status #调用status模块
</location>
```
> ExtendedStatus On 显示扩展信息

## 虚拟主机
站点标识： socket    
IP相同，但端口不同    
IP不同，但端口均为默认端口    
FQDN不同：请求报文中首部  利用HOST主机头实现
有三种实现方案：   
基于ip：为每个虚拟主机准备至少一个ip地址   
基于port：为每个虚拟主机使用至少一个独立的port    
基于FQDN：为每个虚拟主机使用至少一个FQDN    
```
基于IP的虚拟主机示例
<VirtualHost 192.168.34.8:80>      #不同IP指向不同域名
ServerName www.a.com            #需配合DNS使用
DocumentRoot /data/www/a.com/htdocs
<directory /data/www/a.com/htdocs>   #必须有文件夹的授权访问
require all granted
</directory>
ErrorLog /var/log/www.a.com-error_log   #指定错误日志的路径
CustomLog /var/log/www.a.com-access_log combined  #指定访问日志的路径，并定义类型，combined类型在主配置文件里面已经定义了，在这里就不用加上LogFormat这一行了。

</VirtualHost>
<VirtualHost 192.168.34.9:80>
ServerName www.b.net            
DocumentRoot /data/www/b.net/htdocs
<directory /data/www/b.net/htdocs>
require all granted
</directory>
ErrorLog /var/log/www.b.net-error_log
CustomLog /var/log/www.b.net-access_log combined
</VirtualHost>
<VirtualHost 192.168.34.10:80>
ServerName www.c.org
DocumentRoot /data/www/c.org/htdocs
<directory /data/www/c.org/htdocs>
require all granted
</directory>
ErrorLog /var/log/www.c.org-error_log
CustomLog /var/log/www.c.org-access_log combined
</VirtualHost>
```
```
基于端口的虚拟主机：可和基于IP的虚拟主机混和使用
基于IP的虚拟主机示例
listen 808
listen 8080
<VirtualHost 192.168.34.8:80>      
ServerName www.a.com            #需配合DNS使用
DocumentRoot /data/www/a.com/htdocs
<directory /data/www/a.com/htdocs>   #必须有文件夹的授权访问
require all granted
</directory>
ErrorLog /var/log/www.a.com-error_log
CustomLog /var/log/www.a.com-access_log combined
</VirtualHost>
<VirtualHost 192.168.34.8:808>
ServerName www.b.net            
DocumentRoot /data/www/b.net/htdocs
<directory /data/www/b.net/htdocs>
require all granted
</directory>
ErrorLog /var/log/www.b.net-error_log
CustomLog /var/log/www.b.net-access_log combined
</VirtualHost>
<VirtualHost 192.168.34.8:8080>
ServerName www.c.org
DocumentRoot /data/www/c.org/htdocs
<directory /data/www/c.org/htdocs>
require all granted
</directory>
ErrorLog /var/log/www.c.org-error_log
CustomLog /var/log/www.c.org-access_log combined
</VirtualHost>
```
```
基于FQDN虚拟主机
<VirtualHost *:80>
ServerName www.a.com
DocumentRoot "/data/www/a.com/htdocs"
<directory /data/www/a.com/htdocs>
require all granted
</directory>
ErrorLog /var/log/www.a.com-error_log
CustomLog /var/log/www.a.com-access_log combined
</VirtualHost>
<VirtualHost *:80>
ServerName www.b.net
DocumentRoot "/data/www/b.net/htdocs"
<directory /data/www/b.net/htdocs>
require all granted
</directory>
ErrorLog /var/log/www.b.net-error_log
CustomLog /var/log/www.b.net-access_log combined
</VirtualHost>
<VirtualHost *:80>
ServerName www.c.org
DocumentRoot "/data/www/c.org/htdocs"
<directory /data/www/c.org/htdocs>
require all granted
</directory>
ErrorLog /var/log/www.c.org-error_log
CustomLog /var/log/www.c.org-access_log combined
</VirtualHost>
```
# mod_deflate模块
使用mod_deflate模块压缩页面优化传输速度  
适用场景：   
(1) 节约带宽，额外消耗CPU；   
(2) 压缩适于压缩的资源，例如文本文件   
压缩模块，生产环境建议启用   
基于模块mod_deflate.so实现   
`httpd -M | grep deflate`
```
<VirtualHost *:80>
ServerName www.a.com
DocumentRoot "/data/www/a.com/htdocs"
<directory /data/www/a.com/htdocs>
require all granted
</directory>
ErrorLog /var/log/www.a.com-error_log
CustomLog /var/log/www.a.com-access_log combined
AddOutputFilterByType DEFLATE text/plain        #启用压缩纯文本
AddOutputFilterByType DEFLATE text/html         #启用压缩静态页面
DeflateCompressionLevel 9                       #指定压缩比9
</VirtualHost>
```
# HTTPS
https：http over ssl   
SSL会话的简化过程
1. 客户端发送可供选择的加密方式，并向服务器请求证书
1. 服务器端发送证书以及选定的加密方式给客户端
1. 客户端取得证书并进行证书验证
1. 如果信任给其发证书的CA
1. 验证证书来源的合法性；用CA的公钥解密证书上数字签名
1. 验证证书的内容的合法性：完整性验证
1. 检查证书的有效期限
1. 检查证书是否被吊销
1. 证书中拥有者的名字，与访问的目标主机要一致
1. 客户端生成临时会话密钥（对称密钥），并使用服务器端的公钥加密此数据发送给服务器，
1. 完成密钥交换
1. 服务用此密钥加密用户请求的资源，响应给客户端
> 注意：SSL是基于IP地址实现,单IP的主机仅可以使用一个https虚拟主机
```
实现过程示例：

需要四台主机，a是客户端，b是web服务器，c是dns服务器，d是提供CA的主机
1、在b上创建一个虚拟主机www.a.com
2、在c上搭建dns服务器，用于解析www.a.com这个域名，如果不搭建dns也可以用本机的hosts文件，windows中的hosts文件在c:\Windows\System32\drivers\etc\hosts
3、在d上搭建CA
cd /etc/pki/CA                                                               #进入CA的主目录
(umask 066;openssl genrsa -out private/cakey.pem 4096)                       #生成私钥
openssl req -new -x509 -key private/cakey.pem -out cacert.pem -days 3650     #生成CA自签名证书
openssl x509 -in cacert.pem -nonot -text                                     #查看证书
touch index.txt                                                              #创建数据库文件
echo 01 >serial                                                              #创建证书编号文件
3、在b服务器端发起证书请求
mkdir /etc/httpd/conf.d/ca                                                   #创建一个目录专门存放证书的相关文件
cd /etc/httpd/conf.d/ca
(umask 066;openssl genrsa -out httpd.key 1024)                               #生成私钥
openssl req -new -key httpd.key -out httpd.csr   #生成证书签名请求文件，这个过程中要填入www.a.com这个主机名，也就是这个证书将来是给这个web网站使用的。
scp httpd.csr 172.18.21.107:/etc/pki/CA
3、在d上颁发证书
openssl ca -in httpd.csr -out httpd.crt -days 365
scp certs/httpd.crt 172.18.21.106:/etc/httpd/conf.d/ca                       #将web网页的证书文件和CA自签名的证书文件都传给服务器端
scp cacert.pem 172.18.21.106:/etc/httpd/conf.d/ca
[root@centos6 ca]#ls                                                         #在b上查看有这些证书文件
cacert.pem  httpd.crt  httpd.csr  httpd.key
4、在b上安装mod_ssl软件包
yum install mod_ssl                                                          #这个软件包是提供https服务用的
rpm -ql mod_ssl
5、在b上修改https的配置文件
vim /etc/httpd/conf.d/ssl.conf
DocumentRoot "/app/website1"   #指明https的主目录，这个目录和http服务的主目录可以不相同，但一般情况下应该是相同的，不能客户通过http和https访问同样的站点里面的内容不一样
SSLCertificateFile /etc/httpd/conf.d/ca/httpd.crt                            #指明证书文件的路径
SSLCertificateKeyFile /etc/httpd/conf.d/ca/httpd.key                         #指明私钥文件路径
SSLCACertificateFile /etc/httpd/conf.d/ca/cacert.pem                         #指明CA自签名证书文件路径
service httpd restart
6、测试
将windows机器上的dns指向c的dns服务器地址，并将a上的dns也改成c的nds服务器地址
网页上测试
打开网页https://www.a.com/会提示证书不受信任，只要将CA自签名的证书安装成受信任的证书机构即可，注意只需要安装根证书就可以。
a上测试
[root@centos6 html]#curl -k https://www.a.com---linux中字符界面下也可以测试，-k表示忽略证书进行ssl连接
[root@centos6 app]#curl --cacert cacert.pem    https://www.a.com/   #也可以用这个命令，但要将b上的CA证书文件传到a上才可以
[root@centos6 app]#openssl s_client -connect www.a.com:443
```
## http重定向https
将http请求转发至https的URL    
重定向     
Redirect [status] URL-path URL
status状态：    
Permanent： 返回永久重定向状态码 301    
Temp：返回临时重定向状态码302. 此为默认值    
```
vim /etc/httpd/conf/httpd.conf
redirect temp / https://192.168.34.10 将http跳转到https
```
> 简单的跳转中间存在安全风险，第一次的访问还是明文消息，建议采取HSTS方式跳转

## HSTS
- HSTS:HTTP Strict Transport Security   
服务器端配置支持HSTS后，会在给浏览器返回的HTTP首部中携带HSTS字段。浏览器获取到该信息后，会将所有HTTP访问请求在内部做307跳转到HTTPS。而无需任何网络过程
- HSTS preload list  
是Chrome浏览器中的HSTS预载入列表，在该列表中的网站，使用Chrome浏览器访问时，会自动转换成HTTPS。Firefox、Safari、Edge浏览器也会采用这个列表
```
实现HSTS示例：
vim /etc/httpd/conf/httpd.conf
Header always set Strict-Transport-Security "max-age=31536000"  #安全跳转生命期一年
RewriteEngine on    #开启重写跳转引擎
RewriteRule ^(/.*)$ https://%{HTTP_HOST}$1 [redirect=302]      #定义规则，http页面跳转到https，并显示302状态码
```
# 反向代理功能
启用反向代理
```
vim /etc/httpd/conf.d/proxy.conf
ProxyPass "/" "http://192.168.34.8"        #将访问/请求转发到后方34.8
ProxyPassReverse "/" "http://192.168.34.8" #34.8返回页面给代理服务器

将特定页面转发到后方服务器
ProxyPass "/sports" "http://192.168.34.9/"
ProxyPassReverse "/sports" "http://192.168.34.9/"
```
# Sendfile机制
- 未启用sendfile    
硬盘 >> kernel buffer >> user buffer >> kernel socket buffer >> 协议栈  
一般网络应用通过读硬盘数据，写数据到 socket 来完成网络传输,底层执行过程：
1. 系统调用 read() 产生一个上下文切换：从 user mode 切换到 kernel mode，然后DMA 执行拷贝，把文件数据从硬盘读到一个 kernel buffer 里。
2. 数据从 kernel buffer 拷贝到 user buffer，然后系统调用 read() 返回，这时又产生一个上下文切换：从kernel mode 切换到 user mode
3. 系统调用 write() 产生一个上下文切换：从 user mode 切换到 kernel mode，然后把步骤2读到 user buffer的数据拷贝到 kernel buffer（数据第2次拷贝到 kernel buffer），不过这次是个不同的 kernel buffer，这个buffer和 socket 相关联。
4. 系统调用 write() 返回，产生一个上下文切换：从 kernel mode 切换到 user mode(第4次切换),然后DMA从 kernel buffer 拷贝数据到协议栈（第4次拷贝）  
上面4个步骤有4次上下文切换，有4次拷贝，如能减少切换次数和拷贝次数将会有效提升性能  

- 启用sendfie机制   
硬盘 >> kernel buffer (快速拷贝到kernel socket buffer) >> 协议栈    
1. 系统调用 sendfile() 通过 DMA 把硬盘数据拷贝到 kernel buffer，然后数据被kernel 直接拷贝到另外一个与 socket 相关的 kernel buffer。这里没有 usermode 和 kernel mode 之间的切换，在 kernel 中直接完成了从一个 buffer 到另一个 buffer 的拷贝
2. DMA 把数据从 kernel buffer 直接拷贝给协议栈，没有切换，也不需要数据从user mode 拷贝到 kernel mode，因为数据就在 kernel 里

# HTTP协议
- http协议   
http/0.9, http/1.0, http/1.1, http/2.0   
- http协议：stateless 无状态   
服务器无法持续追踪访问者来源   
- 解决http协议无状态方法   
cookie 客户端存放   
session 服务端存放   
- http事务：一次访问的过程   
请求：request   
响应：response   
- 报文语法格式：
```
request报文
<method> <request-URL> <version>
<headers>
<entity-body>
```
```
response报文
<version> <status> <reason-phrase>
<headers>
<entity-body>
```
- method: 请求方法，标明客户端希望服务器对资源执行的动作
GET、HEAD、POST等
- version:
HTTP/<major>.<minor>
- status:
三位数字，如200，301, 302, 404, 502; 标记请求处理过程中发生的情况
- reason-phrase：
状态码所标记的状态的简要描述
- headers：
每个请求或响应报文可包含任意个首部；每个首部都有首部名称，后面跟一个冒号，而后跟一个可选空格，接着是一个值
- entity-body：
请求时附加的数据或响应时附加的数据
#### Method 方法：  
**GET**： 从服务器获取一个资源  
**HEAD**： 只从服务器获取文档的响应首部   
POST： 向服务器输入数据，通常会再由网关程序继续处理   
**PUT**： 将请求的主体部分存储在服务器中，如上传文件   
DELETE： 请求删除服务器上指定的文档   
TRACE： 追踪请求到达服务器中间经过的代理服务器  
OPTIONS：请求服务器返回对指定资源支持使用的请求方法   
协议查看或分析的工具：  
tcpdump, wireshark,tshark
## HTTP请求报文
![http](https://upload-images.jianshu.io/upload_images/6854348-c09f8c705225d388.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/660/format/webp)
## HTTP响应报文
![http](https://upload-images.jianshu.io/upload_images/6854348-df53fe7a580fd8fe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/614/format/webp)

## http协议状态码分类
status(状态码)：   
1xx：100-101 信息提示   
2xx：200-206 成功   
3xx：300-305 重定向   
4xx：400-415 错误类信息，客户端错误   
5xx：500-505 错误类信息，服务器端错误   
**常用的状态码**
状态码 | 含义
---|---
200 | OK；成功，请求已经正常处理完毕送
301 | Moved Permanently；请求永久重定向
302 | Moved Temporarily；请求临时重定向
304 | Not Modified；请求被重定向到客户端本地缓存
400 | Bad request；客户端请求存在语法错误
401 | Unauthorized；客户端请求没有经过授权
403 | Forbidden；请求被禁止，一般为客户端没有访问权限
404 | Not Found；服务器无法找到客户端请求的资源
500 | Internal Server Error；服务器内部错误
502 | Bad Gateway；代理服务器从后端服务器收到了一条伪响应，如无法连接到网关
503 | Service Unavailable；服务不可用，临时服务器维护或过载，服务器无法处理请求
504 | Gateway timeout；网关超时
## HTTP 首部字段
首部的分类：
- 通用首部:请求报文和响应报文两方都会使用的首部
- 请求首部:从客户端向服务器端发送请求报文时使用的首部。补充了请求的附加内容、客户端信息、请求内容相关优先级等信息
- 响应首部：从服务器端向客户端返回响应报文时使用的首部。补充了响应的附加内容，也会要求客户端附加额外的内容信息
- 实体首部：针对请求报文和响应报文的实体部分使用的首部。补充了资源内容更新时间等与实体有关的的信息
- 扩展首部
### 通用首部：
常见字段 | 说明
---|---
Date | 报文的创建时间
Connection | 连接状态，如keep-alive, close
Via | 显示报文经过的中间节点（代理，网关）
Cache-Control|控制缓存，如缓存时长
MIME-Version|发送端使用的MIME版本
Warning|错误通知
### 请求首部
常见字段 | 说明
---|---
Accept | 通知服务器自己可接受的媒体类型
Accept-Charset | 客户端可接受的字符集
Accept-Encoding|客户端可接受编码格式，如gzip
Accept-Language|客户端可接受的语言
Client-IP|请求的客户端IP
Host|请求的服务器名称和端口号
Referer|跳转至当前URI的前一个URL
User-Agent|客户端代理，浏览器版本
### 响应首部
常见字段 | 说明
---|---
Age | 从最初创建开始，响应持续时长
Server | 服务器程序软件名称和版本
Accept-Ranges|服务器可接受的请求范围类型
Vary|服务器查看的其它首部列表
Set-Cookie|向客户端设置cookie
WWW-Authenticate|来自服务器对客户端的质询列表
# Cookie
使用 Cookie 的状态管理Cookie 技术通过在
请求和响应报文中写入Cookie信息来控制客户端的状态。  
Cookie 会根据从服务器端发送的响应报文内的一个叫做 Set-Cookie的首部字段信息，通知客户端保存Cookie。当下次客户端再往该服务器发送请求时，客户端会自动在请求报文中加入Cookie值后发送出去。    
服务器端发现客户端发送过来的Cookie后，会去检查究竟是从哪一个客户端发来的连接请求，然后对比服务器上的记录，最后得到之前的状态信息
# seesion
Session是另一种记录客户状态的机制，不同的是Cookie保存在客户端浏览器中，而Session保存在服务器上。客户端浏览器访问服务器的时候，服务器把客户端信息以某种形式记录在服务器上。这就是Session。客户端浏览器再次访问时只需要从该Session中查找该客户的状态就可以了。  
如果说Cookie机制是通过检查客户身上的“通行证”来确定客户身份的话，那么Session机制就是通过检查服务器上的“客户明细表”来确认客户身份。Session相当于程序在服务器上建立的一份客户档案，客户来访的时候只需要查询客户档案表就可以了。

# curl工具
curl [options] [URL...]  

选项 | 说明
---|---
-A/--user-agent | 设置用户代理发送给服务器
-e/--referer | 来源网址
--cacert <file>|CA证书 (SSL)
-k/--insecure|允许忽略证书进行 SSL 连接
--compressed|要求返回是压缩的格式
-H/--header <line>|自定义首部信息传递给服务器
-i|显示页面内容，包括报文首部信息
-I/--head|只显示响应报文首部信息
-D/--dump-header <file> | 将url的header信息存放在指定文件中
--basic|使用HTTP基本认证
-u/--user <user[:password]>|设置服务器的用户和密码
-L|如果有3xx响应码，重新发请求到新位置
-O|使用URL中默认的文件名保存文件到本地
-o <file>|将网络文件保存为指定的文件中
--limit-rate <rate>|设置传输速度
-v/--verbose|更详细
-C|选项可对文件使用断点续传功能
-c/--cookie-jar <file name>|将url中cookie存放在指定文件中
-x/--proxy <proxyhost[:port]>|指定代理服务器地址
-X/--request <command>|向服务器发送指定请求方法
-U/--proxy-user <user:password>|代理服务器用户和密码
-T|选项可将指定的本地文件上传到FTP服务器上
--data/-d|方式指定使用POST方式传递数据
-b name=data|从服务器响应set-cookie得到值，返回给服务器
```
curl -A "IE8" www.a.com   ---设置用户代理发送给服务器，也就是可以伪造浏览器的类型，在日志里面可以查到
curl -e www.baidu.com www.a.com  ---可以伪造从哪跳转而来
curl -H "host: www.org" www.a.com   ---构造一个首部信息发给服务器
curl -D /app/head www.a.com   ---将响应报文的首部信息存放到指定文件中
curl --limit-rate 1024 -o /app/f1.log http://www.a.com/f1.html     ---设置传输速度为1kB/s
curl --basic -u haha:123456 www.c.org   ---访问网站的时候直接把用户名和密码都加上
curl -L www.360buy.com    ---可以显现自动跳转至新页面，不加-L只会报错但不会跳转，浏览器会自动跳转
curl -O ftp://172.18.0.1/pub/ks/CentOS-6.9-x86_64.cfg
---使url中的CentOS-6.9-x86_64.cfg这个文件保存到当前目录下
curl -c /app/baiducookie www.baidu.com   ---将url中的cookie存放到指定目录中
```
## elinks工具
elinks [OPTION]... [URL]...  
-dump: 非交互式模式，将URL的内容输出至标准输出   
-source:打印源码   

# httpd自带的工具程序
- httpd自带的工具程序    
htpasswd：basic认证基于文件实现时，用到的账号密码文件生成工具   
apachectl：httpd自带的服务控制脚本，支持start和stop   
rotatelogs：日志滚动工具   
- httpd的压力测试工具   
ab, webbench, http_load, seige   
Jmeter 开源   
Loadrunner 商业，有相关认证   
tcpcopy：网易，复制生产环境中的真实请求，并将之保存 
- ab [OPTIONS] URL    
来自httpd-tools包   
-n：总请求数   
-c：模拟的并行数   
-k：以持久连接模式测试       
ulimit –n # 调整能打开的文件数

# centos7和centos6中源码编译安装httpd-2.4
## APR
APR(Apache portable Run-time libraries，Apache可移植运行库)主要为上层的应用程序提供一个可以跨越多操作系统平台使用的底层支持接口库。也就是apache软件如果基于APR接口开发，就能满足不同操作系统的要求，可以安装在不同的操作系统上，比如linux、windows等，这样就不用每个操作系统都开发一个apache软件，只要这个软件满足ARP接口就可以。这个和ABI和API接口很类似。
ABI接口是应用程序和不同操作系统之间的底层接口，只要应用程序基于ABI接口开发，就可以在不同的操作系统上安装使用。    
API是源代码和库之间的接口，只要源代码满足API接口，就可以在支持API接口的操作系统上编译安装。
所以编译安装httpd-2.4时要安装apr才可以在linux操作系统中使用。
## centos7中源码编译安装httpd-2.4
```
1、创建apache账号
useradd -r -d /data/website1/ -s /sbin/nologin apache #-d是指定存放数据的目录，也就是web网站的主目录
如果有就不用创建了
2、安装apr
rpm -q apr    #查看一下是否安装了，并查看版本是否满足1.4以上，因为安装httpd-2.4，apr必须满足1.4以上版本，如果不满足要编译安装apr
yum install apr
3、解包和安装开发包组
tar -xvf httpd-2.4.37.tar.bz2 
yum groupinstall -y "Development Tools"                                  #安装编译工具包组
yum install -y apr-devel apr-util-devel pcre-devel openssl-devel  expat-devel #安装必要的工具包
4、执行configure脚本，并指定存放目录和启用的特性
cd /app/httpd-2.4.37/
./configure --prefix=/app/httpd24 --enable-so --enable-ssl --enable-cgi --enable-rewrite --with-zlib --with-pcre --enable-modules=most --enable-mpms-shared=all --with-mpm=prefork
#在执行的过程中会报错必须安装apr-devel、apr-util-devel、pcre-devel、openssl-devel包才可以，安装好后重新执行configure脚本
5、安装
 make -j 4 &&make install                                            #指定4线程编译
6、修改系统变量
echo 'PATH=/app/httpd24/bin:$PATH' >/etc/profile.d/http.sh        #添加系统环境变量
source ./etc/profile.d/http.sh
7、ps aux|grep "httpd"                                               #发现httpd程序的用户不是apache，可以修改一下配置文件
vim /app/httpd24/conf/httpd.conf 
User apache
Group apache
8、vim /app/httpd24/conf/httpd.conf 
DocumentRoot "/app/httpd24/htdocs"                                  #发现默认的主目录是这个
ll /app/httpd24/htdocs/ -d                                          #发现默认所有人对这个目录都有读和执行权限，这样不安全
chmod o-rx htdocs/
setfacl -m apache:rx htdocs/   #修改一下这个目录的权限，让只有apache用户才能对这个目录具有读和执行权限，因为这个程序运行的时候用户是apache，当你去访问一个页面的时候，是apache用户在访问这个目录下index.html文件
9、vim /etc/rc.d/rc.local   #此文件是系统开启时运行的最后一个脚本文件，可以把开机启动的命令放到这个文件里，这样就不用写服务脚本了，但centos7中默认这个文件时没有执行权限的，要加上执行权限才可以
/app/httpd24/bin/apachectl start    ---这样这个服务就会开机启动
chmod a+x /etc/rc.d/rc.local 
10、启动服务
apachectl start
11、创建一个虚拟主机
mkdir /data/website1
echo /data/website1 > /data/website1/index.html
vim /app/httpd24/conf/httpd.conf 
Include conf/extra/httpd-default.conf
Include conf/extra/httpd-ssl.conf     #发现主配置文件中并不是像rpm安装的时候一样Include conf.d/*.conf，而是分开写的，所以在主配置文件中也要定义一个.conf文件用于创建虚拟主机的配置文件，当然在这个主配置文件中直接创建也可以，只是将来不好管理
Include conf/extra/vhost.conf   ---在主配置文件最后增加一行
vim /app/httpd24/conf/extra/vhost.conf 
<virtualhost *:80>
documentroot "/data/website1"
servername www.1.com
<directory "/data/website1">
require all granted
</directory>
</virtualhost *:80>
12、测试访问主页
```
## 在cenots6中编译安装httpd-2.4
```
1、下载安装包，并解压缩
cd /app
tar xvf apr-1.6.2.tar.gz 
tar -xvf apr-util-1.6.0.tar.gz 
tar -xvf httpd-2.4.37.tar.bz2
2、yum groupinstall -y "development tools"
   yum install -y pcre-devel openssl-deve expat-devel
3、拷贝apr、apr-util到httpd/srclib目录
cp -av apr-1.6.2 httpd-2.4.27/srclib/apr
cp -av apr-util-1.6.0 httpd-2.4.27/srclib/apr-util
4、安装httpd
useradd -r -d /user/website1/ -s /sbin/nologin apache    #如果有就不用创建了
./configure --prefix=/usr/local/httpd24 --enable-so --enable-ssl --enable-cgi --enable-rewrite --with-zlib --with-pcre --with-included-apr --enable-modules=most --enable-mpms-shared=all --with-mpm=prefork #期间要安装pcre-devel、openssl-deve包
make -j 4 && make install
5、进入配置文件修改主目录和用户及组
vim /app/httpd24/conf   /httpd.conf
DocumentRoot "/data/website1"
</directory "/data/website1">
Require all granted
</directory>
User apache
Group apache
6、修改PATH变量
echo 'PATH=/app/httpd24/bin:$PATH' >/etc/profile.d/http.sh        #添加系统环境变量
source ./etc/profile.d/http.sh
7、创建服务脚本，可以把别的机器的拷贝过来修改一下
vim /etc/rc.d/init.d/httpd
apachectl=/app/httpd24/bin/apachectl
httpd=${HTTPD-/app/httpd24/bin/httpd}
pidfile=${PIDFILE-/app/httpd24/logs/httpd.pid}
chkconfig --add httpd
chkconfig --list httpd
8、创建网页文件，测试就可以了
Echo /data/website1 > /data/website1/index.html
```
