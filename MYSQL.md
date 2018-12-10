# 数据库的发展史
- 萌芽阶段：文件系统
使用磁盘文件来存储数据
- 初级阶段：第一代数据库
出现了网状模型、层次模型的数据库
- 中级阶段：第二代数据库
关系型数据库和结构化查询语言
- 高级阶段：新一代数据库
“关系-对象”型数据库

# 数据库系统的架构
单机架构  
大型主机/终端架构  
主从式架构（C/S）  
分布式架构  

# 关系型数据库
- 关系 ：关系就是二维表，其中：表中的行、列次序并不重要
- 行row：表中的每一行，又称为一条记录
- 列column：表中的每一列，称为属性，字段
- 主键（Primary key）：用于惟一确定**一个记录**的字段（每张表只有一个主键）
- 域domain：属性的取值范围，如，性别只能是‘男’和‘女’两个值
> 一张表只有一个主键，主键可以关联到多个字段（多字段组合必须唯一），称为复合主键

#### RDBMS：  
MySQL: MySQL, MariaDB, Percona Server  
PostgreSQL: 简称为pgsql，EnterpriseDB  
Oracle  
MSSQL  
DB2  
> 数据库排名：
https://db-engines.com/en/ranking

# 实体-联系模型E-R
- 实体Entity：客观存在并可以相互区分的客观事物或抽象事件称为实体
• 在E-R图中用矩形框表示实体，把实体名写在框内   
- 属性：实体所具有的特征或性质  
- 联系：联系是数据之间的关联集合，是客观存在的应用语义链  
• 实体内部的联系：指组成实体的各属性之间的联系。如职工实体中，职工号和部门经理号之间有一种关联关系  
• 实体之间的联系：指不同实体之间联系。例：学生选课实体和学生基本信息实体之间   
• 实体之间的联系用菱形框表示  

# 联系类型
- 联系的类型  
一对一联系(1:1)  
一对多联系(1:n)  #外键依赖主键表的主键  
多对多联系(m:n)  #构建一张表整合前面所有表的关键字段
- 数据的操作：  
数据提取：在数据集合中提取感兴趣的内容。SELECT  
数据更新：变更数据库中的数据。INSERT、DELETE、UPDATE  
- 数据的约束条件 ：是一组完整性规则的集合  
实体（行）完整性 Entity integrity  #每条记录都唯一 增加主键  
域（列）完整性 Domain Integrity  #限定字段属性  
参考完整性 Referential Integrity  #各个表关系  主外键  

# 简易数据规划流程
- 第一阶段：收集数据，得到字段  
• 收集必要且完整的数据项  
• 转换成数据表的字段  
- 第二阶段：把字段分类，归入表，建立表的关联  
• 关联：表和表间的关系  
• 分割数据表并建立关联的优点  
• 节省空间  
• 减少输入错误  
• 方便数据修改  
- 第三阶段：  
• 规范化数据库  #减少冗余

# SQL概念
- SQL: Structure Query Language  
结构化查询语言  
SQL解释器：  
数据存储协议：应用层协议，C/S  
- S：server, 监听于socket套接字，接收并处理客户端的应用请求  
- C：Client  
客户端程序接口  
CLI  
GUI  
应用编程接口  
ODBC：Open Database Connectivity  
JDBC：Java Data Base Connectivity  

## 约束
约束：constraint，表中的数据要遵守的限制  
- 主键(primary key)：一个或多个字段的组合，填入的数据必须能在本表中唯一标识本行；**必须提供数据，即NOT NULL**，**一个表只能有一个**
- 惟一键(uniq key)：一个或多个字段的组合，**填入的数据必须能在本表中唯一标识本行**；**允许为NULL，**一个表可以存在多个****  
- 外键(foreign key)：一个表中的某字段可填入的数据取决于另一个表的主键或唯一键已有的数据
- 检查：字段值在一定范围内

## 基本概念
- 索引：将表中的一个或多个字段中的数据复制一份另存，并且按特定次序排序存储
- 关系运算：  
选择：挑选出符合条件的行  
投影：挑选出需要的字段  
连接：表间字段的关联  
> 适用于大量数据，按某种规定排列

## 数据模型
- 数据抽象：  
物理层：数据存储格式，即RDBMS在磁盘上如何组织文件  
逻辑层：DBA角度，描述存储什么数据，以及数据间存在什么样的关系   
视图层：用户角度，描述DB中的部分数据  
- 关系模型的分类：  
关系模型  
基于对象的关系模型  
半结构化的关系模型：XML数据（扩展的标记语言）  

# MySQL历史
1979年：TcX公司 Monty Widenius，Unireg  
1996年：发布MySQL1.0，Solaris版本，Linux版本  
1999年：MySQL AB公司，瑞典  
2003年：MySQL 5.0版本，提供视图、存储过程等功能  
2008年：Sun 收购  
2009年：Oracle收购sun  
2009年：Monty成立MariaDB  

## MYSQL的特性
- **插件式存储引擎**：也称为“表类型”，存储管理器有多种实现版本，功能和特性可能均略有差别；用户可根据需要灵活选择,Mysql5.5.5开始innoDB引擎是MYSQL默认引擎  
MyISAM ==> Aria  
InnoDB ==> XtraDB  
- 单进程，多线程
- 诸多扩展和新特性
- 提供了较多测试组件
- 开源

官方文档  
https://dev.mysql.com/doc/  
https://mariadb.com/kb/en/  
https://www.percona.com/software/mysql-database/percona-server 

## 安装MYSQL
Mariadb安装方式：
1. 源代码：编译安装  
2. 二进制格式的程序包：展开至特定路径，并经过简单配置后即可使用  
3. 程序包管理器管理的程序包  
CentOS 安装光盘  
项目官方：https://downloads.mariadb.org/mariadb/repositories/  
国内镜像：https://mirrors.tuna.tsinghua.edu.cn/mariadb/mariadbx.y.z/yum/centos/7/x86_64/  

> 提高安全性:  
m**ysql_secure_installation**（运行此脚本提高安全性）  
设置数据库管理员root口令  
禁止root远程登录  
删除anonymous用户帐号  
删除test数据库  

## MariaDB程序
- 客户端程序：  
**mysql**: 交互式的CLI工具  
**mysqldump**：备份工具，基于mysql协议向mysqld发起查询请求，并将查得的所有数据转换成insert等写操作语句保存文本文件中  
**mysqladmin**：基于mysql协议管理mysqld  
mysqlimport：数据导入工具  
- MyISAM存储引擎的管理工具：  
myisamchk：检查MyISAM库  
myisampack：打包MyISAM表，只读  
- 服务器端程序  
mysqld_safe  
mysqld  
mysqld_multi 多实例 ，示例：mysqld_multi --example  #配合不同端口号

## 用户账号
mysql用户账号由两部分组成：  
'USERNAME'@'HOST'  
说明：  
HOST限制此用户可通过哪些远程主机连接mysql服务器  
支持使用通配符：  
% 匹配任意长度的任意字符  
172.16.0.0/255.255.0.0 或 172.16.%.%  
_ 匹配任意单个字符  

## Mysql 客户端
- mysql使用模式：
交互式模式： 
可运行命令有两类： 
客户端命令：  
\h, help  
\u，use  
\s，status  
\\!，system
- 服务器端命令：  
SQL语句， **需要语句结束符**;  
- 脚本模式： #使用脚本文件重定向到mysql命令中执行  
mysql –uUSERNAME -pPASSWORD < /path/somefile.sql  
mysql> source /path/from/somefile.sql  
mysql -e 'show database' #单独执行一次命令

### 常用选项
mysql客户端可用选项：

选项 | 说明
---|---
-A, --no-auto-rehash | 禁止补全
-u, --user= | 用户名,默认为root
-h, --host=| 服务器主机,默认为localhost
-p, --passowrd=| 用户密码,建议使用-p,默认为空密码
-P, --port=|服务器端口
-S, --socket=|指定连接socket文件路径
-D, --database=|指定默认数据库
-C, --compress|启用压缩
-e "SQL"|执行SQL命令
-V, --version|显示详细信息
--print-defaults|获取程序默认使用的配置

> mysql5.5之后的版本开始使用innodb作为默认引擎   

可以考虑修改配置文件修改mysql提示符以区分生成和测试环境，避免出现误操作  
centos6:/etc/my.cnf    
centos7:/etc/my.cnf.d/mysql-clients.cnf  
```
[mysql]   
prompt=\u@[\D]test-->  
```  

select user(); #显示当前用户  
select version(); #显示当前版本  
带括号的字符是mysql的函数字符  

mysql 主机+用户名可以控制登录用户  

## socket地址
服务器监听的两种socket地址：  
ip socket: 监听在tcp的3306端口，支持远程通信  
unix sock: 监听在sock文件上，仅支持本机通信  
如：/var/lib/mysql/mysql.sock)
说明：host为localhost,127.0.0.1时自动使用unix sock

## 执行命令
运行mysql命令：默认空密码登录
mysql>use mysql
mysql>select user();查看当前用户
mysql>SELECT User,Host,Password FROM user;
登录系统：mysql –uroot –p
客户端命令：本地执行
mysql> help
每个命令都完整形式和简写格式
mysql> status 或 \s
服务端命令：通过mysql协议发往服务器执行并取回结果
每个命令末尾都必须使用命令结束符号，默认为分号
示例：SELECT VERSION();

## 服务器端配置
服务器端(mysqld)：工作特性有多种配置方式  
1、命令行选项：  
2、配置文件：类ini格式  
集中式的配置，能够为mysql的各应用程序提供配置信息  
[mysqld]  #mysql命令的选项  
[mysqld_safe]    
[mysqld_multi]  
[mysql]  
[mysqldump]  #备份选项  
[server]  #服务端选项  
[client]  #客户端选项  
格式：parameter = value  
说明：_和- 相同  
1，ON，TRUE意义相同， 0，OFF，FALSE意义相同  

## 配置文件
配置文件：  
**后面覆盖前面**的配置文件，顺序如下：#指定路径优先级高于配置文件  
/etc/my.cnf Global选项  
/etc/mysql/my.cnf Global选项  
SYSCONFDIR/my.cnf Global选项  
$MYSQL_HOME/my.cnf Server-specific 选项  
--defaults-extra-file=path   
~/.my.cnf User-specific 选项   

## MairaDB配置
侦听3306/tcp端口可以在绑定有一个或全部接口IP上  
vim /etc/my.cnf   
[mysqld]  
skip-networking=1  #禁用网络连接，可在维护时添加      
关闭网络连接，只侦听本地客户端，所有和服务器的交互都通过一个socket实现，socket的配置存放在/var/lib/mysql/mysql.sock）可在/etc/my.cnf修改

# 通用二进制格式安装过程
二进制格式安装过程  
1. 准备用户  
groupadd -r -g 306 mysql  
useradd -r -g 306 -u 306 –d /data/mysql mysql  
1. 准备数据目录，建议使用**逻辑卷**  
mkdir /data/mysql  
chown mysql:mysql /data/mysql  
1. 准备二进制程序  
tar xf mariadb-VERSION-linux-x86_64.tar.gz -C /usr/local  
cd /usr/local  
ln -sv mariadb-VERSION mysql  
chown -R root:mysql /usr/local/mysql/   
1. 准备配置文件  
mkdir /etc/mysql/  
cp support-files/my-large.cnf /etc/mysql/my.cnf  
[mysqld]中添加三个选项：  
datadir = /data/mysql  
**innodb_file_per_table** = on  #新版本可不加，已默认启用  
**skip_name_resolve** = on 禁止主机名解析，建议使用  
1. 创建数据库文件  
cd /usr/local/mysql/  
./scripts/mysql_install_db --datadir=/data/mysql --user=mysql --basedir=/usr/local/nysql
1. 准备服务脚本，并启动服务  
 cp ./support-files/mysql.server /etc/rc.d/init.d/mysqld  
 chkconfig --add mysqld  
 service mysqld start  
1. PATH路径  
echo 'PATH=/user/local/mysql/bin:$PATH' > **/etc/profile.d**/mysql  
1. 安全初始化  
/user/local/mysql/bin/mysql_secure_installation   

# 源码编译安装mariadb
1. 安装包  
`yum install bison bison-devel zlib-devel libcurl-devel libarchive-devel boostdevel gcc gcc-c++ cmake ncurses-devel gnutls-devel libxml2-devel openssldevel libevent-devel libaio-devel`
2. 做准备用户和数据目录  
`useradd –r –s /sbin/nologin –d /data/mysql/ mysql`  
`mkdir /data/mysql`  
`chown mysql.mysql /data/mysql`  
`tar xvf mariadb-10.2.18.tar.gz`  
3. cmake 编译安装  
cmake的重要特性之一是其独立于源码(out-of-source)的编译功能，即编译工作可以在
另一个指定的目录中而非源码目录中进行，这可以保证源码目录不受任何一次编译的影
响，因此在同一个源码树上可以进行多次不同的编译，如针对于不同平台编译  
编译选项:https://dev.mysql.com/doc/refman/5.7/en/source-configuration-options.html
- cd mariadb-10.2.18/  
cmake . \\  #\\长命令换行  
-DCMAKE_INSTALL_PREFIX=/app/mysql \\  
-DMYSQL_DATADIR=/data/mysql/ \\  
-DSYSCONFDIR=/etc \\  
-DMYSQL_USER=mysql \\  
-DWITH_INNOBASE_STORAGE_ENGINE=1 \\  
-DWITH_ARCHIVE_STORAGE_ENGINE=1 \\  
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \\  
-DWITH_PARTITION_STORAGE_ENGINE=1 \\  
-DWITHOUT_MROONGA_STORAGE_ENGINE=1 \\  
-DWITH_DEBUG=0 \\  
-DWITH_READLINE=1 \\  
-DWITH_SSL=system \\  
-DWITH_ZLIB=system \\  
-DWITH_LIBWRAP=0 \\  
-DENABLED_LOCAL_INFILE=1 \\  
-DMYSQL_UNIX_ADDR=/data/mysql/mysql.sock \\  
-DDEFAULT_CHARSET=utf8 \\  
-DDEFAULT_COLLATION=utf8_general_ci
make && make install
> 提示：如果出错，执行rm -f CMakeCache.txt
4. 准备环境变量  
`echo 'PATH=/app/mysql/bin:$PATH' > /etc/profile.d/mysql.sh`  
`. /etc/profile.d/mysql.sh`  
5. 生成数据库文件  
`cd /app/mysql/`  
`scripts/mysql_install_db --datadir=/data/mysql/ --user=mysql`  
6. 准备配置文件  
`cp /app/mysql/support-files/my-huge.cnf /etc/my.cnf`  
7. 准备启动脚本  
`cp /app/mysql/support-files/mysql.server /etc/init.d/mysqld`  
8. 启动服务  
`chkconfig --add mysqld ;service mysqld start`  

# 关系型数据库的常见组件
- **数据库**：database
- **表**：table   
行：row  
列：column
- **索引**：index
- **视图**：view
- 用户：user
- 权限：privilege
- 存储过程：procedure
- 存储函数：function
- 触发器：trigger
- 事件调度器：event scheduler，任务计划

# SQL语言规范
- 在数据库系统中，SQL语句不区分大小写(建议用大写)  
- **SQL语句可单行或多行书写**，以“;”结尾  
- 关键词不能跨多行或简写  
- 用空格和缩进来提高语句的可读性  
- 子句通常位于独立行，便于编辑，提高可读性  
- 注释：  
SQL标准：  
\/*注释内容\*/  #多行注释  
-- 注释内容  #单行注释，注意有空格  
MySQL注释：\#  

