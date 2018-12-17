# LAMP介绍
- LAM(M)P：   
L: linux   
A: apache (httpd)   
M: mysql, mariadb   
M:memcached  
P: php, perl, python   
- WEB资源类型：    
静态资源：原始形式与响应内容一致，在客户端浏览器执行    
动态资源：原始形式通常为程序文件，需要在服务器端执行之后，将执行     
结果返回给客户端
- Web相关语言     
客户端技术： html，javascript，css，jpg   
服务器端技术：php， jsp，python，asp   
# CGI
- CGI：Common Gateway Interface
可以让一个客户端，从网页浏览器通过http服务器向执行在网络服务器上的程序传输数据；CGI描述了客户端和服务器程序之间传输的一种标准   
- 请求流程：  
Client --> (httpd) --> httpd -- (cgi) --> application server (programfile) -- (mysql) --> mysql
- php: 脚本编程语言、嵌入到html中的嵌入式web程序语言   
基于zend编译成opcode（二进制格式的字节码，重复运行，可省略编译环境）
# LAMP工作原理
![lamp](https://upload-images.jianshu.io/upload_images/6854348-ac8d2441fb9bcf3d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/966/format/webp)
# PHP简介
PHP是通用服务器端脚本编程语言，主要用于web开发实现动态web页面，也是最早实现将脚本嵌入HTML源码文档中的服务器端脚本语言之一。同时，php还提供了一个命令行接口，因此，其也可以在大多数系统上作为一个独立的shell来使用   
## PHP Zend Engine
Zend Engine的出现将PHP代码的处理过程分成了两个阶段：首先是分析PHP代码并将其转换为称作Zend opcode的二进制格式opcode(类似Java的字节码)，并将其存储于内存中；第二阶段是使用Zend Engine去执行这些转换后的Opcode
## PHP的Opcode
Opcode是一种PHP脚本编译后的中间语言，类似于Java的ByteCode,或者.NET的MSL。PHP执行PHP脚本代码一般会经过如下4个步骤(确切的来说，应该是PHP的语言引擎Zend)   
1. Scanning 词法分析,将PHP代码转换为语言片段(Tokens)   
2. Parsing 语义分析,将Tokens转换成简单而有意义的表达式   
3. Compilation 将表达式编译成Opcode  
4. Execution 顺次执行Opcode，每次一条，从而实现PHP脚本的功能  
- 扫描-->分析-->编译-->执行
## php配置
- php：脚本语言解释器   
配置文件：/etc/php.ini, /etc/php.d/*.ini   
配置文件在php解释器启动时被读取    
对配置文件的修改生效方法   
Modules模块方式：重启httpd服务   
FastCGI方式：重启php-fpm服务   
- /etc/php.ini配置文件格式：   
[foo]：Section Header    
directive = value   #选项=值  
";"：用于注释可启用的directive   
- 修改php默认主站点的网页文件    
1. 要在httpd的配置文件里修改   
`vim /etc/httpd/conf/httpd.conf`   
`DirectoryIndex index.php index.html index.html.var`
1. `rm -f /var/www/html/index.html `  
`vim /etc/httpd/conf.d/php.conf `     #修改php的配置文件   
`DirectoryIndex index.php` #启用此选项
## php代码的格式
格式1
```
此格式为html标签里面嵌入PHP程序
<h1>
<?php echo "Hello world!" ?>
</h1>
```
格式2
```
此格式为php代码中嵌入html语言
<?php
echo "<h1>Hello world!php2</h1>"
?>
```
## Php常用设置
选项 | 说明
---|---
max_execution_time= 30 | 最长执行时间30s，php程序在后台运行的最长时间，避免PHP程序长时间不用占用cpu
memory_limit 128M | 最大占用内存。 生产不够，可调大
display_errors off|展示错误信息，调试使用，不要打开，否则可能暴露重要信息，比如客户端访问网站的时候，如果服务器发生错误，可能在客户端显示暴露一些重要信息
display_startup_errors off|展示开始的启动错误信息，建议关闭
post_max_size 8M|最大上传数据大小，不管是什么格式，可能是文件也可能是二进制的一些数据等，生产可能临时要调大，比下面项要大
upload_max_filesize 2M|最大上传文件，生产可能要调大
max_file_uploads = 20|同时上传最多文件数
date.timezone =Asia/Shanghai|指定时区
short_open_tag=on|开启短标签,是一种新的php编程格式。例如<? phpinfo();?>
> php.ini的核心配置选项文档：    
http://php.net/manual/zh/ini.core.php   
php.ini配置选项列表：   
http://php.net/manual/zh/ini.list.php
# LAMP工作模式
- apache主要实现如下功能：
1. 处理http的请求、构建响应报文等自身服务；
1. 配置让Apache支持PHP程序的响应（通过PHP模块或FPM）；
1. 配置Apache具体处理php程序的方法，如通过反向代理将php程序交给fcgi处理。
- mariadb主要实现如下功能：
1. 提供PHP程序对数据的存储；
1. 提供PHP程序对数据的读取(通常情况下从性能的角度考虑，尽量实现数据库的读写分离)。
- php主要实现如下功能：
1. 提供apache的访问接口，即CGI或Fast CGI(FPM);
1. 提供PHP程序的解释器；
1. 提供mairadb数据库的连接函数的基本环境。   
> 要实现LAMP在配置每一个服务时，安装功能需求进行配置，即可实现LAMP的架构，当然apache、mariadb和php服务都可配置为独立服务，安装在不同服务器上。
## LAMP中PHP工作模式
1. **PHP模块化工作模式**   
PHP模块化工作方式，可以理解为将PHP封装为HTTPD中的一个函数，既然是HTTPD的一个函数，则PHP必须封装HTTPD中，因此PHP必须与HTTPD配置在同一台服务器中，而且不会作物独立的程序或进程运行
![lamp](https://s2.51cto.com/wyfs02/M02/08/89/wKiom1nkBsKQgT4fAAKxHXLMA_U550.jpg)  
> 安装PHP的rpm包后，生成httpd的模块目录下生成libphp5.so的模块，因此httpd在启动时可以自动加载此模块，从而提供CGI接口和PHP解释的功能
2. **PHP的FPM工作模式**   
在大型集群环境中，通过模块化管理从性能的角度比较不如独立的进程进行处理效率高，因此一旦访问量较大时，建议PHP的CGI接口和PHP解释器独立运行，独立作为一个单独的进程进行处理动态程序
![lamp](https://s5.51cto.com/wyfs02/M01/08/8C/wKiom1nkHn3wPZxbAAK5M6MgQEk293.jpg)  
> PHP在独立运行的配置方法为：编译初期开启PHP的CGI接口、PHP的解释功能和数据库连接功能模块，在编译完成之后再次调整HTTPD和PHP的方式
# YUM方式部署LAMP
- CentOS 7:    
Modules：httpd, php, php-mysql, mariadb-server  
FastCGI：httpd, php-fpm, php-mysql, mariadb-server
- CentOS 6：   
Modules:httpd, php, php-mysql, mysql-server  
FastCGI:默认不支持
> Modules模块方式加载和FastCGI方式需要安装的依赖包

## CentOS 6
yum install httpd  php  mysql-server  php-mysql   
service httpd start   
service mysqld start   
## CentOS 7
yum install httpd  php php-mysql mariadb-server   
systemctl start httpd.service   
systemctl start mariadb.service  
> 注意：要使用prefork模型

### Php使用mysql扩展连接数据库
```
使用mysql扩展连接数据库的测试代码
<?php
 $conn = mysql_connect('mysqlserver','username','password');
 if ($conn)
echo "OK";
 else
echo "Failure";
#echo mysql_error();
 mysql_close();
 ?>
```
### Php使用PDO(PHP Data Object)扩展连接数据库
```
使用pdo扩展连接数据库的测试代码1
<?php
$dsn='mysql:host=mysqlhost;dbname=test';
$username=‘root';
$passwd=‘magedu';
$dbh=new PDO($dsn,$username,$passwd);
var_dump($dbh);
?>
```
```
使用pdo扩展连接数据库的测试代码2
<?php
try {
$user='sqluser';
$pass='linux';
$dbh = new PDO('mysql:host=192.168.34.8;dbname=mysql', $user, $pass);
foreach($dbh->query('SELECT user,host from user') as $row) {
print_r($row);
}
$dbh = null;
} catch (PDOException $e) {
print "Error!: " . $e->getMessage() . "<br/>";
die();
}
?>
```
# 常见LAMP应用
- PhpMyAdmin是一个以PHP为基础，以Web-Base方式架构在网站主机上的MySQL的数据库管理工具，让管理者可用Web接口管理MySQL数据库
- WordPress是一种使用PHP语言开发的博客平台，用户可以在支持PHP和MySQL数据库的服务器上架设属于自己的网站。也可把 WordPress当作一个内容管理系统（CMS）来使用
- Crossday Discuz! Board（简称 Discuz!）是一套通用的社区论坛软件系统。
## 布署phpMyadmin来管理mysql数据库
### centos7部署phpMyadmin
```
1、安装各种，并启动服务
yum install -y httpd php  php-mysql mariadb-server php-mbstring
systemctl start httpd 
systemctl start mariadb 
mysql_secure_installation                       #初始化mysql，设置用户和密码等
2、下载phpmyadmin源码并解压缩
下载：https://www.phpmyadmin.net/downloads/     # 注意下载的版本
cd /var/www/html/                               #注意一定要在httpd服务的主目录下解压缩
tar xf phpMyAdmin-4.8.4-all-languages.tar.xz 
3、创建软连接
ln -s phpMyAdmin-4.8.4-all-languages/ pma       #创建一个软连接，便于客户端访问时输入太长的目录名
4、创建phpmyadmin的配置文件
cd  /var/www/html/pma
cp config.sample.inc.php config.inc.php         #把一个例子复制一下
vim config.inc.php                              #修改一下这个例子制作成配置文件
$cfg['blowfish_secret'] = 'a8b7c6ddddsaadasfdfsfsf'; /* YOU MUST FILL IN THIS FOR COOKIE AUTH! */  #注意单用号里面要填充，默认是填充的，如果没有要填充，填充什么都可以
5、测试
service httpd reload 
http://192.168.74.128/pma，然后输入初始化mysql过程中设置的用户名和密码就可以登录到网站，用web页面点鼠标的方式来管理mysql数据库了，我们可以创建一个wpdb数据库和一个wpadmin@'192.168.34.%'的用户并授权，然后在字符界面登录去验证一下网页方式管理mysql数据库是否可行。
mysql -uwpadmin -p'123456' -h192.168.34.8       #我们发现可以登录上，说明用web方式管理mysql数据库是成功的
```
### 布署wordpress搭建属于自己的博客
#### centos7部署
```
1、环境准备
准备两台主机a和b
在a上操作
yum install httpd php php-mysql
systemctl start httpd
在b上操作
yum install mariadb-server
systemctl start mariadb
2、在b上创建数据库及用户
mysql> create database wpdb;
mysql> grant all on wpdb.* to wpadmin@'192.168.34.%' indentified by '123456'
3、下载wordpress软件
https://cn.wordpress.org/
在a上操作
cd /app
tar xvf wordpress-4.8.1-zh_CN.tar.gz -C /var/www/html/        #解压到httpd根目录
cd /var/www/html/
ln -s wordpress/ blog                                         #创建一个
4、修改WordPress配置文件
cd /var/www/html/blog/
cp wp-config-sample.php wp-config.php                         #利用模板创建
vim wp-config.php
/** WordPress数据库的名称 */
define('DB_NAME', 'wpdb');
/** MySQL数据库用户名 */
define('DB_USER', 'wpuser');
/** MySQL数据库密码 */
define('DB_PASSWORD', 'linux');
/** MySQL主机 */
define('DB_HOST', '192.168.34.8');
5、打开http://192.168.34.9/blog/进行页面安装，安装完毕后登陆就可以发现自己创建的博客了
```
# php-fpm
- httpd+php结合的方式：   
module: php    
fastcgi : php-fpm   
- php-fpm：    
**CentOS 6**：    
PHP-5.3.2之前：默认不支持fpm机制；需要自行打补丁并编译安装   
httpd-2.2：默认不支持fcgi协议，需要自行编译此模块    
解决方案：编译安装httpd-2.4, php-5.3.3+   
**CentOS 7**：    
httpd-2.4：rpm包默认编译支持fcgi模块      
php-fpm包：专用于将php运行于fpm模式   
## 配置fastcgi
fcgi服务配置文件：/etc/php-fpm.conf, /etc/php-fpm.d/*.conf
### Centos7 yum实现fastcgi+http
```
yum remove php                 #删除原有的以模块方式的php，因为两者不能共存
yum install php-fpm            #安装独立方式运行的php软件包
rpm -ql php-fpm                #查看一下这个软件包生成的文件列表
vim  /etc/php-fpm.d/www.conf   #修改php-fpm的配置文件
listen = 9000                  #只写端口号就表示监听本机的所有IP
listen.allowed_clients = 127.0.0.1  #如果httpd服务和php-fpm在同一台主机就不用改了，一般情况下这两个服务都是在一台主机的，只允许本机访问就可以了
systemctl start php-fpm        #启动php-fpm服务
vim /etc/httpd/conf.d/fpm.conf   #创建一个httpd的配置文件，使它和php-fpm配合使用
DirectoryIndex index.php       #指明httpd服务主目录的动态页面的文件
ProxyRequests Off              #关闭代理请求
ProxyPassMatch ^/(.*\.php)$ fcgi://127.0.0.1:9000/var/www/html/$1   #表示匹配以.php结尾的文件就通过fcgi也就是php-fpm的本机的9000端口去处理，处理的目录是根目录下的匹配的.php结尾的文件，$1代替的就是前面匹配的以.php结尾的文件
systemctl restart httpd 
注意：在HTTPD服务器上必须启用proxy_fcgi_module模块，充当PHP客户端，可以通过如下命令查看模块是否启用
httpd –M |grep fcgi            #发现模块已经启用

测试
vim /var/www/html/index.php 
<?php
phpinfo();
?>
http://192.168.34.8/           #看到是rpm安装的php-fpm的版本
```
### fastcgi虚拟主机配置
```
vim /etc/httpd/conf.d/vhost.conf 
<virtualhost *:80>
servername www.a.com
documentroot /app/website
<directory /app/website>
require all granted
</directory>
directoryIndex index.php      #对当前网站启用fastcgi支持                        
ProxyRequests Off
ProxyPassMatch ^/(.*\.php)$ fcgi://127.0.0.1:9000/app/website/$1
</virtualhost>
mkdir /app/website
创建测试用PHP
vim /app/website/index.php 
<?php
$mysqli=new mysqli("192.168.34.8","wpuser","123456");
if(mysqli_connect_errno()){
echo "连接数据库失败!";
$mysqli=null;
exit;
}
echo "连接数据库成功!";
$mysqli->close();
phpinfo();
?>

在34.9上测试，修改/etc/hosts文件，使其能解析www.a.com，在图形界面下用火狐浏览器访问www.a.com，可以发现连接成功。
```
## CentOS7编译安装LAMP
```
软件环境：
apr-1.6.5.tar.gz       httpd-2.4.37.tar.bz2                php-7.3.0.tar.xz
apr-util-1.6.1.tar.gz  mariadb-10.3.11-linux-systemd-x86_64  wordpress-5.0.1-zh_CN.tar.gz

1 源码编译安装Httpd2.4
yum groupinstall "development tools"
yum install openssl-devel expat-devel pcre-devel
#准备apr与http
mkdir /data/src
tar xvf apr-1.6.2.tar.gz 
tar xvf apr-util-1.6.0.tar.gz 
tar xvf httpd-2.4.27.tar.bz2 
cp -a apr-1.6.2 httpd-2.4.27/srclib/apr
cp -a apr-util-1.6.0 httpd-2.4.27/srclib/apr-util
cd httpd-2.4.27/
./configure --prefix=/app/httpd24 --sysconfdir=/etc/httpd24 --enable-so --enable-ssl --enable-rewrite --with-zlib --with-pcre --with-included-apr --enable-modules=most --enable-mpms-shared=all --with-mpm=prefork
make && make install
#准备PATH路径
echo 'PATH=/app/httpd24/bin/:$PATH' > /etc/profile.d/lamp.sh
source /etc/profile.d/lamp.sh
#修改配置文件，修改运行用户和组
vim httpd.conf
User apache
Group apache
apachectl start
ss -tnl

2 二进制安装mariadb 
tar xvf mariadb-10.3.11-linux-systemd-x86_64  -C /usr/local/
cd /usr/local
ln -s mariadb-10.3.11-linux-systemd-x86_64/ mysql
useradd -r -d /data/mysql -s /sbin/nologin mysql 
cd mysql/
准备mysql文件夹
mkdir /data/mysql
chown mysql.mysql /data/mysql
cd /usr/local/mysql
scripts/mysql_install_db --datadir=/data/mysql --user=mysql  #生成mysql的初始数据库和相应的表
准备mysql配置文件
mkdir /etc/mysql
cp support-files/my-large.cnf   /etc/mysql/my.cnf   #创建mysql的配置文件(10.3无此文件)
vim /etc/mysql/my.cnf
[mysqld]
datadir = /data/mysql
innodb_file_per_table = ON
skip_name_resolve = ON
socket=/data/mysql/mysql.sock
[client]
port      = 3306
socket    = /data/mysql/mysql.sock
准备启动脚本
centos7方式：
cp /usr/local/mariadb-10.3.11-linux-systemd-x86_64/support-files/systemd/mariadb.service /usr/lib/systemd/system/
systemctl start mariadb
centos6方式：
cp support-files/mysql.server /etc/init.d/mysqld    #创建一个服务脚本
chkconfig --add mysqld
chkconfig --list 
service mysqld start
创建日志文件
mkdir /var/log/mariadb   #创建一个日志目录，并修改所有者或者权限，不然服务无法启动，会报错，也就是服务启动的时候会写日志
chown mysql /var/log/mariadb/
service mysqld start
修改本机PATH路径
vim /etc/profile.d/lamp.sh 
PATH=/app/httpd24/bin/:/usr/local/mysql/bin/:$PATH
. /etc/profile.d/lamp.sh
mysql_secure_installation
mysql -uroot -pclinux
为WordPress创建数据库
create datebase wpdb;
grant all on wpdb.* to wpuser@'192.168.34.%' identified by 'linux';
grant all on wpdb.* to wpuser@'127.%' identified by 'linux';
grant all on wpdb.* to wpuser@'localhost' identified by 'linux';
#如果数据库和php在同一台主机要授权本机的localhost和127.%，不然本机都无法访问后面的wpdb数据库

3 源码编译安装php
yum install libxml2-devel bzip2-devel libmcrypt-devel 
tar xvf php-7.1.10.tar.xz 
cd php-7.1.10/
./configure --prefix=/app/php \
--enable-mysqlnd \
--with-mysqli=mysqlnd \
--with-openssl \
--with-pdo-mysql=mysqlnd \
--enable-mbstring \
--with-freetype-dir \
--with-jpeg-dir \
--with-png-dir \
--with-zlib \
--with-libxml-dir=/usr \
--enable-xml \
--enable-sockets \
--enable-fpm \
--with-config-file-path=/etc \
--with-config-file-scan-dir=/etc/php.d \
--enable-maintainer-zts \
--disable-fileinfo
make && make install
#创建一个php的配置文件，可以从模板复制，这个文件不需要修改什么，如果需要可以修改一下时区
cp php.ini-production /etc/php.ini  
#修改httpd的配置文件
vim /etc/httpd24/httpd.conf   
#在文件尾部加两行
AddType application/x-httpd-php .php
AddType application/x-httpd-php-source .phps
ProxyRequests Off
ProxyPassMatch ^/(.*\.php)$ fcgi://127.0.0.1:9000/app/httpd24/htdocs/$1   #利用本机9000端口运行fastcgi
#修改配置文件中的主目录的php网页文件
<IfModule dir_module>
    DirectoryIndex index.php index.html
</IfModule>
#取消下面两行的注释
LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so
apachectl stop
apachectl start
#创建FPM启动文件
cp sapi/fpm/init.d.php-fpm /etc/init.d/php.fpm
chmod +x /etc/init.d/php.fpm
chkconfig --add  php.fpm
chkconfig php.fpm on
cd /app/php/etc
cp php-fpm.conf.default php-fpm.conf
cp php-fpm.d/www.conf.default php-fpm.d/www.conf
service php-fpm start

4 测试php和mariadb连接
vim /app/httpd24/htdocs/index.php 
<html><body><h1> LAMP</h1></body></html>
<?php
$mysqli=new mysqli("192.168.34.10","root","linux");
if(mysqli_connect_errno()){
echo "连接数据库失败!";
$mysqli=null;
exit;
}
echo "连接数据库成功!";
$mysqli->close();
phpinfo();
?>
5 配置wordpress
tar xvf wordpress-5.0.1-zh_CN.tar.gz  -C /app/httpd24/htdocs  #把wordpress解压到httpd网站的主目录下
cd /app/httpd24/htdocs
ln -s wordpress/ blog/
cd /app/httpd24/htdocs/blog/
cp wp-config-sample.php  wp-config.php
vim wp-config.php
define('DB_NAME', 'wpdb');
/** MySQL数据库用户名 */
define('DB_USER', 'wpuser');
/** MySQL数据库密码 */
define('DB_PASSWORD', 'linux');
/** MySQL主机 */
define('DB_HOST', '192.168.34.10');
6 登录测试
http://192.168.34.8/blog/ 
```
> 实现unix sock方式连接fcgi   
vim /app/httpd24/conf/httpd.conf    
ProxyPassMatch ^/(.*\.php)$  unix://var/run/fpm.sock|fcgi://127.0.0.1/app/httpd24/htdocs/   
vim /app/php/etc/php-fpm.d/www.conf   
listen = /var/run/fpm.sock   
listen.mode = 0666   


## centos6实现基于源码编译安装LAMP(PHP-FPM方式)
```
软件版本：
apr-1.6.2.tar.gz       httpd-2.4.27.tar.bz2                php-5.6.31.tar.xz             xcache-3.2.0.tar.bz2
apr-util-1.6.0.tar.gz  mariadb-5.5.57-linux-x86_64.tar.gz  wordpress-4.8.1-zh_CN.tar.gz
1、 编译httpd2.4
yum groupinstall "development tools"
yum install openssl-devel pcre-devel expat-devel
tar xvf apr-1.6.2.tar.gz 
tar xvf apr-util-1.6.0.tar.gz 
tar xvf httpd-2.4.27.tar.bz2 
cp -a apr-1.6.2 httpd-2.4.27/srclib/apr
cp -a apr-util-1.6.0 httpd-2.4.27/srclib/apr-util
cd httpd-2.4.27/
./configure --prefix=/app/httpd24 --enable-so --enable-ssl --enable-rewrite --with-zlib --with-pcre --with-included-apr --enable-modules=most --enable-mpms-shared=all --with-mpm=prefork
make  && make install
vim /etc/profile.d/lamp.sh
PATH=/app/httpd24/bin/:$PATH
. /etc/profile.d/lamp.sh
cp  /etc/init.d/httpd  /etc/init.d/httpd24
vim /etc/init.d/httpd24
apachectl=/app/httpd24/bin/apachectl
httpd=${HTTPD-/app/httpd24/bin/httpd}
prog=httpd
pidfile=${PIDFILE-/app/httpd24/logs/httpd.pid}
lockfile=${LOCKFILE-/var/lock/subsys/httpd24}
chkconfig --add httpd24
chkconfig --list httpd24
service httpd24 start
2 、二进制安装mariadb
tar xvf mariadb-5.5.57-linux-x86_64.tar.gz  -C /usr/local/
cd /usr/local/
ln -s mariadb-5.5.57-linux-x86_64/ mysql
useradd -r -d /app/mysqldb -s /sbin/nologin mysql 
cd mysql/
scripts/mysql_install_db --datadir=/app/mysqldb --user=mysql
mkdir /etc/mysql
cp support-files/my-large.cnf   /etc/mysql/my.cnf
vim /etc/mysql/my.cnf
[mysqld]
datadir = /app/mysqldb
innodb_file_per_table = ON
skip_name_resolve = ON
cp support-files/mysql.server /etc/init.d/mysqld
chkconfig --add mysqld
chkconfig --list 
service mysqld start
touch /var/log/mysqld.log
chown mysql /var/log/mysqld.log
service mysqld start
vi /etc/profile.d/lamp.sh 
PATH=/app/httpd24/bin/:/usr/local/mysql/bin/:$PATH
. /etc/profile.d/lamp.sh
mysql_secure_installation
mysql -uroot -pcentos
create datebase wpdb;
grant all on wpdb.* to wpuser@'192.168.34.%' identified by 'centos';
grant all on wpdb.* to wpuser@'127.%' identified by 'centos';
grant all on wpdb.* to wpuser@'localhost' identified by 'centos';
3、 源码编译php
yum install libxml2-devel bzip2-devel libmcrypt-devel
tar xvf php-5.6.31.tar.xz 
cd php-5.6.31
./configure \
--prefix=/app/php5 \
--with-mysql=/usr/local/mysql \
--with-openssl \
--with-mysqli=/usr/local/mysql/bin/mysql_config \
--enable-mbstring \
--with-freetype-dir  \
--with-jpeg-dir \
--with-png-dir \
--with-zlib \
--with-libxml-dir=/usr \
--enable-xml \
--enable-sockets \
--enable-fpm \   #指定是fpm模式安装php
--with-mcrypt \
--with-config-file-path=/etc/php5 \
--with-config-file-scan-dir=/etc/php5.d \
--with-bz2
make && make install
vi /etc/profile.d/lamp.sh 
PATH=/app/php5/bin:/app/httpd24/bin/:/usr/local/mysql/bin/:$PATH
.  /etc/profile.d/lamp.sh 
mkdir /etc/php5/
cp /app/php-5.6.31/php.ini-production /etc/php5/php.ini  #创建php的配置文件，规定时区
cp   /app/php-5.6.31/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm   #创建php-fpm的服务脚本
chmod +x /etc/init.d/php-fpm
chkconfig --add php-fpm
chkconfig --list  php-fpm
service php-fpm start
cd /app/php5/etc
cp php-fpm.conf.default php-fpm.conf  #创建php-fpm的配置文件，里面规定了端口号等
vim app/httpd24/conf/httpd.conf
取消两行的注释
LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so
在文件尾部加四行
AddType application/x-httpd-php .php
AddType application/x-httpd-php-source .phps
ProxyRequests Off 关闭代理
ProxyPassMatch  ^/(.*\.php)$ fcgi://127.0.0.1:9000/app/httpd24/htdocs/$1
修改下面行
<IfModule dir_module>
    DirectoryIndex index.php index.html
</IfModule>
service httpd24 restart
4 测试
vim /app/httpd24/htdocs/index.php
<html><body><h1>It works!</h1></body></html>
<?php
$mysqli=new mysqli("localhost","root","centos");
if(mysqli_connect_errno()){
echo "连接数据库失败!";
$mysqli=null;
exit;
}
echo "连接数据库成功!";
$mysqli->close();
phpinfo();
?>
5 、编译xcache 实现Php加速
tar xvf xcache-3.2.0.tar.bz2 
cd xcache-3.2.0
phpize 
./configure  --enable-xcache --with-php-config=/app/php5/bin/php-config 
make && make install
mkdir /etc/php5.d/
cp /app/xcache-3.2.0/xcache.ini  /etc/php5.d/  #创建php对于xcache的配置文件
vim /etc/php5.d/xcache.ini                     #xcache做为php的一个模块，在php的配置文件中规定了模块的路径
extension = /app/php5/lib/php/extensions/no-debug-non-zts-20131226/xcache.so
service php-fpm restart
```
