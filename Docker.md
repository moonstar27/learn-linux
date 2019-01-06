一个**用户空间**只运行一个进程，进程终止后用户空间被回收  
六个重要的名称空间：IPC NETWORK MOUNT PID USER UTS   
cgroup计算资源配额：管理CPU、内存、IO  
![namespace](https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1546345192352&di=ee2b4fd6ec8b37455811c65366d95c0a&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D1162978765%2C3690464596%26fm%3D214%26gp%3D0.jpg)

docker镜像仅包含软件运行环境      
docker镜像分层实现，把不同功能分层存储，按照实际需求**叠加**使用   
每一个docker仅运行一个进程，实现针对性的管理 
# 解决docker管理问题
**服务治理**（网格管理）和**容器编排**来管理docker    

# 解决动态管理问题
服务注册：将各个服务注册到总线，方便程序调用   
服务发现：程序去总线寻找想要使用的服务  

# docker
image存储在本地，容器运行于image之上  
C/S方式运行，http通信   
object对象存储，可以管理元数据  
C/S运行在同一主机，使用unix socket，共享内存空间  
![docker](https://ops.cnmysql.com/assets/002/03-0e9a7449.png)

# 安装docker
找到网络上的开源站docker.repo，下载到/etc/yum.repo.d/
安装社区版  
yum install docker-ce

访问docker hub需要镜像加速器 
1. dev.aliyun.com
容器镜像服务-->加速器 
2. docker cn加速  

# 使用docker
1. 查看客户端和服务端版本   
docker verison
1. 下载image    
docker pull   
2. 查看详细信息     
docker info   
docker image inspect redis:4-alpine
3. docker命令分类      
docker 会显示管理命令   
4. 查看容器状态    
docker container ps
5. 创建容器   
docker create #创建不启动    
docker run    #创建直接启动    
-t --tty      #使用一个终端   
-i --interface  #打开交互界面   
--name  #容器名称   
--rm  #停止的容器直接删除
-d --detach  #后台运行  
    > 运行shell时加-it
6. docker网络   
docker0：172.17.0.0/16   
查看网络
    > docker network ls
7. 执行容器内部命令  
docker container exec -it redis /bin/sh #打开容器的sh
docker container exec redis netstat -tnl #执行一次即退出  
    > 1号进程不终止docker不会停止 
8. 停止docker    
docker stop redis 
9. 创建并启动nginx   
docker run --name web -d nginx:1.15-alpin  
    > -d --rm不能同时使用  
10. docker日志   
docker container logs web  
docker日志直接发往控制台，不存放在文件  
    > 默认记录进程1的日志  
11. 容器状态
docker stats
docker container top web
12. 剥离容器终端  
**ctrl+p松开ctrl+q**
13. 附加回终端   
docker attach  
14. 容器运行状态  
docker stats   
docker container top web
---

#### 容器内运行的服务一定必须要前台运行

---

# docker images
采用分层机制，最底层为bootfs--->上面为rootfs   
bootfs：挂载后及卸载 
rootfs：容器根系统，挂载为只读状态，最上为可写层  
可写层每个容器独占，联合挂载层是共享的  
![bootfs](http://www.itfish.net/Home/Modules/Images/itfish_59972_3.jpg)
> 首次修改时采用CoW写时复制机制复制到联合挂载层

## 制作image
1. 利用现有镜像制作  
docker image pull busybox:lasted
docker run --name b1 -it busybox 
2. 保存镜像   
docker container commit b1 用户名/仓库名:tags  
    > 新开一终端来保存镜像内容，加上-p选项
3. 推送镜像    
docker login    
docker image push moonstar27/busybox:v0.1  
    > 镜像名称需要与docker hub仓库名一致
4. 直接在制作镜像时指定镜像要运行的命令  
docker container commit -p -a "nie" -c 'CMD ["/bin/sh","-c","/bin/httpd -f -h /data/web/html/"]' b1 moonstar27/busybox:v0.4
4. 修改标签   
docker image tag 59b432abf8eb moonstar27/busybox:v0.2 
> 通过docker container inspect miniweb3可以查看后台运行服务的IP地址等详细信息
# docker network
**四种网络**：
1. 桥网络：bridge(大多数情况使用)    
    - docker0 NAT模式  
2. 共享桥
    - 联盟式网络  共享NET、UTS、IPC
    - 两个容器文件系统独立，但共享同一网络
3. host网络：直接使用宿主机网络  
    >可以与宿主机共享网络，请求到宿主机的服务会由docker提供 
4. none空网络   
    - 独立运行，不分配网卡，只有lo回环  
## 网络常用选项
1. 查看网络详细信息  
**docker network inspect bridge**
2. 加入现有容器的网络（共享同一网络资源）   
docker run --name joinweb -it --rm --network container:web moonstar27/busybox:v0.4 /bin/sh
3. 加入宿主机的网络   
docker run --name joinweb --rm --network host  nginx:1.15-alpine
1. 指定主机名   
docker --hostname|-h   
docker run --name bbox2 -it --rm --hostname box.test.com busybox
2. 指定host域名解析记录    
docker --add-host www.test.com:192.168.34.7  --add-host mail.test.com:192.168.34.10
3. 指定DNS解析服务器    
docker --add-host www.test.com:192.168.34.7  --add-host mail.test.com:192.168.34.10 --dns 114.114.114.114 --dns 192.168.34.1 --dns-search test.com 
4. 自动发布docker内服务，创建DNAT条目  
docker -p 80 -p 443 宿主机端口为随机  
查看现有容器的端口信息  
docker container port web  

## 创建docker网络
1. 创建自定义网络  
docker network create --subnet 192.168.55.0/24 mybr0   
2. docker直接加入自建网络  
docker --network mybr0   
3. 增加一条新的网络链接  
docker network conntect bridge web
4. 修改默认docker0  
vim /etc/daemon.list    
bip: "192.168.66.1/24" #设置网桥的IP地址    
systemctl restart docker   

# docker Data volumes存储卷
使用容器外的空间保存容器内的生产型数据  
使用一个目录与宿主机的一个目录绑定   
1. 指定docker管理卷，宿主机自动生成  
docker -v /mydata  
    ```
    docker run --name box2 -it -v /mydata busybox
    docker container inspect box2  #查看容器的详细配置
    
    "Type": "volume" #可以看到宿主机挂载的路径
    "Source": "/var/lib/docker/volumes/b5865b985c0a8e5beac80208cc573a4b25c8d511f6b4fe8f72270909fdaadbba/_data"
    ```
2. 查看容器的详细信息    
docker container inspect box2  
3. 指定宿主机的目录    
docker -v /data/v1:/mydata  
docker run --name box2 -it  -v /data/:/mydata busybox
    > #前面是宿主机位置:后面是docker目录  
4. **复制容器,多个容器共享存储卷**     
docker run --name box3 -it --volumes-from box2  busybox  
5. 使用基础容器，提供可复制的共享网络和存储卷  
6. 制定查看json配置文件中的部分内容   
docker container inspect -f {{.Mounts}} box2

> 删除容器后，宿主机的文件不会被删除


```
实验docker搭建WordPress

mkdir /data/wpfile
tar xf wordpress-5.0.1-zh_CN.tar.gz -C wpfile/

docker run --name httpd -d -p 80:80 -v /data/wpfile/:/var/www/html php:5.6-apache
docker container run -d -v /data/mysql:/var/lib/mysql --name wordpressdb --env MYSQL_ROOT_PASSWORD=123456 --env MYSQL_DATABASE=wordpress mysql:5.7

mkdir /data/wpfile/phpwithmysql
vim Dockerfile
FROM php:5.6-apache
RUN docker-php-ext-install mysqli
CMD apache2-foreground #httpd运行在前台  

docker build -t phpwithmysql .

docker run --name httpd -d -p 80:80 -v /data/wpfile/:/var/www/html --link wordpressdb:mysql  phpwithmysql

chmod 777 wordpress/

数据库名：wordpress
用户名：root
密码：123456
数据库主机：mysql
表前缀：wp_（不变）
```

# 打包docker镜像  
## Dockerfile
文本文件，里面包含docker指令来自动打包镜像  
需单独创建一个**工作目录**来存放**Dockerfile**和相关的打包文件，不能包含任何其它文件。打包时此文件夹会被临时当做卷使用  

顺序读取文件内容，指令约定俗成要求大写   
**Dockerfile每条指令都会在基础镜像上创建一层镜像**，**建议将关系依赖紧密的指令放在同一层使用**  

对于容器技术来说，通过修改环境变量来改变配置文件非常重要  
**通过entrypoint.sh中间层脚本来读取用户定义的环境变量来修改镜像中的配置文件**  

.dockerignore可以在build阶段忽略此文件中定义的文件  
### Dockerfile指令
1. 第一条指令应该为FORM指定基础镜像文件    
    - 仓库:标签 FROM centos:7
    - 仓库:校验码  FROM <image>@<digest>
2. LABLE标题，修改元数据  
    - key <value>
3. COPY用于从Docker宿主机复制文件至创建的新镜像文件
    - 从Dockerfile文件夹复制到可写层  
    - COPY <src>  <dest>
    - COPY ["src",..."<dest>"]   
    <src>：要复制的源文件或目录，支持使用通配符 <dest>：目标路径，即正在创建的镜像的文件系统路径；建议为<dest>使用绝对路径   
    - 复制时只复制文件夹下的文件和文件夹，但**不复制源文件本身**。类似于cp -r /data/*  
    - 如果指定了多个<src>，或在<src>中使用了通配符，则<dest>必须是一个目录，且**必须以"/"结尾**，这一点要注意
    - 如果<dest>事先不存在，它将会被自动创建，这包括其父目录路径，这一点和shell中也不同，shell中不会自动创建   
    `COPY /pages /data/web/html/`  
        >注意目标目录的"/" 
4. ADD类似于COPY
    - ADD <src>...<dest>
    - ADD ["src",..."<dest>"] 
    - 如果<src>为URL且<dest>不以/结尾，则<src>指定的文件将被下载并直接被创建为<dest>；如果<dest>以/结尾，则文件名URL指定的文件将被直接下载并保存为<dest>/<filename>
    - 通过URL网络地址获取的压缩格式，不会解压  
    如果是本机路径的压缩格式，会直接解压到指定路径  
    - 如果<src>有多个，或其间接或直接使用了通配符，则<dest>必须是一个以/结尾的目录路径；如果<dest>不以/结尾，则其被视作一个普通文件，**<src>的内容将被直接写入到<dest>**
    ```
    ADD http://nginx.org/download/nginx-1.14.2.tar.gz /tmp/ #网络下载不会解压
    ADD nginx-1.15.8.tar.gz /usr/src/  #本地路径会解压到目标文件夹
    ```
    >注意目标目录的"/"     
5. WORKDIR
    - 用于为Dockerfile中所有的RUN、CMD、ENTRYPOINT、COPY和ADD指定设定工作目录
    - 作用范围是本WORKDIR到下一个WORKDIR之间的所有命令  
    - 在Dockerfile文件中，WORKDIR指令可出现多次
    - 默认登录的sh会被WORKDIR影响  
6. VOLUME
    - 用于在镜像中创建一个挂载点目录，以挂载Docker host上的目录或其它容器上的卷
    - 只是定义容器的卷路径，**但要启用绑定还要在docker run中指定-v绑定**
    > 挂载点有文件，会先复制一份再创建挂载点，文件还会存在
7. EXPOSE
    - 用于为容器打开指定要监听的端口以实现与外部通信
    - 暴露容器内服务端口来被外部访问，DNAT规则 
    - EXPOSE 80/tcp  #默认还是不会暴露，存在风险  
    - 需要**使用docker run -P**来启用EXPOSE，但默认会采用动态方式32768开始的动态端口 
    - 指定传输层协议，可为tcp或udp二者之一，默认为TCP协议
    - EXPOSE指令可一次指定多个端口，例如  
    EXPOSE 11211/udp 11211/tcp
8. ENV
    - 用于为镜像定义所需的环境变量，并可被Dockerfile文件中位于其后的其它指令（如ENV、ADD、COPY等）所调用
    - **built阶段使用的变量**    
    - ENV <hey>=<vlaue>...可以定义多个变量   
9. ARG
    - 定义为参数，可以在build阶段传送参数来临时修改 
    - ARG workdir="/data/web/html" 
    ```
    FROM busybox:latest
    ARG webdir="/data/web/html" #定义参数
    LABEL maintainer="Nie <niew927@gmail.com>"
    COPY /pages ${webdir}
    WORKDIR ${webdir}
    ADD http://nginx.org/download/nginx-1.14.2.tar.gz ${webdir}
    ADD nginx-1.15.8.tar.gz src/
    VOLUME ${webdir}
    EXPOSE 80/tcp
    #build阶段可以通过命令来改变Dockerfile中的原参数
    docker image build --build-arg webdir="/web/htdocs/" /root/workshop/ -t bbox:v0.7
    ```
10. RUN
    - RUN <command> 或   
    RUN ["<executable>", "<param1>", "<param2>"]
    - 第一种格式中，<command>通常是一个shell命令，且以“/bin/sh -c”来运行它，这意味着此进程在容器中的PID不为1，不能接收Unix信号，因此，当使用docker stop <container>命令停止容器时，此进程接收不到SIGTERM信号
    - 第二种语法格式中的参数是一个JSON格式的数组，其中<executable>为要运行的命令，后面的<paramN>为传递给命令的选项或参数；然而，此种格式指定的命令不会以“/bin/sh -c”来发起，因此常见的shell操作如变量替换以及通配符(?,*等)替换将不会进行
    - 运行指定的命令来在build阶段定制镜像 
    - **运行的指令必须是基础镜像所支持的**
    - 多条RUN每条都会执行  
11. CMD
    - CMD <command> 或   
    CMD ["<executable>","<param1>","<param2>"] 或   
    CMD ["<param1>","<param2>"]  
    前两种语法格式的意义同RUN  
    第三种则用于为ENTRYPOINT指令提供默认参数
    - 指定在运行docker run时默认运行的程序，**基于基础镜像所存在的指令**   
    - 运行多个CMD只会运行最后一个 
    - CMD可以在docker run时通过制定命令覆盖原有定义的指令 
    ```
    FROM centos:latest

    ARG webdir="/data/web/www/html/"

    RUN yum -y install httpd php-fpm php-mysql; \
        yum clean all; \
        rm -rf /var/cache/yum/*

    CMD ["/usr/sbin/httpd","-DFOREGROUND"] #指定容器run之后默认运行的程序，不依赖sh
    ```
12. ENTRYPOINT 
    - ENTRYPOINT <command> 或  
    ENTRYPOINT ["<executable>", "<param1>", "<param2>"]
    - 指定在运行docker run时默认运行的程序    
    - 运行多个ENTRYPOINT也会运行最后一个  
    - **不能在docker run时覆盖，自定义的命令会变成ENTRYPOINT的参数**
    - **通过--entrypoint "/bin/bash"来指定要运行的命令**  
13. ENTRYPOINT CMD
    - 两者同时使用CMD指定的内容会变为ENTRYPOINT指定程序的参数  
    ```
    vim Dockerfile
    FROM centos:latest
    ARG webdir="/data/web/www/html/"
    RUN yum -y install httpd php-fpm php-mysql; \
    yum clean all; \
    rm -rf /var/cache/yum/*
    EXPOSE 8080/tcp
    VOLUME ${webdir}
    CMD ["/usr/sbin/httpd","-DFOREGROUND"]
    ENTRYPOINT ["/bin/entrypoint.sh"]
    
    vim entrypoint.sh
    #!/bin/bash
    #####
    listen_port=${LISTEN_PORT:-80}
    server_name=${SERVER_NAME:-localhost}
    webdir=${WEBDIR:-/var/www/html}

    cat > /etc/httpd/conf.d/myweb.conf <<EOF
    Listen $listen_port

    <VirtualHost *:${listen_port}>
        ServerName "${server_name}"
        DocumentRoot "${webdir}"
        <Directory "${webdir}">
                Options none
                AllowOverride none
                Require all granted
        </Directory>
    </VirtualHost>
    EOF

    exec "$@"  #最后执行将CMD的命令替换为主sh程序
    
    执行run时可以使用"-e"来指定参数替换脚本中的变量
    docker container run --name myweb --rm -e LISTEN_PORT=8080 -P http-php:v0.4
    ```
14. USER
    - 指定运行时的用户  
15. HEALTHCHECK
    - HEALTHCHECK [options] CMD command
    - 在进程不能正常接收响应时作为检查使用  
    - --interval 命令执行的间隔时间，默认 30s
    - --timeout 命令超时的时间，默认 30s
    - --retries 命令失败重试的次数，默认为 3
    - --start-period=<间隔>: 应用的启动的初始化时间，在启动过程中的健康检查失效不会计入，默认 0 秒；
    ```
    方式一：写入Dockerfile
    HEALTHCHECK --interval=5s --timeout=2s --retries=12 \
    CMD curl --silent --fail localhost/index.php || exit 1
    方式二：docker run
    docker run --rm -d \
    --name=b1 \
    --health-cmd="curl --silent --fail localhost/index.php || exit 1" \
    --health-interval=5s \
    --health-retries=12 \
    --health-timeout=2s \
    http-php:v0.7
    ```
16. SHELL #修改默认执行的shell
17. STOPSIGNAL #传输信号  
18. ONBUILD
    - 自己制作build时不会执行，只有在别人利用此image制作build时执行ONBUILD命令  
    - 一般是shell命令或ADD 外部链接  

### docker image save
**局域网内部简单分享镜像**  
1. save保存镜像文件   
docker image save myimg:v0.6 php-httpd:v0.6 -o /data/myimages.tar 
2. load加载镜像文件   
docker image load -i /data/myimages.tar    
3. 查看镜像每层的打包时间  
docker image history myimg:v0.6  


### 环境变量 
在Dockerfile中使用 

1. 通过基础镜像+中间层脚本来创建镜像=build阶段  
2. 通过docker run来运行镜像  

# 私有仓库  
docker官方的软件，功能不全不支持WEB管理，建议使用第三方  
yum install -y docker-distribution

## harbor
优秀的开源docker仓库软件  
```
1、安装docker-compose和下载离线harbor软件包 
yum install -y docker-compose
wget https://storage.googleapis.com/harbor-releases/release-1.7.0/harbor-offline-installer-v1.7.0.tgz
tar xf harbor-offline-installer-v1.7.0.tgz -C /usr/local/
cd /usr/local/harbor/
2、修改配置文件
vim harbor.cfg 
hostname = 192.168.34.10            #当前主机的主机名或者ip地址
ui_url_protocol = http              #使用的协议为http也可以用https
db_password = root123               #连接数据库的root用户的密码
harbor_admin_password = Harbor12345 #harbor初始化时候的密码
3、安装harbor
./install.sh    #注意在启动之前要先安装好docker-compose和docker，这里使用的是docker-ce版本，发现启动的过程中就是搭建harbor的过程，使用的是docker-compose一次性创建多个容器来搭建harbor服务，因此可以用docker-compose命令来关闭和启动harbor
启动成功后会有这条提示：Now you should be able to visit the admin portal at http://192.168.34.10 
4、基于安全原因，如果测试用http还需要修改docker配置文件允许上传
vim /etc/docker/daemon.json
{
  "registry-mirrors": ["https://r9sgnitp.mirror.aliyuncs.com"],
   "insecure-registries": ["192.168.34.10"]  #增加一行允许非安全上传
}
实际工作中强烈建议启用https
5、测试创建仓库和上传
访问：http://192.168.34.10
先使用管理admin登录，创建一个普通用户，使用普通用户创建仓库例如busybox
首先需要将本地镜像修改标签为刚才创建的仓库名
docker tag bbox:v0.7 192.168.34.10/busybox/bbox:v0.7
docker login 192.168.34.10
使用创建的普通用户登录
docker push 192.168.34.10/busybox/bbox:v0.7
在网页查看推送结果
```
# docker资源限制
**出于安全考虑，建议启用资源限制**    
**lorel/docker-stress-ng**压力测试  
## 内存
选项|说明
---|---
-m |内存限制，格式是数字加单位，单位可以为 b,k,m,g。最小为 4M   
--memory-swap | 内存+交换分区大小总限制。格式同上。必须比-m设置的值大  
--memory-reservation|内存的软性限制。格式同上
--memory-swappiness | 使用交换分区的倾向性，值为 0~100 之间的整数，百分比，越小越不倾向使用 
--kernel-memory|核心内存限制。格式同上，最小为 4M
--oom-kill-disable |是否阻止 OOM killer 杀死容器，默认没设置
> 实际环境中一般不启用swap，影响性能

## CPU
选项|说明
---|---
--cpus |最多占用几个CPU核心，共享式限制  
--cpuset-cpus |指定运行在哪颗CPU核心上，值可以为 0-3,0,1
-c,--cpu-shares|指定CPU共享分配比例，相对权重  

## docker-stress-ng压力测试
- 下载镜像   
docker pull lorel/docker-stress-ng
- 查看使用帮助   
docker run --name stress -it --rm lorel/docker-stress-ng --help  
- 测试CPU   
docker run --name stress --cpus 2 --rm lorel/docker-stress-ng -c 2  
-c指定2个核心测试，--cpus指定总共可用2颗CPU  
- 指定哪颗CPU运行  
docker run --name stress --cpus 2 --cpuset-cpus 0 --rm lorel/docker-stress-ng -c 2
- 指定CPU运行比例
    ```
    第二个容器的CPU会占用为第一个容器的二倍
    docker run --name stress --cpu-shares 1024 --rm lorel/docker-stress-ng -c 2
    docker run --name stress2 --cpu-shares 2048 --rm lorel/docker-stress-ng -c 2
    ```
- 测试内存   
docker run --name stress -m 512M --rm lorel/docker-stress-ng -vm 2   
限制容器物理内存使用为512M
# docker-compose
容器编排工具    
在compose文件目录执行  

```
mkdir wordpress

vim docker-compose.yml
version: '3.3'

services:
   wordpress:
     depends_on:
       - db
     image: wordpress:latest
     volumes:
       - wordpress_files:/var/www/html
     ports:
       - "80:80"
     restart: always
     environment:
       WORDPRESS_DB_HOST: db:3306
       WORDPRESS_DB_NAME: wpdb
       WORDPRESS_DB_USER: wpuser
       WORDPRESS_DB_PASSWORD: wppass
    db:
     image: mysql:5.7
     volumes:
       - db_data:/var/lib/mysql
     restart: always
     environment:
       MYSQL_ROOT_PASSWORD: linux
       MYSQL_DATABASE: wpdb
       MYSQL_USER: wpuser
       MYSQL_PASSWORD: wppass
volumes:
    wordpress_files:
    db_data:

运行compose启动  
docker-compose up -d
停止运行
docker-compose stop
```