# 数据库对象
- 数据库的组件(对象)：  
数据库、表、索引、视图、用户、存储过程、函数、触发器、事件调度器等
- 命名规则：  
**必须以字母开头**  
可包括数字和三个特殊字符（# _ $）  
不要使用MySQL的保留字  
同一database(Schema)下的对象不能同名  

# SQL语句分类
- DDL: Data Defination Language 数据定义语言  
CREATE，**DROP**，ALTER  
- DML: Data Manipulation Language 数据操纵语言  
**INSERT**，**DELETE**，**UPDATE**  
- DCL：Data Control Language 数据控制语言  
GRANT，REVOKE，COMMIT，ROLLBACK  
- DQL：Data Query Language 数据查询语言  
**SELECT**

# SQL语句构成
Keyword组成clause  
多条clause组成语句  

示例：  
SELECT *  #SELECT子句  
FROM products #FROM子句  
WHERE price>400 #WHERE子句  
说明：一组SQL语句，由三个子句构成，SELECT,FROM和WHERE是关键字  

# 数据库操作
- 创建数据库：  
CREATE DATABASE|SCHEMA [IF NOT EXISTS] 'DB_NAME';  
CHARACTER SET 'character set name'  #设置默认字符集   
例如：
`create database db_utf8mb4 CHARACTER SET=utf8mb4;`  
COLLATE 'collate name'  #字符排序 
- 删除数据库  
DROP DATABASE|SCHEMA [IF EXISTS] 'DB_NAME';  
例如:`drop database testdb;`
- 查看支持所有字符集：SHOW CHARACTER SET;  
- 查看支持所有排序规则：SHOW COLLATION; 
- 查看数据库创建的默认选项   
show create database testdb;
- 获取命令使用帮助：  
mysql> HELP KEYWORD;  
- 查看数据库列表：  
mysql> SHOW DATABASES;   
```
创建数据库后建议修改配置文件：

1、建议创建数据时就定义好字符集：
vim /etc/my.cnf.d/server.cnf
[mysqld]
character-set-server=utf8mb4
客户端
vim /etc/my.cnf.d/mysql-clients.cnf
[mysql]
default-character-set=utf8mb4
重启服务
systemctl restart mariadb

2、将低版本的mysql数据分开存放
vim /etc/my.cnf.d/server.cnf
[mysqld]
innodb_file_per_table=ON
systemctl restart mariadb

3、安全的删除和更新数据
修改客户端配置文件
vim /etc/my.cnf.d/mysql-clients.cnf
[mysql]
safe-updates
```

# 数据表
表：二维关系  
设计表：遵循规范  
定义：字段，索引  
字段：字段名，字段数据类型，修饰符  
约束，索引：应该创建在经常用作查询条件的字段上  

## 创建表
创建表：CREATE TABLE
1. 直接创建
1. 通过查询现存表创建；新表会被直接插入查询而来的数据   
CREATE TABLE [IF NOT EXISTS] tbl_name
[(create_definition,...)] [table_options]
[partition_options] select_statement  
`create table custom select * from student;`
1. 通过复制现存的表的表结构创建，但不复制数据  
CREATE TABLE [IF NOT EXISTS] tbl_name { LIKE
old_tbl_name | (LIKE old_tbl_name) }   
`create table custom like student;`

> 注意：
Storage Engine是指表类型，也即在表创建时指明其使用的存储引擎，同一库中不同表可以使用不同的存储引擎
同一个库中表建议要使用同一种存储引擎类型
```
CREATE TABLE [IF NOT EXISTS] ‘tbl_name’ (col1 type1 修饰符, col2
type2 修饰符, ...)  #col列名称
字段信息
• col type1
• PRIMARY KEY(col1,...) #主键
• INDEX(col1, ...)      
• UNIQUE KEY(col1, ...)
表选项：
• ENGINE [=] engine_name  #存储引擎定义
SHOW ENGINES;查看支持的engine类型
• ROW_FORMAT [=]          #是否压缩存储
{DEFAULT|DYNAMIC|FIXED|COMPRESSED|REDUNDANT|COMPACT}
```
```
创建表示例：
CREATE TABLE students (id int UNSIGNED NOT NULL PRIMARY KEY,name VARCHAR（20）NOT NULL,age tinyint UNSIGNED);
DESC students;  #查看表

CREATE TABLE students2 (id int UNSIGNED NOT NULL ,name VARCHAR(20) NOT NULL,age tinyint UNSIGNED,PRIMARY KEY(id,name));
```
> 获取帮助：mysql> HELP CREATE TABLE; 

## 表操作
查看所有的引擎：  
`SHOW ENGINES`  
**查看表**：  
`SHOW TABLES [FROM db_name]`    
**查看表结构**：  
`DESC [db_name.]tb_name`    
`SHOW COLUMNS FROM [db_name.]tb_name`    
删除表：  
`DROP TABLE [IF EXISTS] tb_name`   
查看表创建命令：  
`SHOW CREATE TABLE tbl_name`   
**查看表状态**：  
`SHOW TABLE STATUS LIKE 'tbl_name'`  
查看库中所有表状态：  
`SHOW TABLE STATUS FROM db_name`  
修改表  
`ALTER TABLE 'tbl_name' `  
字段：  
添加字段：add  
ADD col1 data_type [FIRST|AFTER col_name]  
删除字段：drop  
修改字段：   
alter（默认值）, change（字段名）,modify（字段属性）     
`alter table student CHARACTER SET=utf8mb4;`  
索引:  
添加索引：add index  
删除索引：drop index    
查看表上的索引：SHOW INDEXES FROM    [db_name.]tbl_name;
> 查看帮助：Help ALTER TABLE
```
示例：
ALTER TABLE students RENAME s1;
ALTER TABLE s1 ADD phone varchar(11) AFTER name;
ALTER TABLE s1 MODIFY phone int;
ALTER TABLE s1 CHANGE COLUMN phone mobile char(11);
ALTER TABLE s1 DROP COLUMN mobile;
ALTER TABLE students ADD gender ENUM('m','f')
ALETR TABLE students CHANGE id sid int UNSIGNED NOT NULL PRIMARY KEY;
ALTER TABLE students ADD UNIQUE KEY(name);
ALTER TABLE students ADD INDEX(age);
DESC students;
SHOW INDEXES FROM students;
ALTER TABLE students DROP age;
```

# 数据类型
- 数据类型：
数据长什么样
数据需要多少空间来存放
- 系统内置数据类型和用户定义数据类型
- MySql支持多种列类型：
1. 数值类型
1. 日期/时间类型
1. 字符串(字符)类型
> https://dev.mysql.com/doc/refman/5.5/en/data-types.html

**选择正确的数据类型对于获得高性能至关重要**，三大原则：
1. 更小的通常更好，尽量使用可正确存储数据的最小数据类型
1. 简单就好，简单数据类型的操作通常需要更少的CPU周期
1. 尽量避免NULL，包含为NULL的列，对MySQL更难优化
![int](https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1543505120590&di=f9e6320ab071fa2f524d22cbbf4702bb&imgtype=jpg&src=http%3A%2F%2Fimg4.imgtn.bdimg.com%2Fit%2Fu%3D3220053439%2C312874450%26fm%3D214%26gp%3D0.jpg)

## 整数型


类型 | 说明
---|---
tinyint(m) | 1个字节 范围(-128~127)
smallint(m) | 2个字节 范围(-32768~32767)
mediumint(m)|3个字节 范围(-8388608~8388607)
int(m)|4个字节 范围(-2147483648~2147483647)
bigint(m)|8个字节 范围(+-9.22*10的18次方)
BOOL，BOOLEAN|布尔型，是TINYINT(1)的同义词。zero值被视为假，非zero值视为真

> 1、加了unsigned，则最大值翻倍，如：tinyint unsigned的取值范围为(0~255)  
2、int(m)里的m是表示SELECT查询结果集中的显示宽度，并不影响实际的取值范围，规定了MySQL的一些交互工具（例如MySQL命令行客户端）用来显示字符的个数。对于存储和计算来说，Int(1)和Int(20)是相同的

## 浮点型
float(m,d) 单精度浮点型 8位精度(4字节) m总个数，d小数位  
double(m,d) 双精度浮点型16位精度(8字节) m总个数，d小数位  
设一个字段定义为float(6,3)，如果插入一个数123.45678,实际数据库里存的是123.457，但总个数还以实际为准，即6位

## 定点数
- 在数据库中存放的是精确值,存为十进制
- decimal(m,d) 参数m<65 是总个数，d<30且 d<m 是小数位
- MySQL5.0和更高版本将数字打包保存到一个二进制字符串中（每4个字节存9个数字）。例如，decimal(18,9)小数点两边将各存储9个数字，一共使用9个字节：小数点前的数字用4个字节，小数点后的数字用4个字节，小数点本身占1个字节
- 浮点类型在存储同样范围的值时，通常比decimal使用更少的空间。float使用4个字节存储。double占用8个字节
- 因为需要额外的空间和计算开销，所以应该尽量只在对小数进行精确计算时才使用decimal——例如存储财务数据。但在数据量比较大的时候，可以考虑使用bigint代替decimal

## 字符串(char,varchar,_text)

类型 | 说明
---|---
char(n) | 固定长度，最多255个字符
varchar(n)  | 可变长度，最多65535个字符
tinytext |可变长度，最多255个字符
text |可变长度，最多65535个字符
mediumtext |可变长度，最多2的24次方-1个字符
longtext |可变长度，最多2的32次方-1个字符
BINARY(M) |固定长度，可存二进制或字符，长度为0-M字节
VARBINARY(M)|可变长度，可存二进制或字符，允许长度为0-M字节
内建类型|ENUM枚举, SET集合

char和varchar：  
1. char(n) 若存入字符数小于n，则以空格补于其后，查询之时再将空格去掉，
所以char类型存储的字符串末尾不能有空格，varchar不限于此
1. char(n) 固定长度，char(4)不管是存入几个字符，都将占用4个字节，varchar
是存入的实际字符数+1个字节（n< n>255)，所以varchar(4),存入3个字符将
占用4个字节
1. char类型的字符串检索速度要比varchar类型的快

varchar和text：
1. varchar可指定n，text不能指定，内部存储varchar是存入的实际字符数+1个
字节（n< n>255)，text是实际字符数+2个字节。
1. text类型不能有默认值
1. varchar可直接创建索引，text创建索引要指定前多少个字符。varchar查询速
度快于text

## 二进制数据BLOB
BLOB和text存储方式不同，TEXT以文本方式存储，英文存储区分大小写，而Blob是以二进制方式存储，不分大小写  
BLOB存储的数据只能整体读出  
TEXT可以指定字符集，BLOB不用指定字符集  

## 日期时间类型
date 日期 '2008-12-2'  
time 时间 '12:25:36'  
datetime 日期时间 '2008-12-2 22:06:44'  
timestamp 自动存储记录修改时间  
YEAR(2), YEAR(4)：年份  
> timestamp字段里的时间数据会随其他字段修改的时候自动刷新，这个数据类型的字段可以存放这条记录最后被修改的时间

## 修饰符
所有类型：  
• NULL 数据列可包含NULL值  
• NOT NULL 数据列不允许包含NULL值  
• DEFAULT 默认值  
• PRIMARY KEY 主键  
• UNIQUE KEY 唯一键  
• CHARACTER SET name 指定一个字符集  
数值型  
• AUTO_INCREMENT 自动递增，适用于整数类型  
• UNSIGNED 无符号  

## DML语句
DML: INSERT, DELETE, UPDATE  
### INSERT：   
一次插入一行或多行数据  
三种语法：  
1. 
```
INSERT [LOW_PRIORITY | DELAYED | HIGH_PRIORITY] [IGNORE] 
[INTO] tbl_name [(col_name,...)] 
{VALUES | VALUE} ({expr | DEFAULT},...),(...),...
[ON DUPLICATE KEY UPDATE 如果重复更新之col_name=expr [, col_name=expr] ... ]  
```
**简化写法**：  
`INSERT tbl_name [(col1,...)] VALUES (val1,...), (val21,...)`  
> 后面的具体值必须和字段属性和顺序匹配
2. 
```
INSERT [LOW_PRIORITY | DELAYED | HIGH_PRIORITY] [IGNORE] 
[INTO] tbl_name
SET col_name={expr | DEFAULT}, ...
[ ON DUPLICATE KEY UPDATE
col_name=expr
[, col_name=expr] ... ]
```
3. 
```
INSERT [LOW_PRIORITY | HIGH_PRIORITY] [IGNORE]
[INTO] tbl_name [(col_name,...)]
SELECT ...
[ ON DUPLICATE KEY UPDATE
col_name=expr
[, col_name=expr] ... ]
```
### UPDATE
```
UPDATE [LOW_PRIORITY] [IGNORE] table_reference
SET col_name1={expr1|DEFAULT} [, col_name2={expr2|DEFAULT}] ...
[WHERE where_condition]
[ORDER BY ...]
[LIMIT row_count]
```
> 注意：一定要有限制条件，否则将修改所有行的指定字段  
限制条件：  
WHERE  
LIMIT  

**建议使用安全更新语句以往误操作**  
Mysql 选项：-U|--safe-updates| --i-am-a-dummy  
或定义别名 alias mysql='mysql -U'

### DELETE
```
DELETE [LOW_PRIORITY] [QUICK] [IGNORE] FROM tbl_name
[WHERE where_condition]
[ORDER BY ...]
[LIMIT row_count]
可先排序再指定删除的行数
示例：
delete from student where id >= 5;
快速删除表中所有内容，但不记录日志：
truncate table student;
```
> 注意：一定要有限制条件，否则将清空表中的所有数据
限制条件：  
WHERE  
LIMIT 
TRUNCATE TABLE tbl_name; 清空表

# DQL语句
## SELECT
```
[ALL | DISTINCT | DISTINCTROW ]
[SQL_CACHE | SQL_NO_CACHE]
select_expr [, select_expr ...]
 [FROM table_references
 [WHERE where_condition]
 [GROUP BY {col_name | expr | position}
 [ASC | DESC], ... [WITH ROLLUP]]
 [HAVING where_condition]
 [ORDER BY {col_name | expr | position}
 [ASC | DESC], ...]
 [LIMIT {[offset,] row_count | row_count OFFSET offset}]
 [FOR UPDATE | LOCK IN SHARE MODE]
```
**字段显示可以使用别名**：  
col1 AS alias1, col2 AS alias2, ...  
**WHERE子句**：指明过滤条件以实现“选择”的功能：  
`select name as 姓名,id,age as 年龄 from student;`  
过滤条件：
- 布尔型表达式
- 算术操作符：+, -, *, /, %
- 比较操作符：=,<=>（相等或都为空）, <>, !=(非标准SQL), >, >=, <, <=
- BETWEEN min_num AND max_num
- IN (element1, element2, ...)
- IS NULL
- IS NOT NULL
> 查询命令定义别名后，不能再使用表名查询 
```
select * from student where age > 25;  #查询年龄大于25
select * from student where age between 25 and 28;  # 查询年龄在25到28之间
select * from student where age in (20,30);  #查询年龄等于20和30的
select * from student where mobile is null;  #查询手机号码为空
```

- DISTINCT 去除重复列    
`SELECT DISTINCT gender FROM students; ` 
- **LIKE**:  
% 任意长度的任意字符  
_ 任意单个字符  
- RLIKE：正则表达式，**索引失效，不建议使用**  
REGEXP：匹配字符串可用正则表达式书写模式，同上
- 逻辑操作符：  
NOT  
AND   
OR  
XOR  
- **GROUP**：根据指定的条件把查询结果进行“分组”以用于做“聚合”运算avg(), max(), min(), count(), sum()
```
select gender as 性别,count(*) as 人数 from students group by gender;

select gender as 性别,avg(age) as 平均年龄 from students group by gender;

select classid,gender,max(age) from students group by classid,gender;

分组前统计
select classid,count(*) from students where age > 30 group by classid;

分组后再统计
select classid,count(*) from students where age > 30 group by classid having classid;
```
- **HAVING**: 对分组聚合运算后的结果指定过滤条件  
- **ORDER BY**: 根据指定的字段对查询结果进行排序  
升序：ASC  
降序：DESC  
`select * from students order by age desc;`  
`select * from students order by age asc;`  
排除null值后按正序排列  
`select * from students order by -classid desc;`
- LIMIT [[offset,]row_count]：对查询的结果进行输出行数数量限制  
对查询结果中的数据请求施加“锁”   
FOR UPDATE: 写锁，独占或排它锁，只有一个读和写  
LOCK IN SHARE MODE: 读锁，共享锁，同时多个读  
```
DESC students;
INSERT INTO students VALUES(1,'tom'，'m'),(2,'alice','f');
INSERT INTO students(id,name) VALUES(3,'jack'),(4,'allen');
SELECT * FROM students WHERE id < 3;
SELECT * FROM students WHERE gender='m';
SELECT * FROM students WHERE gender IS NULL;
SELECT * FROM students WHERE gender IS NOT NULL;
SELECT * FROM students ORDER BY name DESC LIMIT 2;
SELECT * FROM students ORDER BY name DESC LIMIT 1,2;
SELECT * FROM students WHERE id >=2 and id <=4
SELECT * FROM students WHERE BETWEEN 2 AND 4
SELECT * FROM students WHERE name LIKE ‘t%’
SELECT * FROM students WHERE name RLIKE '.*[lo].*';
SELECT id stuid,name as stuname FROM students
```

# 多表查询
交叉连接：笛卡尔乘积  
内连接：   
等值连接：让表之间的字段以“等值”建立连接关系；  
不等值连接   
自然连接:去掉重复列的等值连接   
自连接  
外连接：  
左外连接：  
FROM tb1 LEFT JOIN tb2 ON tb1.col=tb2.col   
右外连接   
FROM tb1 RIGHT JOIN tb2 ON tb1.col=tb2.col  

# 视图
视图：VIEW,虚表，保存有实表的查询结果
创建方法：
`CREATE VIEW view_name [(column_list)] AS select_statement [WITH [CASCADED | LOCAL] CHECK OPTION]`  
查看视图定义：  
SHOW CREATE VIEW view_name    
删除视图：  
DROP VIEW [IF EXISTS] view_name [, view_name] ... [RESTRICT | CASCADE]  
**视图中的数据事实上存储于“基表”中,视图本身不存放数据，因此，其修改操作也会针对基表实现**；  
其修改操作受基表限制
> 视图一般适用于复杂多表查询，不适合修改数据

# 函数
函数：系统函数和自定义函数  
 系统函数:https://dev.mysql.com/doc/refman/5.7/en/func-op-summaryref.html  
- 自定义函数 (user-defined function UDF)  
保存在mysql.proc表中  
创建UDF  
```
CREATE [AGGREGATE] FUNCTION function_name(parameter_name
type,[parameter_name type,...])
RETURNS {STRING|INTEGER|REAL} #返回结果
runtime_body   #函数定义体
```
> 说明：
参数可以有多个,也可以没有参数
必须有且只有一个返回值

## 自定义函数
- 创建函数  
 示例：无参UDF  
`CREATE FUNCTION simpleFun() RETURNS VARCHAR(20) RETURN "Hello World!";`  
select simpleFun();#查看函数  
select hellod.simpleFun();#跨数据库查看  
- 查看函数列表：  
 `SHOW FUNCTION STATUS; ` 
- 查看函数定义:    
 `SHOW CREATE FUNCTION function_name`
- 删除UDF:  
 `DROP FUNCTION function_name;`
- 调用自定义函数语法:  
 `SELECT function_name(parameter_value,...)`
- 示例：有参数UDF
```
DELIMITER // #避免;执行单条命令，将//定义为结束
CREATE FUNCTION deleteById(uid SMALLINT UNSIGNED) RETURNS VARCHAR(20) #定义一个uid的参数
BEGIN
DELETE FROM students WHERE stuid = uid;  #删除stuid匹配uid参数
RETURN (SELECT COUNT(stuid) FROM students);
END//

DELIMITER ;  #在写完整个函数后，重新使用;结束查询命令
select deletebyid(27);  #删除stuid为27的数据
```

## 局部变量语法
DECLARE 变量1[,变量2,... ]变量类型 [DEFAULT 默认值]  
说明：局部变量的作用范围是在BEGIN...END程序中,而且定义局部变量语句必须在BEGIN...END的第一行定义
```
示例:
DELIMITER //
CREATE FUNCTION addTwoNumber(x SMALLINT UNSIGNED, Y SMALLINT
UNSIGNED)
RETURNS SMALLINT
BEGIN
DECLARE a, b SMALLINT UNSIGNED;
SET a = x, b = y;
RETURN a+b;
END//

DELIMITER ;
select addTwoNumber(1,45)
```

## 变量赋值语法
SET parameter_name = value[,parameter_name = value...]  
SELECT INTO parameter_name  
set @a=7   #会话变量，只存在此连接会话中  
select a;
```
示例:
...
DECLARE x int;
SELECT COUNT(id) FROM tdb_name INTO x;  #将x赋值查询表中的记录数量  
RETURN x;
END//
```
# 存储过程
- 存储过程优势  
存储过程把经常使用的SQL语句或业务逻辑封装起来,预编译保存在数据库中,当需要时从数据库中直接调用,省去了编译的过程  
提高了运行速度
同时降低网络数据传输量  
- 存储过程与自定义函数的区别  
存储过程实现的过程要复杂一些,而函数的针对性较强   
存储过程可以有多个返回值,而自定义函数只有一个返回值   
存储过程一般独立的来执行,而函数往往是作为其他SQL语句的一部分来使用  

## 创建存储过程
- 存储过程：存储过程保存在mysql.proc表中
`CREATE PROCEDURE sp_name ([ proc_parameter [,proc_parameter ...]])  
routime_body   
proc_parameter : [IN|OUT|INOUT]   parameter_name type  
> 其中IN表示输入参数，OUT表示输出参数，INOUT表示既可以输入也可以输出；  
param_name表示参数名称；type表示参数的类型

- 查看存储过程列表  
`SHOW PROCEDURE STATUS;`
- 查看存储过程定义    
`SHOW CREATE PROCEDURE sp_name`   
- 调用存储过程   
`CALL sp_name ([ proc_parameter [,proc_parameter ...]])`  
`CALL sp_name`  
> 说明:当无参时,可以省略"()",当有参数时,不可省略"()”   
- 存储过程修改   
ALTER语句修改存储过程只能修改存储过程的注释等无关紧要的东西,不能修改存储过程体,所以要修改存储过程,方法就是删除重建   
- 删除存储过程   
`DROP PROCEDURE [IF EXISTS] sp_name`
```
存储过程示例
1、创建无参存储过程
delimiter //  #定义//为结束符
CREATE PROCEDURE showTime()
BEGIN
SELECT now();
END//
delimiter ;  #重新使用；为结束符
CALL showTime;   #调用存储过程

2、创建含参存储过程：只有一个IN参数
delimiter //
CREATE PROCEDURE selectById(IN uid SMALLINT UNSIGNED)
BEGIN
SELECT * FROM students WHERE stuid = uid;
END//
delimiter ;
call selectById(2);

3、求和计算
delimiter //
CREATE PROCEDURE dorepeat(n INT)  #定义n的类型
BEGIN
SET @i = 0;
SET @sum = 0;
REPEAT SET @sum = @sum+@i; SET @i = @i + 1;
UNTIL @i > n END REPEAT;  #计算i自相加运算到n的值
END//
delimiter ;
CALL dorepeat(100);  #计算从0到100
SELECT @sum;         #取结果
```
# 流程控制
存储过程和函数中可以使用流程控制来控制语句的执行  
流程控制：
- IF：用来进行条件判断。根据是否满足条件，执行不同语句
- CASE：用来进行条件判断，可实现比IF语句更复杂的条件判断
- LOOP：重复执行特定的语句，实现一个简单的循环
- LEAVE：用于跳出循环控制
- ITERATE：跳出本次循环，然后直接进入下一次循环
- REPEAT：有条件控制的循环语句。当满足特定条件时，就会跳出循环语句
- WHILE：有条件控制的循环语句

# 触发器
触发器的执行不是由程序调用，也不是由手工启动，而是由事件来触发、激活从而实现
执行
- 创建触发器  
CREATE  
 [DEFINER = { user | CURRENT_USER }]  
 TRIGGER trigger_name  
 trigger_time trigger_event  
 ON tbl_name FOR EACH ROW  
 trigger_body    
> 说明：  
trigger_name：触发器的名称   
trigger_time：{ BEFORE | AFTER }，**表示在事件之前或之后触发**  
trigger_event:：{ INSERT |UPDATE | DELETE }，触发的具体事件  
tbl_name：该触发器作用在表名   
```
1、示例：创建触发器，在向学生表INSERT数据时，学生数增加，DELETE学生时，学生数减少
CREATE TRIGGER trigger_student_count_insert
AFTER INSERT
ON student_info FOR EACH ROW
UPDATE student_count SET student_count=student_count+1;
CREATE TRIGGER trigger_student_count_delete
AFTER DELETE
ON student_info FOR EACH ROW
UPDATE student_count SET student_count=student_count-1;
```
查看触发器   
`SHOW TRIGGERS`  
查询系统表information_schema.triggers的方式指定查询条件，查看指定的触发器信息。   
```
mysql> USE information_schema;
Database changed
mysql> SELECT * FROM triggers WHERE
trigger_name='trigger_student_count_insert';
```
删除触发器   
`DROP TRIGGER trigger_name;`

# MySQL用户和权限管理
- 元数据数据库：mysql  
系统授权表：   
db, host, user   
columns_priv, tables_priv, procs_priv, proxies_priv   
- 用户账号：   
'USERNAME'@'HOST'   
@'HOST':  #允许登录的主机IP     
 主机名   
 IP地址或Network   
 通配符： % _   
示例：172.16.%.%   #允许使用内网IP地址登录    
## 用户管理
- 创建用户：CREATE USER  
`CREATE USER 'USERNAME'@'HOST' [IDENTIFIED BY 'password']；`    #不常用，创建用户权限较小，不方便使用
默认权限：USAGE  
- 用户重命名：RENAME USER   
`RENAME USER old_user_name TO new_user_name;`
- 删除用户：  
`DROP USER 'USERNAME'@'HOST' `   
示例：删除默认的空用户  
`DROP USER ''@'localhost';`   #删除空密码''  
- 修改密码：  
`mysql>SET PASSWORD FOR 'user'@'host' = PASSWORD(‘password'); ` 
`mysql>UPDATE mysql.user SET password=PASSWORD('password') WHERE clause;`  
 此方法需要执行下面指令才能生效：  
`mysql> FLUSH PRIVILEGES; `  
`mysqladmin -u root -poldpass password 'newpass' `

## 忘记管理员密码的解决办法：   
1. 启动mysqld进程时，为其使用如下选项：  
--skip-grant-tables --skip-networking   
1. 使用UPDATE命令修改管理员密码   
`update mysql.user set password=password('centos') where user='root'`  #重新设置root账户密码为centos
1. 关闭mysqld进程，移除上述两个选项，重启mysqld   

## MySQL权限管理
权限类别：  
管理类  
程序类   
数据库级别  
表级别  
字段级别   

# 授权
```
授权tom用户只能查看和修改表
grant select,insert on testdb.* to 'tom'@'172.18.%.%';

授权tom用户所有的权限
grant all on testdb.* to 'tom'@172.18.%.%;

*.*: 所有库的所表
db_name.*: 指定库的所有表
db_name.tb_name: 指定库的指定表
db_name.routine_name：指定库的存储过程和函数
revoke insert on testdb.* from 'tom'@'172.18.%.%';   #收回授权
grant all on testdb.* to 'wang'@'172.18.0.106' identified by "magedu";    #授权的同时创建账号
show grants for wang@'172.18.0.106';   #查看用户获得的授权
grant update(name) on testdb.students to test@'172.18.%.%' identified by 'centos';   #只授权修改某个字段
Help SHOW GRANTS   #查看帮助。怎么查用户的获得的授权
对于不能够或不能及时重读授权表的命令，可手动让MariaDB的服务进程重读授权表：mysql> FLUSH PRIVILEGES
```

# 存储引擎
- 查看mysql支持的存储引擎   
`show engines;`
- 查看当前默认的存储引擎  
`show variables like '%storage_engine%';`  
- 设置默认的存储引擎
```
vim /etc/my.conf
[mysqld]
default_storage_engine= InnoDB
```
- 查看库中所有表使用的存储引擎  
`how table status from db_name;`  
- 查看库中指定表的存储引擎   
`show table status like ' tb_name ';`   
`show create table tb_name;`   
- 设置表的存储引擎：   
`CREATE TABLE tb_name(... ) ENGINE=InnoDB;`   
`ALTER TABLE tb_name ENGINE=InnoDB;`

## MyISAM引擎特点：
- **不支持事务**
- **表级锁定**
- 读写相互阻塞，写入不能读，读时不能写
- 只缓存索引
- **不支持外键约束**
- 不支持聚簇索引
- 读取数据较快，占用资源较少
- **不支持MVCC**（多版本并发控制机制）高并发
- 崩溃恢复性较差  
- MySQL5.5.5前默认的数据库引擎

MyISAM存储引擎适用场景   
只读（或者写较少）、表较小（可以接受长时间进行修复操作）   
MyISAM引擎文件  
tbl_name.frm 表格式定义  
tbl_name.MYD 数据文件  
tbl_name.MYI 索引文件   

## InnoDB引擎特点
- **行级锁**
- **支持事务**，适合处理大量短期事务
- 读写阻塞与事务隔离级别相关
- 可缓存数据和索引
- 支持聚簇索引
- 崩溃恢复性更好
- **支持MVCC高并发**
- 从MySQL5.5后支持全文索引
- 从MySQL5.5.5开始为默认的数据库引擎

InnoDB数据库文件   
- 所有InnoDB表的数据和索引放置于同一个表空间中   
表空间文件：datadir定义的目录下   
数据文件：ibddata1, ibddata2, ...   
- 每个表单独使用一个表空间存储表的数据和索引   
启用：**innodb_file_per_table=ON**    
参看：https://mariadb.com/kb/en/library/xtradbinnodb-serversystem-variables/#innodb_file_per_table   
ON (>= MariaDB 5.5)默认在5.5以后都已经是开启状态      
两类文件放在数据库独立目录中   
**数据文件**(存储数据和索引)：tb_name.ibd   
**表格式定义**：tb_name.frm    
> 数据表都存放在一个表中，删除后空间不会缩减
推荐单独存放，便于管理  

## MySQL中的系统数据库
- mysql数据库   
是mysql的核心数据库，类似于Sql Server中的master库，主要负责存储数据库的用户、权限设置、关键字等mysql自己需要使用的控制和管理信息   
- performance_schema数据库   
MySQL 5.5开始新增的数据库，主要用于收集数据库服务器性能参数,库里表的存储引擎均为PERFORMANCE_SCHEMA，用户不能创建存储引擎为PERFORMANCE_SCHEMA的表   
- information_schema数据库
MySQL 5.0之后产生的，一个虚拟数据库，物理上并不存在。   
information_schema数据库类似与“数据字典”，提供了访问数据库元数据的方式，即数据的数据。比如数据库名或表名，列类型，访问权限（更加细化的访问方式）

# 服务器配置
mysqld选项，服务器系统变量和服务器状态变量   
https://dev.mysql.com/doc/refman/5.7/en/mysqld-optiontables.html   
https://mariadb.com/kb/en/library/full-list-of-mariadb-optionssystem-and-status-variables/   
> 注意：其中有些参数支持运行时修改，会立即生效；  
有些参数不支持，且只能通过修改配置文件，并重启服务器程序生效；    
有些参数作用域是全局的，且不可改变；有些可以为每个用户提供单独（会话）的设置  
配置文件中建议“-”链接参数，系统变量建议“_”  
**写到配置文件中的必须是msql选项**
有的变量不一定是选项，写配置文件要注意

## 服务器系统变量
分全局和会话两种  
- 获取系统变量
```
mysql> SHOW GLOBAL VARIABLES;    #查看全局变量
mysql> SHOW [SESSION] VARIABLES; #查看会员变量
mysql> SELECT @@VARIABLES;       #查看具体变量的参数
mysql> SELECT @@sort_buffer_size;
```
- 修改服务器变量的值：   
`mysql> help SET`
- 修改全局变量：仅对修改后新创建的会话有效；对已经建立的会话无效   
`mysql> SET GLOBAL system_var_name=value;`  
`mysql> SET @@global.system_var_name=value;`
- 修改会话变量：  
`mysql> SET [SESSION] system_var_name=value;`  
`mysql> SET @@[session.]system_var_name=value;`
- 状态变量（只读）：用于保存mysqld运行中的统计数据的变量，不可更改   
`mysql> SHOW GLOBAL STATUS;`  
`mysql> SHOW [SESSION] STATUS;`

# 查询缓存
使用hash计算命令整体，匹配是否与新指令是否一致。
为了更准确的利用缓存，要注意大小写，空格多少。
读的多写的少，适合查询缓存  
写多读少，不适合利用查询缓存

## 查询缓存相关的服务器变量
- query_cache_min_res_unit：查询缓存中内存块的最小分配单位，默认4k，较小值会减少浪费，但会导致更频繁的内存分配操作，较大值会带来浪费，会导致碎片过多，内存不足   
- query_cache_limit：单个查询结果能缓存的最大值，默认为1M，对于查询结果过大而无法缓存的语句，建议使用SQL_NO_CACHE   
- query_cache_size：查询缓存总共可用的内存空间；单位字节，必须是1024的整数倍，最小值40KB，低于此值有警报  
- query_cache_wlock_invalidate：如果某表被其它的会话锁定，是否仍然可以  
从查询缓存中返回结果，默认值为OFF，表示可以在表被其它会话锁定的场景中继续从缓存返回数据；ON则表示不允许   
- query_cache_type：是否开启缓存功能，取值为ON, OFF, DEMAND   
- SELECT语句的缓存控制   
SQL_CACHE：显式指定存储查询结果于缓存之中  
SQL_NO_CACHE：显式查询结果不予缓存  
- query_cache_type参数变量  
query_cache_type的值为OFF或0时，查询缓存功能关闭     
query_cache_type的值为ON或1时，查询缓存功能打开，SELECT的结果符合缓存条件即会缓存，否则，不予缓存，显式指定SQL_NO_CACHE，不予缓存，此为默认值  
- query_cache_type的值为DEMAND或2时，查询缓存功能按需进行，显式指定SQL_CACHE的SELECT语句才会缓存；其它均不予缓存  

## 缓存系统变量
查询缓存相关的状态变量：SHOW GLOBAL STATUS LIKE 'Qcache%';
```
+-------------------------+---------+
| Variable_name           | Value   |
+-------------------------+---------+
| Qcache_free_blocks      | 1       |
| Qcache_free_memory      | 1031320 |
| Qcache_hits             | 0       |
| Qcache_inserts          | 0       |
| Qcache_lowmem_prunes    | 0       |
| Qcache_not_cached       | 0       |
| Qcache_queries_in_cache | 0       |
| Qcache_total_blocks     | 1       |
+-------------------------+---------+
Qcache_free_blocks：处于空闲状态 Query Cache中内存 Block 数
Qcache_total_blocks：Query Cache 中总Block ，当Qcache_free_blocks相对此值较大时，可能用内存碎片，执行FLUSH QUERY CACHE清理碎片
Qcache_free_memory：处于空闲状态的Query Cache内存总量
Qcache_hits：Query Cache 命中次数
Qcache_inserts：向 Query Cache 中插入新的Query Cache的次数，即没有命中的次数
Qcache_lowmem_prunes：记录因为内存不足而被移除出查询缓存的查询数
Qcache_not_cached：没有被Cache的SQL数，包括无法被Cache的SQL以及由于query_cache_type设置的不会被Cache的SQL语句
Qcache_queries_in_cache：在Query Cache中的SQL数量

查询缓存命中率 ：Qcache_hits / ( Qcache_hits + Qcache_inserts ) * 100%
查询缓存内存使用率：(query_cache_size – qcache_free_memory) /
query_cache_size * 100%
```
# 聚簇和非聚簇索引
非聚集索引：数据和索引不在一起  
聚集索引：数据和索引在一起
主键索引：索引和数据都放在叶子节点，速度快  
二级索引：主键和索引存放在叶子节点，需要查询两次，还要利用主键索引才能有结果  

# 索引
索引：是特殊数据结构，定义在查找时作为查找条件的字段，在MySQL又称为键key，索引通过存储引擎实现
- 优点：  
索引可以降低服务需要扫描的数据量，减少了IO次数  
索引可以帮助服务器避免排序和使用临时表  
索引可以帮助将随机I/O转为顺序I/O  
- 缺点：  
占用额外空间，影响插入速度

## 索引类型：
- B+ TREE、HASH、R TREE
- 聚簇（集）索引、非聚簇索引：数据和索引是否存储在一起
- 主键索引、二级（辅助）索引
- 稠密索引、稀疏索引：是否索引了每一个数据项
- 简单索引、组合索引  
**左前缀索引**：取前面的字符做索引  
覆盖索引：从索引中即可取出要查询的数据，性能高  
简单索引：对单独字段建立索引
复合索引：对多个字段建立索引 
左前缀索引：利用后面的数据查询，不能利用到索引
- 二叉树：按树状排列，但可能会出现分支不全  
- 红黑树：平衡的二叉树，有可能分支太多，树太高，效率差
- B-TREE索引：平衡树，多叉树，叶子节点到根的节点数都一致，每节点存放数据，效率差，不便管理    
- B+TREE索引：每节点不存放数据，只在叶子节点存放数据，通过链表指向下一数据块，效率高，区域查询速度快

> 每张表可以创建多条索引  
读多写少，适合索引  

## 索引优化建议
- 只要列中含有NULL值，就最好不要在此例设置索引，复合索引如果有NULL值，此列在使用时也不会使用索引   
- 尽量使用短索引，如果可以，应该制定一个前缀长度   
- 对于经常在where子句使用的列，最好设置索引   
- 对于有多个列where或者order by子句，应该建立复合索引  
- 对于like语句，以%或者‘-’开头的不会使用索引，以%结尾会使用索引   
- 尽量不要在列上进行运算（函数操作和表达式操作）   
- 尽量不要使用not in和<>操作   

## SQL语句性能优化
- 查询时，能不要*就不用*，尽量写全字段名
- 大部分情况连接效率远大于子查询
- 多表连接时，尽量小表驱动大表，即小表 join 大表
- 在有大量记录的表分页时使用limit
- 对于经常使用的查询，可以开启缓存
- 多使用explain和profile分析查询语句
- 查看慢查询日志，找出执行时间长的sql语句优化

## 管理索引
- 创建索引：   
CREATE INDEX index_name ON tbl_name    (index_col_name[(length)],...);   
help CREATE INDEX;   
`create index idx_name_age on testlog(name,age);`
- 删除索引：   
DROP INDEX index_name ON tbl_name;
- 查看索引：   
SHOW INDEXES FROM [db_name.]tbl_name;
- 优化表空间：   
OPTIMIZE TABLE tb_name;
- 查看索引的使用  
SET GLOBAL userstat=1;   
SHOW INDEX_STATISTICS;  

## EXPLAIN
通过EXPLAIN来分析索引的有效性   
`explain select * from testlog where name like 'wang1111';`  
输出信息说明：  
- id: 当前查询语句中，每个SELECT语句的编号   
- select_type：    
简单查询为SIMPLE   
- table：SELECT语句关联到的表
- type：关联类型或访问类型，即MySQL决定的如何去查询表中的行的方式，以下顺序，性能从低到高
- possible_keys：查询可能会用到的索引
- key: 查询中使用到的索引
- key_len: 在索引使用的字节数
- ref: 在利用key字段所表示的索引完成查询时所用的列或某常量值
- rows：MySQL估计为找所有的目标行而需要读取的行数

# 并发控制
- 锁粒度：  
表级锁  
行级锁  
- 锁：   
读锁：共享锁，只读不可写，多个读互不阻塞   
写锁：独占锁,排它锁，一个写锁会阻塞其它读和它锁   
- 实现   
存储引擎：自行实现其锁策略和锁粒度   
服务器级：实现了锁，表级锁；用户可显式请求   
- 分类：   
隐式锁：由存储引擎自动施加锁   
显式锁：用户手动请求   
- 锁策略：在锁粒度及数据安全性寻求的平衡机制
显式使用锁   
- LOCK TABLES 加锁   
`lock tables students read;`  
`lock tables students write;`
- UNLOCK TABLES 解锁
- FLUSH TABLES [tb_name[,...]] [WITH READ LOCK]   
关闭正在打开的表（清除查询缓存），通常在备份前加全局读锁    
`flush tables with read lock;`
- SELECT clause [FOR UPDATE | LOCK IN SHARE MODE]  
查询时加写或读锁

# 事务
事务Transactions：**一组原子性的SQL语句**，或一个独立工作单元   
事务日志：记录事务信息，实现undo,redo等故障恢复功能    
事务日志文件： ib_logfile0， ib_logfile1  
- ACID特性：   
A：**atomicity原子性**；整个事务中的所有操作要么全部成功执行，要么全部失败后回滚   
C：**consistency一致性**；数据库总是从一个一致性状态转换为另一个一致性状态（保证完整性）   
I：**Isolation隔离性**；一个事务所做出的操作在提交之前，是不能为其它事务所见；隔离有多种隔离级别，实现并发   
D：**durability持久性**；一旦事务提交，其所做的修改会永久保存于数据库中   

## 事务应用
- 启动事务：   
**BEGIN**   
BEGIN WORK   
START TRANSACTION   
- 结束事务：   
**COMMIT**：提交  
**ROLLBACK**: 回滚   
> 注意：只有事务型存储引擎中的DML（INSERT, DELETE, UPDATE）语句方能支持此类操作
- 自动提交：set **autocommit**={1|0}    #默认为1，为0时设为非自动提交   
> 建议：显式请求和提交事务，而不要使用“自动提交”功能
- 事务支持保存点：savepoint   
SAVEPOINT identifier   
ROLLBACK [WORK] TO [SAVEPOINT] identifier  
RELEASE SAVEPOINT identifier  

## 事务隔离级别
事务隔离级别：从上至下更加严格
- READ UNCOMMITTED 可读取到未提交数据，产生**脏读**
- READ COMMITTED 可读取到提交数据，但未提交数据不可读，产生不可重复读，即可读取到多个提交数据，导致每次读取数据不一致
- REPEATABLE READ 可重复读，多次读取数据都一致，产生**幻读**，即读取过程中，即使有其它提交的事务修改数据，仍只能读取到未修改前的旧数据。**此为MySQL默认设置**
- SERIALIZABILE 可串行化，未提交的读事务阻塞修改事务，或者未提交的修改事务阻塞读事务。**导致并发性能差**  
> MVCC: 多版本并发控制，和事务级别相关

### 指定事务隔离级别
- 服务器变量tx_isolation指定，默认为REPEATABLE-READ，可在GLOBAL和SESSION级进行设置  
SET tx_isolation=''  
READ-UNCOMMITTED  
READ-COMMITTED   
REPEATABLE-READ  
SERIALIZABLE  
- 服务器选项中指定  
```
vim /etc/my.cnf  
[mysqld]
transaction-isolation=REPEATABLE-READ
```
## 事务日志

事务日志 transaction log   
错误日志 error log   
通用日志 general log  
慢查询日志 slow query log  
二进制日志 binary log  
中继日志 reley log  

### 事务日志transaction log
- 事务型存储引擎自行管理和使用，**建议和数据文件分开存放**  
redo log   
undo log   
- Innodb事务日志相关配置：  
```
MariaDB [hellodb]> show variables like '%innodb_log%';
+-----------------------------+----------+
| Variable_name               | Value    |
+-----------------------------+----------+
| innodb_log_buffer_size      | 16777216 |
| innodb_log_checksums        | ON       |
| innodb_log_compressed_pages | ON       |
| innodb_log_file_size        | 50331648 |  #每个日志文件大小
| innodb_log_files_in_group   | 2        |  #日志组成员个数
| innodb_log_group_home_dir   | ./       |  #事务文件路径
| innodb_log_optimize_ddl     | ON       |
| innodb_log_write_ahead_size | 8192     |
+-----------------------------+----------+

修改配置文件来配合实际需求
1、创建日志存放的文件夹
mkdir /data/mysql/logs -pv
2、修改所有者和所属组
chown mysql.mysql /data/mysql/logs/
3、修改配置文件
vim  /etc/my.cnf.d/server.cnf
innodb_log_file_size=20M
innodb_log_files_in_group=5
innodb_log_group_home_dir=/data/mysql/logs
4、重启服务
systemctl restart mariadb
```
#### innodb_flush_log_at_trx_commit 默认为1   
说明：设置为1，同时sync_binlog = 1表示最高级别的容错
innodb_use_global_flush_log_at_trx_commit的值确定是否可以使用SET语句重置此变量   
- 1默认情况下，日志缓冲区将写入日志文件，并在每次事务后执行刷新到磁盘。这是完全遵守ACID特性   
- 0提交时没有任何操作;而是每秒执行一次日志缓冲区写入和刷新。 这样可以提供更好的性能，但服务器崩溃可以清除最后一秒的事务   
- 2每次提交后都会写入日志缓冲区，但每秒都会进行一次刷新。 性能比0略好一些，但操作系统或停电可能导致最后一秒的交易丢失    
- 3模拟MariaDB 5.5组提交（每组提交3个同步），此项MariaDB 10.0支持    

### 错误日志
mysqld启动和关闭过程中输出的事件信息   
mysqld运行中产生的错误信息    
event scheduler运行一个event时产生的日志信息   
在主从复制架构中的从服务器上启动从服务器线程时产生的信息  

错误日志相关配置  
SHOW GLOBAL VARIABLES LIKE 'log_error'  
错误文件路径   
log_error=/PATH/TO/LOG_ERROR_FILE  #注意路径的权限   
是否记录警告信息至错误日志文件   
log_warnings=1|0 默认值1   

### 通用日志general log
通用日志：记录对数据库的通用操作，包括错误的SQL语句  
文件：file，默认值   
表：table   
通用日志相关设置   
general_log=ON|OFF    
general_log_file=HOSTNAME.log    
log_output=TABLE|FILE|NONE   
`set global log_output='table';`  
修改输出日志到表，table在mysql数据库中
> 排错和优化性能启用

### 慢查询日志slow query log
慢查询日志：记录执行查询时长超出指定时长的操作

选项 | 说明
---|---
**slow_query_log** | 默认off，可以考虑开启，监控数据库性能
**long_query_time** | 慢查询的阀值，单位秒。考虑实际情况设定合适的值
slow_query_log_file | HOSTNAME-slow.log慢查询日志文件
log_slow_filter | admin,filesort,filesort_on_disk,full_join,full_scan,query_cache,query_cache_miss,tmp_table,tmp_table_on_disk上述查询类型且查询时长超过long_query_time，则记录日志
**log_queries_not_using_indexes** | 建议启用。不使用索引或使用全索引扫描，不论是否达到慢查询阀值的语句是否记录日志，默认OFF，即不记录
log_slow_rate_limit | 多少次查询才记录，mariadb特有
log_slow_verbosity | 记录内容

#### 通过profiling分析sql语句
```
1、默认不启用
select @@profiling;
+-------------+
| @@profiling |
+-------------+
|           0 |
+-------------+
2、开启profiling功能
set profiling=on;
3、执行sql语句
select * from testlog  where age=19999;
4、查询profiles记录
show profiles;
+----------+------------+-----------------------------------------+
| Query_ID | Duration   | Query                                   |
+----------+------------+-----------------------------------------+
|        1 | 0.00012183 | select @@profiling                      |
|        2 | 0.10885141 | select count(*) from testlog            |
|        3 | 0.00077224 | show index from students                | |
|        4 | 0.10812236 | select * from testlog  where age=19999  |
|        5 | 0.00014221 | show profiling                          |
+----------+------------+-----------------------------------------+
5、通过编号查询详细的时间过程
show profile for query 5;
+------------------------+----------+
| Status                 | Duration |
+------------------------+----------+
| Starting               | 0.000190 |
| Checking permissions   | 0.000009 |
| Opening tables         | 0.000026 |
| After opening tables   | 0.000005 |
| System lock            | 0.000004 |
| Table lock             | 0.000005 |
| Init                   | 0.000021 |
| Optimizing             | 0.000013 |
| Statistics             | 0.000016 |
| Preparing              | 0.000018 |
| Executing              | 0.000003 |
| Sending data           | 0.107752 |
| End of update loop     | 0.000014 |
| Query end              | 0.000003 |
| Commit                 | 0.000004 |
| Closing tables         | 0.000003 |
| Unlocking tables       | 0.000002 |
| Closing tables         | 0.000008 |
| Starting cleanup       | 0.000002 |
| Freeing items          | 0.000006 |
| Updating status        | 0.000017 |
| Reset for next command | 0.000002 |
+------------------------+----------+
```

### 二进制日志binary log
- 二进制日志：  
记录导致数据改变或潜在导致数据改变的SQL语句   
记录已提交的日志   
不依赖于存储引擎类型    
功能：通过“重放”日志文件中的事件来生成数据副本 
- 中继日志：**relay log**  
主从复制架构中，从服务器用于保存从主服务器的二进制日志中读取的事件
> 注意：强烈建议开启，建议二进制日志和数据文件分开存放

#### 二进制日志记录格式
- 二进制日志记录三种格式
1. 基于“语句”记录：statement，记录语句
1. 基于“行”记录：row，记录数据，日志量较大，**建议使用此格式** 
1. 混合模式：mixed, 让系统自行判定该基于哪种方式进行  
> 格式配置 
show variables like 'binlog_format';
- 二进制日志文件的构成
有两类文件   
**日志文件**：mysql|mariadb-bin.文件名后缀，二进制格式
如： mariadb-bin.000001  
**索引文件**：mysql|mariadb-bin.index，文本格式  

#### 二进制日志相关的服务器变量：
**建议启用并将二进制日志和数据库文件分开存放**  
**指定日志记录格式为row行记录**  

选项 | 说明
---|---
**sql_log_bin** | 是否记录二进制日志，默认ON
**log_bin** | 指定文件位置；默认OFF，表示不启用二进制日志功能，上述两项都开启才可以启用
**binlog_format**|STATEMENT\|ROW\|MIXED，二进制日志记录的格式
max_binlog_size | 单个二进制日志文件的最大体积，到达最大值会自动滚动，默认为1G
sync_binlog|设定是否启动二进制日志即时同步磁盘功能，默认0，由操作系统负责同步日志到磁盘
expire_logs_days|二进制日志可以自动删除的天数。默认为0，即不自动删除
> set sql_log_bin=off;  
可以在导入大量数据或者还原数据时临时禁用，以免产生大量日志内容
```
修改配置文件启用二进制并指定记录格式
1、创建单独的文件夹存放二进制日志
mkdir /data/mysql/binlog
2、注意修改文件夹的权限
chown mysql.mysql /data/mysql/binlog/
3、修改配置文件
[mysqld]
log_bin=/data/mysql/binlog/mysql  #=后面要填写路径并且写明二进制文件的前缀为mysql或mariadb
binlog_format=row  #指定记录格式为row
4、重启服务
systemctl restart mariadb
```
#### 二进制日志相关配置
查看mariadb自行管理使用中的二进制日志文件列表，及大小  
`SHOW {BINARY | MASTER} LOGS;`   
查看使用中的二进制日志文件
`SHOW MASTER STATUS;`   
查看二进制文件中的指定内容   
SHOW BINLOG EVENTS [IN 'log_name'] [FROM pos] [LIMIT [offset,] row_count]  
查看日志从POS 6516开始跳过后面2个查看下面的3个记录  
`show binlog events in 'mysql-bin.000001' from 6516 limit 2,3;`

#### mysqlbinlog：二进制日志的客户端命令工具
命令格式：   
mysqlbinlog [OPTIONS] log_file…   
--start-position=# 指定开始位置   
--stop-position=#   
--start-datetime=   
--stop-datetime=    
时间格式：  
YYYY-MM-DD hh:mm:ss  
详细输出格式：  
--base64-output[=name]    
-v -vvv   
```
示例：
#规定起始点和结束点的查询
mysqlbinlog --start-position=6787 --stop-position=7527 /var/lib/mysql/mariadb-bin.000003 -v
#按照时间短查看
mysqlbinlog --start-datetime="2018-12-7 11:10:10" --stop-datetime="2018-12-7 11:35:22"  /data/mysql/binlog/mysql.000002  -vvv
```
#### 管理日志
- 清除指定二进制日志：   
PURGE { BINARY | MASTER } LOGS { TO 'log_name' | BEFORE datetime_expr }    
```
示例：
PURGE BINARY LOGS TO '-bin.000003'; #删除编号3之前的日志
PURGE BINARY LOGS BEFORE '2017-01-23'; #删除指定日期之前的日志
PURGE BINARY LOGS BEFORE '2017-03-22 09:25:30';
```
- 删除所有二进制日志，index文件重新记数   
`RESET MASTER [TO #];`    
删除所有二进制日志文件，并重新生成日志文件，文件名从#开始记数，默认从1开始，一般是master主机第一次启动时执行，MariaDB10.1.6开始支持TO #   
- 切换日志文件：   
`FLUSH LOGS;`

# 备份还原
完全备份：整个数据集   
增量备份：仅备份最近一次完全备份或增量备份（如果存在增量）以来变化的数据，备份较快，还原复杂   
差异备份：仅备份**最近一次完全备份**以来变化的数据，备份较慢，还原简单   
> 注意：二进制日志文件不应该与数据文件放在同一磁盘

冷、温、热备份   
冷备：读写操作均不可进行   
温备：读操作可执行；但写操作不可执行 #通过读锁实现   
热备：读写操作均可执行   
MyISAM：温备，不支持热备   
InnoDB：都支持   
  
## mysqldump工具
Schema和数据存储在一起、巨大的SQL语句、单个巨大的备份文件    
mysqldump工具：客户端命令，通过mysql协议连接至mysql服务器进行备份   
`mysqldump [OPTIONS] database [tables] `  #每次单独备份一个  
`mysqldump [OPTIONS] –B DB1 [DB2 DB3...]`    
`mysqldump [OPTIONS] –A [OPTIONS]`  #完整备份所有数据库 -A=--all-databases
```
第一种方式：不推荐使用
mysqldump heloodb > hellodb_bak.sql #利用重定向备份所有的sql语句，不包含数据库只包含表内容
mysql -e 'create database hellodb'  #创建相同结构的数据
mysql hellodb < hellodb_bak.sql     #指定要还原到哪个数据库

第二种方式：备份指定的数据文件
mysqldump -B hellodb > hello_bak_B.sql   #包含数据库结构和数据表内容
mysql < hellodb_bak_B.sql                #直接还原数据库及内容

mysqldump -B hellodb | xz > hellodb_bak.sql.xz  #直接备份压缩数据

第三种方式： 生产环境常用方式
mysqldump -A > hellodb_bak.sql   #备份所有数据库及内容（包含存储过程，触发器等）

使用主从复制使用--master-data=1
mysqldump -A --master-data=1 > hellodb_bak.sql  #标记备份时间点的二进制文件起始点
不使用主从复制使用--master-data=2
mysqldump -A --master-data=2 > hellodb_bak.sql  #标记备份时间点的二进制文件起始点，但加上注释，默认不启用

mysqldump -A --master-data=1 -F > hellodb_bak.sql   #刷新二进制文件，保持二进制和备份数据的同步分离，可以很方便的找到备份日期之后的二进制文件，以便还原和查询
```
选项 | 说明
---|---
**-A**， --all-databases | 备份所有数据库，含create database
**-B** , --databases db_name | 指定备份的数据库，包括create database语句
-E, --events | 备份相关的所有event scheduler
-R, --routines | 备份所有存储过程和自定义函数
--triggers | 备份表相关触发器，默认启用,用--skip-triggers，不备份触发
**--default-character-set=utf8** | 指定字符集，备份前注意确认字符集
**--master-data[=#]** | 此选项须启用二进制日志，1：所备份的数据之前加一条记录为CHANGE MASTER TO语句，非注释，不指定#，默认为1；2：记录为注释的CHANGE MASTER TO语句
**-F**, --flush-logs | 备份前滚动日志，锁定表完成后，执行flush logs命令,生成新的二进制日志文件，配合-A 或 -B 选项时，会导致刷新多次数据库。建议在同一时刻执行转储和日志刷新，可通过和--single-transaction或-x，--master-data 一起使用实现，此时只刷新一次日志
--compact | 去掉注释，适合调试，生产不使用
-d, --no-data | 只备份表结构
-t, --no-create-info | 只备份数据,不备份create table
-n,--no-create-db | 不备份create database，可被-A或-B覆盖
--flush-privileges | 备份mysql或相关时需要使用
-f, --force | 忽略SQL错误，继续执行
--hex-blob | 使用十六进制符号转储二进制列，当有包括BINARY，VARBINARY，BLOB，BIT的数据类型的列时使用，避免乱码
-q, --quick | 不缓存查询，直接输出，加快备份速度
> 备份时要指定默认字符集，mysqldump默认为utf8
```
利用for循环实现分库备份
for db in `mysql -e 'show databases' | grep -Ev '^(Database|information_schema|performance_schema)$'`;do mysqldump -B $db | gzip > $db`date +%F`.sql.gz;done

利用管道实现分库备份
mysql -e 'show databases' | grep -Ev '^(Database|information_schema|performance_schema)$' | sed -r 's@(.*)@mysqldump -B \1 | gzip > \/data\/\1`date +%F`.sql.gz@' | bash
```
## MyISAM备份
支持温备；不支持热备，所以必须先锁定要备份的库，而后启动备份操作  
锁定方法如下：   
-x,--lock-all-tables：**加全局读锁**，锁定所有库的所有表，同时加--singletransaction或--lock-tables选项会关闭此选项功能      
注意：数据量大时，可能会导致长时间无法并发访问数据库    
-l,--lock-tables：对于需要备份的每个数据库，在启动备份之前**分别锁定**其所有表，默认为on,--skip-lock-tables选项可禁用,对备份MyISAM的多个库,可能会造成数据不一致
>  myisam 推荐使用-x  -A

## InnoDB备份
支持热备，可用温备但不建议用   
**--single-transaction**   
此选项Innodb中推荐使用，不适用MyISAM，此选项会开始备份前，先执行START TRANSACTION指令开启事务  

此选项通过在单个事务中转储所有表来创建一致的快照。 仅适用于存储在支持多版本控制的存储引擎中的表（目前只有InnoDB可以）; 转储不保证与其他存储引擎保持一致。  
在进行单事务转储时，要确保有效的转储文件（正确的
表内容和二进制日志位置），没有其他连接应该使用以下语句：`ALTER TABLE，DROP TABLE，RENAME TABLE，TRUNCATE TABLE  `  
此选项和--lock-tables（此选项隐含提交挂起的事务）选项是相互排斥    
> 备份大型表时，建议将--single-transaction选项和--quick结合一起使用

# 生产环境实战备份策略
### InnoDB建议备份策略
```
mysqldump –uroot –A –F --single-transaction --master-data=2 --default-character-set=utf8 --hex-blob > $BACKUP/fullbak_$BACKUP_`data +%F`.sql
```
### MyISAM建议备份策略
```
mysqldump –uroot –A –F –x --master-data=2 --default-character-set=utf8 --hex-blob > $BACKUP/fullbak_$BACKUP_`data +%F`.sql
```
### 恢复数据库示例：
```
保证数据库文件和二进制日志文件分开存放
确认数据库字符集和存储引擎
mysql -plinux -e 'show create database hellodb'
mysql -plinux -e "show variables like 'character%'"
mysql -plinux -e 'show table status from hellodb'

1、备份原有数据库
mysqldump -plinux -A --single-transaction -F --master-data=2 | gzip > /data/all_bak_`date +%F`.sql.gz
2、模拟误删除
rm -rf /var/lib/mysql/*
3、使用防火墙禁止用户连接数据库
4、重启数据库
5、临时禁用二进制日志
set sql_log_bin=off;
show variables like 'sql_log_bin';
6、保持当前mysql会话，导入完整备份
source /data/all_bak2018-12-08.sql

MariaDB [hellodb]> select * from teachers;
+-----+--------------+-----+--------+
| TID | Name         | Age | Gender |
+-----+--------------+-----+--------+
|   4 | Lin Chaoying |  93 | F      |
|   7 | aaav         | 223 | NULL   |
|   8 | aadv         | 223 | NULL   |
+-----+--------------+-----+--------+

7、另开一SSH窗口，查看完整备份，查找二进制日志起始点还原
cat /data/all_bak2018-12-08.sql |less
--CHANGE MASTER TO MASTER_LOG_FILE='mysql.000013', MASTER_LOG_POS=377;
8、另开一SSH窗口，确认二进制日志的位置，并且将后续所有日志导入到增量sql文件
mysqlbinlog /data/mysql/binlog/mysql.000013 --start-position=377 > incr.sql
mysqlbinlog /data/mysql/binlog/mysql.000014 >> incr.sql
9、回到保持打开的mysql会员，还原二进制日志
MariaDB [hellodb]> source /root/incr.sql;

MariaDB [hellodb]> select * from teachers;
+-----+--------------+-----+--------+
| TID | Name         | Age | Gender |
+-----+--------------+-----+--------+
|   4 | Lin Chaoying |  93 | F      |
|   7 | aaav         | 223 | NULL   |
|   8 | aadv         | 223 | NULL   |
|   9 | aagq         |  67 | NULL   |
|  10 | jk           |  67 | NULL   |
+-----+--------------+-----+--------+
10、开启二进制日志，还原防火墙，允许用户访问
set sql_log_bin=on;
```
# xtrabackup
percona提供的mysql数据库备份工具，惟一开源的能够对innodb和xtradb数据库进行热备的工具   
特点：   
备份还原过程快速、可靠   
备份过程不会打断正在执行的事务   
能够基于压缩等功能节约磁盘空间和流量   
自动实现备份检验   
开源，免费   

xtrabackup安装：   
yum install percona-xtrabackup 在EPEL源中   
最新版本下载安装：   
https://www.percona.com/downloads/XtraBackup/LATEST/

## xtrabackup用法
### 备份：innobackupex [option] BACKUP-ROOT-DIR   
选项说明：https://www.percona.com/doc/percona-xtrabackup/LATEST/genindex.html

选项 | 说明
---|---
--user | 备份账号
--password | 备份的密码
--host | 数据库的地址
--databases | 数据库名，如果要指定多个数据库，彼此间需要以**空格隔开**；如："xtra_test dba_test"，同时，在指定某数据库时，也可以只指定其中的某张表。如："mydatabase.mytable"。该选项对innodb引擎表无效，还是会备份所有innodb表
--defaults-file | 从哪个文件读取MySQL配置，必须放在命令行第一个选项位置
--incremental | 创建一个增量备份，需要指定--incremental-basedir
--incremental-basedir | **指定为前一次全备份或增量备份的目录**，与--incremental同时使用
--incremental-dir | 还原时增量备份的目录
--include=name | 表名，格式：databasename.tablename

### 整理Prepare：innobackupex --apply-log [option] BACKUP-DIR

选项 | 说明
---|---
**--apply-log** | 一般情况下,在备份完成后，数据尚且不能用于恢复操作，因为备份的数据中可能会包含尚未提交的事务或已经提交但尚未同步至数据文件中的事务。因此，此时数据文件仍处理不一致状态。此选项作用是**通过回滚未提交的事务及同步已经提交的事务至数据文件使数据文件处于一致性状态**
--use-memory | 和--apply-log选项一起使用，当prepare 备份时，做crash recovery分配的内存大小，单位字节，也可1MB,1M,1G,1GB等，推荐1G
--export | 表示开启可导出单独的表之后再导入其他Mysql中
**--redo-only** |一般写在增量文件还原中， 写在非最后一个备份文件的选项，**不回滚未完成的事务或查询操作**，避免出现数据破坏 

### 还原：innobackupex --copy-back [选项] BACKUP-DIR
innobackupex --move-back [选项] [--defaults-group=GROUP-NAME]
BACKUP-DIR
选项 | 说明
---|---
--copy-back | 做数据恢复时将备份数据文件拷贝到MySQL服务器的datadir
--move-back | 这个选项与--copy-back相似，唯一的区别是它不拷贝文件，而是移动文件到目的地。这个选项移除backup文件，用时候必须小心。使用场景：没有足够的磁盘空间同事保留数据文件和Backup副本

#### 还原注意事项
1. datadir **目录必须为空**。除非指定innobackupex --force-non-emptydirectorires选项指定，否则--copy-backup选项不会覆盖
2. 在restore之前,**必须shutdown MySQL实例**，不能将一个运行中的实例
restore到datadir目录中
3. 由于文件属性会被保留，大部分情况下需要在启动实例之前将文件的**属主改为mysql**，这些文件将属于创建备份的用户   
`chown -R mysql:mysql /data/mysql`   
以上需要在用户调用innobackupex之前完成   
--force-non-empty-directories：指定该参数时候，使得innobackupex --copy-back或--move-back选项转移文件到非空目录，已存在的文件不会被覆盖。   
如果--copy-back和--move-back文件需要从备份目录拷贝一个在datadir已经存在的文件，会报错失败

## 备份生成的相关文件
1. xtrabackup_info：innobackupex工具执行时的相关信息，包括版本，备份选项，备份时长，备份LSN(log sequence number日志序列号)，BINLOG的位置
1. xtrabackup_checkpoints：备份类型（如完全或增量）、备份状态（如是否已经为prepared状态）和LSN范围信息,每个InnoDB页(通常为16k大小)都会包含一个日志序列号LSN。**LSN是整个数据库系统的系统版本号，每个页面相关的LSN能够表明此页面最近是如何发生改变的**
1. xtrabackup_binlog_info：MySQL服务器当前正在使用的二进制日志文件及至备份这一刻为止二进制日志事件的位置，可利用实现基于binlog的恢复
1. backup-my.cnf：备份命令用到的配置选项信息
1. xtrabackup_logfile：备份生成的日志文件

## 备份还原示例
#### 新版xtrabackup完整备份还原
```
1、在数据库服务器完整备份
xtrabackup --backup --target-dir=/data/db_backup
2、将备份下来的目录拷贝到需要还原的主机
scp -r /data/db_backup/ 192.168.34.7:/data
3、预准备：确保数据一致，提交完成的事务，回滚未完成的事务
xtrabackup --prepare --target-dir=/data/db_backup
4、复制到数据库目录
 注意：数据库目录必须为空，MySQL服务不能启动
 xtrabackup --copy-back --target-dir=/data/db_backup
5、确保备份文件属性
chown -R mysql.mysql /var/lib/mysql
6、启动服务验证
systemctl start mariadb
```
#### 新版xtrabackup完全，增量备份及还原
```
1 备份过程
 1）完全备份：xtrabackup --backup --target-dir=/data/db_backup/base/
 2）第一次修改数据
 3）第一次增量备份到完整备份目录
 xtrabackup --backup --target-dir=/data/db_backup/inc1/ --incremental-basedir=/data/db_backup/base
 4）第二次修改数据
 5）第二次增量备份到第一次增量备份目录
 xtrabackup --backup --target-dir=/data/db_backup/inc2/ --incremental-basedir=/data/db_backup/inc1
 6）scp -r /data/db_backup/ 192.168.34.7:/data/
2还原过程
1）预准备完成备份，此选项--apply-log-only 阻止回滚未完成的事务
xtrabackup --prepare --apply-log-only --target-dir=/data/db_backup/base
2）合并第1次增量备份到完全备份
xtrabackup --prepare --apply-log-only --target-dir=/data/db_backup/base --incremental-dir=/data/db_backup/inc1
3）合并第2次增量备份到完全备份：最后一次还原不需要加选项--apply-log-only
xtrabackup --prepare --target-dir=/data/db_backup/base --incremental-dir=/data/db_backup/inc2
4）复制到数据库目录，注意数据库目录必须为空，MySQL服务不能启动
xtrabackup --copy-back --target-dir=/data/db_backup/base
5）还原属性：chown -R mysql.mysql /var/lib/mysql
6）启动服务：systemctl start mariadb
```
#### 旧版xtrabackup完全，增量备份及还原
```
1 在原主机
innobackupex /backups
mkdir /backups/inc{1,2}
修改数据库内容
innobackupex --incremental /backups/inc1 --incrementalbasedir=/backups/2018-02-23_14-21-42（完全备份生成的路径）
再次修改数据库内容
innobackupex --incremental /backups/inc2 --incrementalbasedir=/backups/inc1/2018-02-23_14-26-17
（上次增量备份生成的路径）
scp -r /backups/* 目标主机:/data/
2 在目标主机
不启动mariadb
rm -rf /var/lib/mysql/*
innobackupex --apply-log --redo-only   /data/2018-02-23_14-21-42/  #--redo-only阻止回滚事务
innobackupex --apply-log --redo-only /data/2018-02-23_14-21-42/ --incremental-dir=/data/inc1/2018-02-23_14-26-17
innobackupex --apply-log /data/2018-02-23_14-21-42/ --incrementaldir=/data/inc2/2018-02-23_14-28-29/
ls /var/lib/mysql/  #最后一次不需加--redo-only
innobackupex --copy-back /data/2018-02-23_14-21-42/
chown -R mysql.mysql /var/lib/mysql/
systemctl start mariadb
```

# MySQL复制
扩展方式： Scale Up（纵向扩展） ，Scale Out（横向扩展）   
- MySQL的扩展   
读写分离   
复制：每个节点都有相同的数据集   
向外扩展   
**二进制日志**   
单向   
- 复制的功用：   
 数据分布   
 负载均衡读   
 备份   
 高可用和故障切换   
 MySQL升级测试   

# MySQL复制
主从复制线程：      
- 主节点：   
dump Thread：为每个Slave的I/O
Thread启动一个dump线程，用于向其发送binary log events  
- 从节点：  
I/O Thread：向Master请求二进制日志事件，并保存于中继日志中     
SQL Thread：从中继日志中读取日志事件，在本地完成重放
- 跟复制功能相关的文件：      
master.info：用于保存slave连接至master时的相关信息，例如账号、密码、服务器地址等      
relay-log.info：保存在当前slave节点上已经复制的当前二进制日志和本地replay log日志的对应关系      
> 主从配置过程：参看官网   
 https://mariadb.com/kb/en/library/setting-up-replication/   
 https://dev.mysql.com/doc/refman/5.5/en/replication-configuration.html   

## 主从复制配置
### 主节点
主节点配置：   
1. 启用二进制日志   
 [mysqld]   
 `log_bin`   
1. 为当前节点设置一个全局惟一的ID号   
 [mysqld]   
 `server_id=#`   
1. 创建有复制权限的用户账号    
`GRANT REPLICATION SLAVE ON *.* TO 'repluser'@'HOST' IDENTIFIED BY
'replpass';`
### 从节点
从节点配置：   
1. 启动中继日志 
```
[mysqld]     
server_id=#  #为当前节点设置一个全局惟的ID号   
read_only=ON #设置数据库只读  
```
2. 使用有复制权限的用户账号连接至主服务器，并启动复制线程
```
mysql> CHANGE MASTER TO MASTER_HOST='host',                       #主节点IP
       MASTER_USER='repluser', 
       MASTER_PASSWORD='replpass',                                #连接主节点用户和密码
       MASTER_LOG_FILE=' mariadb-bin.xxxxxx', 
       MASTER_LOG_POS=#;                                          #指定要同步的二进制文件和起始点
mysql> START SLAVE [IO_THREAD|SQL_THREAD];                        #开启从服务线程
```
#### 一主一从示例：
```
主节点:
vim /etc/my.cnf
[mysqld]
server-id=1
log-bin=/data/binlog/mysql
binlog_format=row
创建授权用户
MariaDB [(none)]> grant replication slave on *.* to repuser@'192.168.34.%' identified by 'linux';

从节点：
修改配置文件:
vim /etc/my.cnf
[mysqld]
server-id=2
read-only=on
设置mysql slave服务
help change master to; #通过帮助查看slave系统命令
  CHANGE MASTER TO
  MASTER_HOST='192.168.34.8',      #主服务IP
  MASTER_USER='repuser',           #同步授权账户
  MASTER_PASSWORD='linux',         #账户密码
  MASTER_PORT=3306,                #mariadb端口
  MASTER_LOG_FILE='mysql.000001',  #想使用的二进制文件
  MASTER_LOG_POS=245;              #此二进制文件同步的起始点

启动slave进程
start slave
查看slave进程状态
show slave status\G  
```
#### 扩展已有的主节点，到新增的从节点
如果主节点已经运行了一段时间，且有大量数据时，如何配置并启动slave节点
```
1、通过备份主节点的数据还原到新增的从节点主机
mysqldump -A -F --single-transaction --master-data=1 > /data/all_bak`date +%F`.sql
2、将备份文件拷贝到新从节点
scp /data/all_bak2018-12-09.sql 192.168.34.9:/data/
3、修改编辑备份文件，将主从配置写入
利用原有--master-data生成的内容，添加以下内容
vim /data/all_bak2018-12-09.sql
  CHANGE MASTER TO
  MASTER_HOST='192.168.34.8',
  MASTER_USER='repuser',
  MASTER_PASSWORD='linux',
  MASTER_PORT=3306,
  MASTER_LOG_FILE='mysql.000002', MASTER_LOG_POS=245;  
4、导入数据库文件
mysql < /data/all_bak2018-12-09.sql
5、开启slave进程，验证同步
MariaDB [(none)]> start slave;
```
#### 手动提升从节点，切换主从复制
```
当主节点服务器发生故障，需要临时切换一个从节点为主节点
1、清楚原有的从节点信息
MariaDB [(none)]> stop slave;         #需要先停止slave进程
MariaDB [(none)]> reset slave all;    #清楚原有slave信息
2、修改要提升的从服务器mysql配置文件
vim /etc/my.cnf
[mysqld]
server-id=2
#read-only=on          #禁用只读
binlog_format=row      #采用行存储二进制 
log-bin                #启用二进制日志
重启服务
systemctl restart mariadb
3、在其它从节点上配置新的主节点信息
1）清理原有的slave信息
MariaDB [(none)]> stop slave;         #需要先停止slave进程
MariaDB [(none)]> reset slave all;    #清楚原有slave信息
2）在新的主节点上查看二进制日志信息，确定要同步的起始点
MariaDB [(none)]> show master logs;
+--------------------+-----------+
| Log_name           | File_size |
+--------------------+-----------+
| mariadb-bin.000001 |       264 |
| mariadb-bin.000002 |       245 |
+--------------------+-----------+
3）添加主节点配置信息
CHANGE MASTER TO
  MASTER_HOST='192.168.34.7',
  MASTER_USER='repuser',
  MASTER_PASSWORD='linux',
  MASTER_PORT=3306,
  MASTER_LOG_FILE='mariadb-bin.000002',
  MASTER_LOG_POS=245;
4）启动slave进程
MariaDB [(none)]> start slave;
4、验证同步情况
注意新主节点的防火墙配置
```
#### 启用级联复制节点
```
1、主节点配置不需更改
2、修改中间节点配置
vim /etc/my.cnf
[mysqld]
server-id=2
log-bin            #启用二进制
read-only          #从节点建议启用                                                          
log-slave-updates  #中间节点必须启动此选项
3、次级联节点配置
vim /etc/my.cnf
[mysqld]
server-id=3
read-only
需要将主节点信息指向中间节点
CHANGE MASTER TO
  MASTER_HOST='192.168.34.9',            #中间节点IP
  MASTER_USER='repuser',
  MASTER_PASSWORD='linux',
  MASTER_PORT=3306,
  MASTER_LOG_FILE='mariadb-bin.000001',  #中间节点的二进制日志
  MASTER_LOG_POS=245;                    #中间节点的二进制起始点
start slave;
4、验证同步情况
```
#### 主从复制中的错误排查
```
MariaDB [(none)]> show slave status\G
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.34.7
                  Master_User: repuser
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mariadb-bin.000002
          Read_Master_Log_Pos: 488                          #查看已读到的主节点二进制日志信息
               Relay_Log_File: mariadb-relay-bin.000007
                Relay_Log_Pos: 531
        Relay_Master_Log_File: mariadb-bin.000002
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
              Replicate_Do_DB: 
          Replicate_Ignore_DB: 
           Replicate_Do_Table: 
       Replicate_Ignore_Table: 
      Replicate_Wild_Do_Table: 
  Replicate_Wild_Ignore_Table: 
                   Last_Errno: 0
                   Last_Error: 
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 407                          #目前执行的二进制信息
              Relay_Log_Space: 908
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: 4462                         #与主节点同步的时间间隔
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 2

以上3点是查看同步情况是否成功的主要信息
如遇到错误，可以使用
sql_slave_skip_counter = N #N代表想要跳过的错误数量
```
### 复制架构中应该注意的问题：
1. **限制从服务器为只读**
在从服务器上设置read_only=ON
> 注意：此限制对拥有SUPER权限的用户均无效
2. RESET SLAVE
在从服务器清除master.info ，relay-log.info, relay log ，开始新的relaylog 
> 注意：需要先STOP SLAVE
3. **RESET SLAVE ALL** 清除所有从服务器上设置的主服务器同步信息如：
PORT, HOST, USER和 PASSWORD 等
4. **sql_slave_skip_counter = N** 从服务器忽略几个主服务器的复制事件，
global变量
> 修改中间节点的数据与主服务器冲突会影响后续的同步，启用此选项可以忽略某几项冲突
5. 如何保证主从复制的事务安全    
参看https://mariadb.com/kb/en/library/server-system-variables/   
- 在master节点启用参数：   
`sync_binlog=1` 每次写后立即同步二进制日志到磁盘，性能差   
如果用到的为InnoDB存储引擎：   
`innodb_flush_log_at_trx_commit=1` 每次事务提交立即同步日志写磁盘   
`innodb_support_xa=ON` 默认值，分布式事务MariaDB10.3.0废除   
`sync_master_info=#` #次事件后master.info同步到磁盘  #启用之后可以集中同步推送
- 在slave节点启用服务器选项：   
`skip_slave_start=ON` #不自动启动slave   #默认为false  除第一次手动启动外，后续自动启动
- 在slave节点启用参数：   
`sync_relay_log=#` #次写后同步relay log到磁盘   
`sync_relay_log_info=#` #次事务后同步relay-log.info到磁盘   

## 主主复制
主主复制：互为主从
考虑要点：自动增长id  
-  配置一个节点使用奇数id   
 auto_increment_offset=1   #开始点   
 auto_increment_increment=2 #增长幅度  
-  另一个节点使用偶数id  
 auto_increment_offset=2  
 auto_increment_increment=2  
> 容易产生的问题：数据不一致；因此慎用 
- 主主复制的配置步骤：  
(1) 各节点使用一个惟一server_id  
(2) 都启动binary log和relay log  
(3) 创建拥有复制权限的用户账号  
(4) 定义自动增长id字段的数值范围各为奇偶  
(5) 均把对方指定为主节点，并启动复制线程  
 
##  半同步复制
半同步复制实现：  
默认情况下，MySQL的复制功能是异步的，异步复制可以提供最佳的性能，主库把binlog日志发送给从库即结束，并不验证从库是否接收完毕。
```
主节点：
1、安装半同步插件
INSTALL PLUGIN rpl_semi_sync_master SONAME 'semisync_master.so';
2、修改配置文件启用插件
vim /etc/my.cnf
[mysqld]
server-id=1
log-bin=/data/binlog/mysql
binlog_format=row
rpl_semi_sync_master_enabled
rpl_semi_sync_master_timeout = 2000  #超时时长2s
3、验证插件开启情况
MariaDB [(none)]> SHOW GLOBAL VARIABLES LIKE '%semi%';
MariaDB [(none)]> SHOW GLOBAL STATUS LIKE '%semi%';

从节点：
1、安装插件
INSTALL PLUGIN rpl_semi_sync_slave SONAME 'semisync_slave.so';
2、修改配置文件，启用插件
vim /etc/my.cnf
[mysqld]
server-id=2
read-only=on
binlog_format=row
rpl_semi_sync_slave_enabled 
3、验证插件开启情况
MariaDB [(none)]> select @@rpl_semi_sync_slave_enabled;
MariaDB [(none)]> SHOW GLOBAL VARIABLES LIKE '%semi%';
4、重启slave线程
MariaDB [(none)]> stop slave;
MariaDB [(none)]> start slave;

验证同步
只要有一个从节点同步成功，就返回成功
如果所有从节点都出现故障，会利用rpl_semi_sync_master_timeout来判断超时。
```
## 复制过滤器
从服务器SQL_THREAD在replay中继日志中的事件时，仅读取与特定数据库(特定表)相关的事件并应用于本地  
> 问题：会造成网络及磁盘IO浪费   

从服务器上的复制过滤器相关变量   
replicate_do_db= 指定复制库的白名单   
replicate_ignore_db= 指定复制库黑名单   
replicate_do_table= 指定复制表的白名单   
replicate_ignore_table= 指定复制表的黑名单   
replicate_wild_do_table= foo%.bar% 支持通配符   
replicate_wild_ignore_table=  
```
利用过滤器来指定数据库同步
修改从节点配置文件
vim /etc/my.cnf
[mysqld]
server-id=2
read-only=on
binlog_format=row
rpl-semi-sync-slave-enabled
replicate_do_db=hellodb   #指定要同步的数据库白名单
重启服务
systemctl restart mariadb

验证只有hellodb内容可以同步，其它数据库不同步
```
# MySQL复制加密
基于SSL复制：    
在默认的主从复制过程或远程连接到MySQL/MariaDB所有的链接通信中的数据都是明文的，外网里访问数据或则复制，存在安全隐患。通过SSL/TLS加密的
方式进行复制的方法，来进一步提高数据的安全性
- 配置实现：
参看：https://mariadb.com/kb/en/library/replication-with-secureconnections/
1. 主服务器开启SSL：[mysqld] 加一行ssl   
主服务器配置证书和私钥；并且创建一个要求必须使用SSL连接的复制账号
1. 从服务器使用CHANGER MASTER TO 命令时指明ssl相关选项
```
创建必要证书文件
1、创建ssl相关文件存放的文件夹
mkdir /etc/my.cnf.d/ssl
2、生成主节点的私钥
(umask 066;openssl genrsa 2048 > cakey.pem)
3、利用私钥生成CA证书
openssl req -new -x509 -key cakey.pem -out cacert.pem -days 3650
4、利用CA证书申请主节点私钥及证书申请文件 
openssl req -newkey rsa:2048 -days 365 -nodes -keyout master.key > master.csr  #nodes生成私钥不加密
5、利用CA证书申请从节点私钥及证书申请文件
openssl req -newkey rsa:2048 -days 365 -nodes -keyout slave.key > slave.csr
6、利用CA证书签名主节点证书
openssl x509 -req -in master.csr -CA cacert.pem -CAkey cakey.pem -set_serial 01 > master.crt  #-set_serial指定序列号
利用CA证书签名从节点证书
openssl x509 -req -in slave.csr -CA cacert.pem -CAkey cakey.pem -set_serial 02 > slave.crt
7、将CA证书、从节点私钥及证书拷贝到从节点主机
scp cacert.pem slave.crt slave.key 192.168.34.7:/etc/my.cnf.d/ssl/
scp cacert.pem slave.crt slave.key 192.168.34.9:/etc/my.cnf.d/ssl/

配置主从节点加密
1、修改主节点配置文件
vim /etc/my.cnf
[mysqld]
server-id=1
log-bin=/data/binlog/mysql
binlog_format=row
rpl_semi_sync_master_enabled
rpl_semi_sync_master_timeout = 2000
ssl-ca=/etc/my.cnf.d/ssl/cacert.pem     #指向CA证书
ssl-cert=/etc/my.cnf.d/ssl/master.crt   #指向主节点证书
ssl-key=/etc/my.cnf.d/ssl/master.key    #指向主节点私钥
验证ssl启用状态
MariaDB [test]> show variables like '%ssl%';
2、授权只能用于ssl登录的账户
grant replication slave on *.* to rplssl@'192.168.34.%' identified by 'linux' require ssl;
3、修改从节点slave配置信息
清楚原有slave配置信息
MariaDB [(none)]> stop slave;
MariaDB [(none)]> start slave;
CHANGE MASTER TO
  MASTER_HOST='192.168.34.8',
  MASTER_USER='repuser',
  MASTER_PASSWORD='linux',
  MASTER_PORT=3306,
  MASTER_LOG_FILE='mysql.000008',                   #需要在主节点确认最新的二进制文件
  MASTER_LOG_POS=501,                               #在主节点二进制文件的起始点
  MASTER_SSL=1,                                     #启用ssl
  MASTER_SSL_CA = '/etc/my.cnf.d/ssl/cacert.pem',   #指定本地的CA证书
  MASTER_SSL_CERT = '/etc/my.cnf.d/ssl/slave.crt',  #指定本地slave节点证书
  MASTER_SSL_KEY = '/etc/my.cnf.d/ssl/slave.key';   #指定本地slave私钥
4、启动slave线程
start slave；

验证主从同步
```
## 主从同步的监控和维护
1. 日志文件  
清理到5之前的日志文件  
`purge master logs to 'mysql.000005';`  
清理所有二进制文件，重头开始  
`reset master;`  
清理slave线程的状态，重新开始同步  
`reset slave;`
2. 复制监控  
查看二进制日志的最近一个使用情况  
`SHOW MASTER STATUS;`  
查看二进制日志的详细内容  
`SHOW BINLOG EVENTS;`  
查看所有二进制文件  
`SHOW MASTER LOGS;`  
查看从节点同步状态  
`SHOW SLAVE STATUS\G`   
查看mysql进程信息  
`SHOW PROCESSLIST;`
3. 从服务器是否落后于主服务  
`Seconds_Behind_Master: 0`
4. 如何确定主从节点数据是否一致   
percona-tools   
5. 数据不一致如何修复   
删除从数据库，重新复制 

# MySQL读写分离
读写分离应用：  
mysql-proxy：Oracle，https://downloads.mysql.com/archives/proxy/  
Atlas：Qihoo，https://github.com/Qihoo360/Atlas/blob/master/README_ZH.md   
dbproxy：美团，https://github.com/Meituan-Dianping/DBProxy   
Cetus：网易乐得，https://github.com/Lede-Inc/cetus   
Amoeba：https://sourceforge.net/projects/amoeba/   
Cobar：阿里巴巴，Amoeba的升级版   
Mycat：基于Cobar， http://www.mycat.io/   
ProxySQL：https://proxysql.com/   

## ProxySQL
ProxySQL组成   
服务脚本：/etc/init.d/proxysql  
配置文件：/etc/proxysql.cnf  
主程序：/usr/bin/proxysql  
**准备：实现读写分离前，先实现主从复制**   
> 注意：slave节点需要设置read_only=1
### 安装proxysql服务器
1. 基于YUM仓库安装
```
cat <<EOF | tee /etc/yum.repos.d/proxysql.repo
[proxysql_repo]
name= ProxySQL YUM repository
baseurl=http://repo.proxysql.com/ProxySQL/proxysql-1.4.x/centos/\$releasever
gpgcheck=1
gpgkey=http://repo.proxysql.com/ProxySQL/repo_pub_key
EOF
重新生成仓库列表中的内容
yum repolist
利用yum安装
yum install proxysql
```
2. 启动服务  
启动ProxySQL：systemctl proxysql start   
启动后会监听两个默认端口   
6032：ProxySQL的管理端口   
6033：ProxySQL对外提供服务的端口   
### 配置proxysql
使用管理端口连接
使用mysql客户端连接到ProxySQL的管理接口6032，默认管理员用户和密码都是admin：   
`mysql -uadmin -padmin -P6032 -h127.0.0.1`
> 说明：在main和monitor数据库中的表， runtime_开头的是运行时的配置，不能修改，只能修改非runtime_表，修改后必须执行LOAD … TO RUNTIME才能加载到RUNTIME生效，执行save … to disk将配置持久化保存到磁盘
#### 添加主从mysql节点
1. 添加现有mysql服务器到mysql_servers表中
```
MySQL [main]> insert into mysql_servers(hostgroup_id,hostname,port) values(10,'192.168.34.8',3306);
MySQL [main]> insert into mysql_servers(hostgroup_id,hostname,port) values(10,'192.168.34.7',3306);
MySQL [main]> insert into mysql_servers(hostgroup_id,hostname,port) values(10,'192.168.34.9',3306);
```
2. 查看表中添加的状态   
`MySQL [main]> select * from main.mysql_servers;`  
3. 将mysql_servers表中的内容添加到runtime表中   
`MySQL [main]> load mysql servers to runtime;`   
4. 将mysql_servers表中的内容写入到磁盘   
`MySQL [main]> save mysql servers to disk;`
#### 配置监控账户
1. 在mysql主节点上授权创建监控账户
`grant replication client on *.* to monitor@'192.168.34.%' identified by 'linux';`  
2. 回到proxysql服务器中添加账户到系统中
```
MySQL [main]> set mysql-monitor_username='monitor';
MySQL [main]> set mysql-monitor_password='linux';
MySQL [main]> load mysql variables to runtime;
MySQL [main]> save mysql variables to disk;
```
#### 查看已配置的节点是否正常
监控模块的指标保存在monitor库的log表中   
1. 查看监控连接是否正常的(对connect指标的监控)：(如果connect_error的结果为NULL则表示正常)   
`MySQL [main]> select * from mysql_server_connect_log;`  
1. 查看监控心跳信息 (对ping指标的监控)：  
`MySQL [main]> select * from mysql_server_ping_log;`  
1. 查看read_only和replication_lag的监控日志   
`MySQL [main]> select * from mysql_server_read_only_log;`  
`MySQL [main]> select * from mysql_server_replication_lag_log;`
#### 设置proxysql分组信息
需要修改的是main库中的mysql_replication_hostgroups表，该表有3个字段：   
writer_hostgroup，reader_hostgroup，comment   
指定写组的id为10，读组的id为20   
1. 创建新的分组信息
```
MySQL [main]> insert into mysql_replication_hostgroups values(10,20,'web_mysql');

MySQL [main]> select * from mysql_replication_hostgroups;
+------------------+------------------+-----------+
| writer_hostgroup | reader_hostgroup | comment   |
+------------------+------------------+-----------+
| 10               | 20               | web_mysql |
+------------------+------------------+-----------+
```
2. 将分组信息写入RUNTIME生效   
`load mysql servers to runtime;`   
3. 将分组信息表中的写入到磁盘   
`save mysql servers to disk;`   
4. Monitor模块监控后端的read_only值，按照read_only的值将节点自动移动到读/写组
```
MySQL [main]> select hostgroup_id,hostname,port,status,weight from mysql_servers; 
+--------------+--------------+------+--------+--------+
| hostgroup_id | hostname     | port | status | weight |
+--------------+--------------+------+--------+--------+
| 10           | 192.168.34.8 | 3306 | ONLINE | 1      |
| 20           | 192.168.34.9 | 3306 | ONLINE | 1      |
| 20           | 192.168.34.7 | 3306 | ONLINE | 1      |
+--------------+--------------+------+--------+--------+
```
#### 创建在集群中发送SQL语句的用户
1. 在主节点上创建访问用户   
`grant all on *.* to sqluser@'192.168.34.%' identified by 'linux';`
2. 返回proxysql服务器将此用户加入到mysql_users表中
`insert into mysql_users(username,password,default_hostgroup) values('sqluser','linux',10);`
3. 将用户表的修改写入RUNTIME生效  
`load mysql users to runtime;`  
4. 将用户表中的内容写入到磁盘   
`save mysql users to disk;`
5. 验证用户是否可以读写  
```
[root@7 ~]# mysql -usqluser -plinux -P6033 -h127.0.0.1 -e 'select @@server_id'
+-------------+
| @@server_id |
+-------------+
|           1 |
+-------------+
[root@7 ~]# mysql -usqluser -plinux -P6033 -h127.0.0.1 -e 'create database db7'
```
#### 配置proxysql路由规则，实现读写分离
与规则有关的表：mysql_query_rules和mysql_query_rules_fast_routing，后者是前者的扩展表，1.4.7之后支持   
1. 插入路由规则：将select语句分离到20的读组，select语句中有一个特殊语句SELECT...FOR UPDATE它会申请写锁，应路由到10的写组
`insert into mysql_query_rules (rule_id,active,match_digest,destination_hostgroup,apply) VALUES(1,1,'^SELECT.*FOR UPDATE$',10,1),(2,1,'^SELECT',20,1);`
> 注意：因ProxySQL根据rule_id顺序进行规则匹配，select ... for update规则的
rule_id必须要小于普通的select规则的rule_id,此处规则ID为1
2. 将规则表的修改写入RUNTIME生效   
`load mysql query rules to runtime;`   
3. 将规则表中的内容写入到磁盘   
`save mysql query rules to disk;`   
### 测试读写分离
在proxysql服务器执行测试
```
测试查询是否分离并负载均衡
[root@7 ~]# mysql -usqluser -plinux -P6033 -h127.0.0.1 -e 'select @@server_id'
+-------------+
| @@server_id |
+-------------+
|           2 |
+-------------+
[root@7 ~]# mysql -usqluser -plinux -P6033 -h127.0.0.1 -e 'select @@server_id'
+-------------+
| @@server_id |
+-------------+
|           3 |
+-------------+

测试写入数据库
[root@7 ~]# mysql -usqluser -plinux -P6033 -h127.0.0.1 -e 'create table db7.t1(id int,name char(10))'
[root@7 ~]# mysql -usqluser -plinux -P6033 -h127.0.0.1 -e 'insert db7.t1 (id,name)values(1,"one")'
路由的信息：查询stats库中的stats_mysql_query_digest表
MySQL [main]> SELECT hostgroup hg,sum_time, count_star, digest_text FROM
    -> stats_mysql_query_digest ORDER BY sum_time DESC;  #利用查询时间来降序排列
+----+----------+------------+------------------------------------------+
| hg | sum_time | count_star | digest_text                              |
+----+----------+------------+------------------------------------------+
| 20 | 10005    | 11         | select @@server_id                       |
| 10 | 7630     | 1          | create table db7.t1(id int,name char(?)) |
| 10 | 4661     | 8          | select @@server_id                       |
| 10 | 3388     | 5          | begin                                    |
| 10 | 2520     | 1          | insert db7.t1 (id,name)values(?,?)       |
| 10 | 1696     | 5          | commit                                   |
| 10 | 1096     | 1          | create database db7                      |
| 10 | 911      | 1          | show databases                           |
| 10 | 856      | 1          | insert db7.t1 (id,name)values(?,one)     |
| 10 | 831      | 1          | show tables                              |
+----+----------+------------+------------------------------------------+
```

# MySQL高可用MHA
MHA工作原理
1. 从宕机崩溃的master保存二进制日志事件（binlog events）
2. 识别含有最新更新的slave
3. 应用差异的中继日志（relay log）到其他的slave
4. 应用从master保存的二进制日志事件（binlog events）
5. 提升一个slave为新的master
6. 使其他的slave连接新的master进行复制

MHA软件由两部分组成，Manager工具包和Node工具包   
Manager工具包主要包括以下几个工具：   
- masterha_check_ssh 检查MHA的SSH配置状况
- masterha_check_repl 检查MySQL复制状况
- masterha_manger 启动MHA
- masterha_check_status 检测当前MHA运行状态
- masterha_master_monitor 检测master是否宕机
- masterha_master_switch 故障转移（自动或手动）
- masterha_conf_host 添加或删除配置的server信息
> 注意：为了尽可能的减少主库硬件损坏宕机造成的数据丢失，因此在配置MHA的同时建议MYSQL配置半同步复制

## 配置MHA
### 安装MHA相关软件包
1. 在MHA管理服务器上安装Manager工具包和Node工具包  
下载需要的安装包  
`wget https://github.com/linyue515/mysql-master-ha/raw/master/mha4mysql-manager-0.57-0.el7.noarch.rpm`  
`wget https://github.com/linyue515/mysql-master-ha/raw/master/mha4mysql-node-0.57-0.el7.noarch.rpm`  
检查epel源的安装，安装manager包需要解决依赖关系    
`yum install epel-release ` 
安装两个软件包   
`yum install -y mha4mysql*`
2. 在从节点上安装Node工具包   
下载需要的安装包   
wget https://github.com/linyue515/mysql-master-ha/raw/master/mha4mysql-node-0.57-0.el7.noarch.rpm   
安装node包   
yum install mha4mysql-node-0.57-0.el7.noarch.rpm   
### 修改mysql主从节点的配置文件
```
主节点：
vim /etc/my.cnf
[mysqld]
server-id=1
log-bin=/data/binlog/mysql
binlog_format=row
rpl_semi_sync_master_enabled
rpl_semi_sync_master_timeout = 2000
ssl-ca=/etc/my.cnf.d/ssl/cacert.pem
ssl-cert=/etc/my.cnf.d/ssl/master.crt
ssl-key=/etc/my.cnf.d/ssl/master.key
skip-name-resolve   #添加禁止名称解析
```
```
从节点：
vim /etc/my.cnf
[mysqld]
server-id=2
read-only=on
binlog_format=row
rpl-semi-sync-slave-enabled
skip-name-resolve      #禁止名称解析
relay-log-purge=off    #关闭中继日志清理
```
### 在主节点创建mha管理用户
1. 确保mysql主从复制的账户存在，如果没有可以创建   
`grant replication slave on *.* to repuser@'192.168.34.%' identified by 'magedu';`  
2. 创建mha管理账户  
`grant all on *.* to mhauser@'192.168.34.%' identified by 'linux';`
### 实现基于key认证的SSH连接
将所有节点实现基于key的SSH认证连接  
1. 生成SSHkey    
`ssh-keygen`  
2. 将生成的公钥拷贝到本机
`ssh-copy-id 192.168.34.10`
3. 将本地的公私钥拷贝到所有的节点主机上
```
scp -rp /root/.ssh/ 192.168.34.8:/root/
scp -rp /root/.ssh/ 192.168.34.7:/root/
scp -rp /root/.ssh/ 192.168.34.9:/root/
```
### 在MHA管理服务器创建MHA配置文件
```
[server default]
user=mhauser                                    #mha管理账户    
password=linux                                  #管理账户密码
manager_workdir=/data/mastermha/DB1/            #本地自动创建的管理文件夹
manager_log=/data/mastermha/DB1/manager.log     #本地自动创建的日志
remote_workdir=/data/mastermha/DB1/             #在远程节点自动创建的目录
master_binlog_dir=/data/binlog/                 #修改过mysql主节点二进制路径后需要指定
ssh_user=root                                   #ssh用户
repl_user=repuser                               #mysql主从复制用户
repl_password=linux                             #mysql主从复制用户密码
ping_interval=1                                 #测试间隔
[server1]                                       #管理的主机组
hostname=192.168.34.8
candidate_master=1                              #允许成功主节点
[server2]
hostname=192.168.34.7
candidate_master=1
[server3]
hostname=192.168.34.9
candidate_master=1
```
### 检测配置文件是否正确
1. 检测各个节点之间SSH通信   
`masterha_check_ssh --conf=/etc/mha/DB1.cnf`
2. 检测各个节点之间二进制拷贝通信  
`masterha_check_repl --conf=/etc/mha/DB1.cnf`
### 启动MHA监控程序
在实际生产环境建议在后台执行，利用screen或nohup
`masterha_manager --conf=/etc/mastermha/app1.cnf`
### 测试MHA效果
故意在主节点拷贝大量数据时，关闭主机  
查看MHA的manager日志来查看新的主节点切换过程  
```
cat /data/mastermha/DB1/manager.log

Started automated(non-interactive) failover.
The latest slave 192.168.34.7(192.168.34.7:3306) has all relay logs for recovery.
Selected 192.168.34.7(192.168.34.7:3306) as a new master.
192.168.34.7(192.168.34.7:3306): OK: Applying all logs succeeded.
192.168.34.9(192.168.34.9:3306): This host has the latest relay log events.
Generating relay diff files from the latest slave succeeded.
192.168.34.9(192.168.34.9:3306): OK: Applying all logs succeeded. Slave started, replicating from 192.168.34.7(192.168.34.7:3306)
192.168.34.7(192.168.34.7:3306): Resetting slave info succeeded.
Master failover to 192.168.34.7(192.168.34.7:3306) completed successfully.
```
# Galera Cluster
Galera Cluster：集成了Galera插件的MySQL集群，是一种新型的，数据不共享的，高度冗余的高可用方案，目前Galera Cluster有两个版本，分别是Percona Xtradb Cluster及MariaDB Cluster，Galera本身是具有多主特性的，即采用multi-master的集群架构，是一个既稳健，又在数据一致性、完整性及高性能方面有出色表现的高可用解决方案。

## Galera Cluster特点
- 多主架构：真正的多点读写的集群，在任何时候读写数据，都是最新的
- 同步复制：集群不同节点之间数据同步，没有延迟，在数据库挂掉之后，数据不会丢失
- 并发复制：从节点APPLY数据时，支持并行执行，更好的性能
- 故障切换：在出现数据库故障时，因支持多点写入，切换容易
- 热插拔：在服务期间，如果数据库挂了，只要监控程序发现的够快，不可服务时间就会非常少。在节点故障期间，节点本身对集群的影响非常小
- 自动节点克隆：在新增节点，或者停机维护时，增量数据或者基础数据不需要人工手动备份提供，GaleraCluster会自动拉取在线节点数据，最终集群会变为一致
- 对应用透明：集群的维护，对应用程序是透明的

## MariaDB Galera Cluster
参考仓库：https://mirrors.tuna.tsinghua.edu.cn/mariadb/mariadb-5.5.62/yum/centos7-amd64/
> 注意：都至少需要三个节点，不能安装mariadb-server
1. 创建yum仓库安装
```
vim /etc/yum.repos.d/galera.repo
[galera]
baseurl=https://mirrors.tuna.tsinghua.edu.cn/mariadb/mariadb-5.5.62/yum/centos7-amd64/
gpgcheck=0
```
2. 将repo文件拷贝给其他mysql服务器
```
scp /etc/yum.repos.d/galera.repo 192.168.34.10:/etc/yum.repos.d/
scp /etc/yum.repos.d/galera.repo 192.168.34.7:/etc/yum.repos.d/
scp /etc/yum.repos.d/galera.repo 192.168.34.9:/etc/yum.repos.d/
```
3. 安装MariaDB-Galera-server  
`yum install MariaDB-Galera-server`
4. 修改其中一台的服务器配置文件  
```
[galera]
# Mandatory settings
wsrep_provider=/usr/lib64/galera/libgalera_smm.so                  #Galera库文件路径           
wsrep_cluster_address="gcomm://192.168.34.7,192.168.34.8,192.168.34.9,192.168.34.10"   #集群的主机列表
binlog_format=row                                                  #二进制格式基于行
default_storage_engine=InnoDB                                      #存储引擎innodb
innodb_autoinc_lock_mode=2                                         
bind-address=0.0.0.0
```
5. 将server.cnf配置文件拷贝到所有节点上
```
scp /etc/my.cnf.d/server.cnf 192.168.34.10:/etc/my.cnf.d/server.cnf
scp /etc/my.cnf.d/server.cnf 192.168.34.7:/etc/my.cnf.d/server.cnf
scp /etc/my.cnf.d/server.cnf 192.168.34.9:/etc/my.cnf.d/server.cnf
```
6. 初始化集群  
`/etc/init.d/mysql start --wsrep-new-cluster`
7. 启动其它所有节点  
`service mysql start`
8. 查看集群的变量参数，验证同步   
`SHOW VARIABLES LIKE 'wsrep_c%';`    
`SHOW STATUS LIKE 'wsrep_%';`   

# 复制的问题和解决方案
1. 数据损坏或丢失   
 Master： MHA + semi repl半同步   
 Slave： 重新复制   
1. 混合使用存储引擎    
 MyISAM：不支持事务   
 InnoDB： 支持事务   
1. 不惟一的server id  
 重新复制   
1. 复制延迟    
 需要额外的监控工具的辅助    
 一从多主:mariadb10版后支持   
 多线程复制：对多个数据库复制   

# 生产环境my.cnf配置示例
```
硬件：内存32G
innodb_file_per_table = 1      #打开独立表空间
max_connections = 8000         #MySQL 服务所允许的同时会话数的上限，经常出现Too Many Connections的错误提示，则需要增大此值
back_log = 300                 #back_log 是操作系统在监听队列中所能保持的连接数
max_connect_errors = 1000      #每个客户端连接最大的错误允许数量，当超过该次数，MYSQL服务器将禁止此主机的连接请求，直到MYSQL服务器重启或通过flush hosts命令清空此主机的相关信息
open_files_limit = 10240       #所有线程所打开表的数量
max_allowed_packet = 32M       #每个连接传输数据大小.最大1G，须是1024的倍数，一般设为最大的BLOB的值
wait_timeout = 10              #指定一个请求的最大连接时间
sort_buffer_size = 16M         #排序缓冲被用来处理类似ORDER BY以及GROUP BY队列所引起的排序
join_buffer_size = 16M         #不带索引的全表扫描.使用的buffer的最小值
query_cache_size = 128M        #查询缓冲大小
query_cache_limit = 4M         #指定单个查询能够使用的缓冲区大小，缺省为1M
transaction_isolation = REPEATABLE-READ  # 设定默认的事务隔离级别
thread_stack = 512K            #线程使用的堆大小. 此值限制内存中能处理的存储过程的递归深度和SQL语句复杂性，此容量的内存在每次连接时被预留.
log-bin                        #二进制日志功能
binlog_format=row              #二进制日志格式
innodb_buffer_pool_size = 24G #InnoDB使用一个缓冲池来保存索引和原始数据,可设置这个变量到服务器物理内存大小的80%
innodb_file_io_threads = 4     #用来同步IO操作的IO线程的数量
innodb_thread_concurrency = 16  #在InnoDb核心内的允许线程数量，建议的设置是CPU数量加上磁盘数量的两倍
innodb_log_buffer_size = 16M    # 用来缓冲日志数据的缓冲区的大小
innodb_log_file_size = 512M     #在日志组中每个日志文件的大小
innodb_log_files_in_group = 3   # 在日志组中的文件总数
innodb_lock_wait_timeout = 120  # SQL语句在被回滚前,InnoDB事务等待InnoDB行锁的时间
long_query_time = 2             #慢查询时长
log-queries-not-using-indexes   #将没有使用索引的查询也记录下来
```
# MYSQL配置最佳实践
高并发大数据的互联网业务，架构设计思路是“解放数据库CPU，将计算转移到服务层”，并发量大的情况下，这些功能很可能将数据库拖死，业务逻辑放到服务层具备更好的扩展性，能够轻易实现“增机器就加性能”   
参考：   
阿里巴巴Java开发手册   
58到家数据库30条军规解读   
http://zhuanlan.51cto.com/art/201702/531364.htm  
