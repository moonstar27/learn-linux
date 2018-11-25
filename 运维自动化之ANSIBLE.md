# Ansible主要组成部分
- ANSIBLE PLAYBOOKS：任务剧本（任务集），编排定义Ansible任务集的配置文件，由Ansible顺序依次执行，通常是JSON格式的YML文件
- INVENTORY：Ansible管理主机的清单/etc/anaible/hosts
- MODULES：Ansible执行命令的功能模块，多数为内置核心模块，也可自定义
- PLUGINS：模块功能的补充，如连接类型插件、循环插件、变量插件、过滤插件等，该功能不常用
- API：供第三方程序调用的应用程序编程接口
- ANSIBLE：组合INVENTORY、API、MODULES、PLUGINS的绿框，可以理解为是ansible命令工具，其为核心执行工具


- Ansible命令执行来源：  
USER，普通用户，即SYSTEM ADMINISTRATOR  
CMDB（配置管理数据库） API 调用  
PUBLIC/PRIVATE CLOUD API调用  
USER-> Ansible Playbook -> Ansibile  
- 利用ansible实现管理的方式：  
Ad-Hoc 即ansible命令，主要用于临时命令使用场景  
Ansible-playbook   主要用于长期规划好的，大型项目的场景，需要有前提
的规划  

- Ansible-playbook（剧本）执行过程：  
将已有编排好的任务集写入Ansible-Playbook  
通过ansible-playbook命令分拆任务集至逐条ansible命令，按预定规则逐条执行  
- Ansible主要操作对象：   
HOSTS主机  
NETWORKING网络设备  
> 注意事项   
执行ansible的主机一般称为主控端，中控，master或堡垒机   
主控端Python版本需要2.6或以上   
被控端Python版本小于2.4需要安装python-simplejson   
被控端如开启SELinux需要安装libselinux-python   
windows不能做为主控端   

# 安装方式
1. rpm包安装: EPEL源
yum install ansible

2. 编译安装:   
yum -y install python-jinja2 PyYAML python-paramiko python-babel python-crypto  
tar xf ansible-1.5.4.tar.gz   
cd ansible-1.5.4  
python setup.py build   
python setup.py install  
mkdir /etc/ansible  
cp -r examples/* /etc/ansible   

3. Git方式：
git clone git://github.com/ansible/ansible.git --recursive   
cd ./ansible   
source ./hacking/env-setup  
4. pip安装：pip是安装Python包的管理器，类似yum   
yum install python-pip python-devel   
yum install gcc glibc-devel zibl-devel rpm-bulid openssl-devel   
pip install --upgrade pip   
pip install ansible --upgrade   

> 确认安装： ansible --version

# 相关配置文件

- 配置文件   
/etc/ansible/ansible.cfg 主配置文件，配置ansible工作特性   
/etc/ansible/hosts 主机清单  
/etc/ansible/roles/ 存放角色的目录   
- 程序   
/usr/bin/ansible 主程序，临时命令执行工具   
/usr/bin/ansible-doc 查看配置文档，模块功能查看工具   
/usr/bin/ansible-galaxy 下载/上传优秀代码或Roles模块的官网平台   
/usr/bin/ansible-playbook 定制自动化任务，编排剧本工具  
/usr/bin/ansiblepull 远程执行命令的工具  
/usr/bin/ansible-vault 文件加密工具  
/usr/bin/ansible-console 基于Console界面与用户交互的执行工具  

## 主机清单inventory

默认的inventory file为/etc/ansible/hosts   

inventory文件遵循INI文件风格，中括号中的字符为组名。可以将同一个主机同时归并到多个不同的组中；   
此外，当如若目标主机使用了非默认的SSH端口，
还可以在主机名称之后使用冒号加端口号来标明
```
ntp.magedu.com
[webservers]
www1.magedu.com:2222  #非标准端口要单独写明
www2.magedu.com
[dbservers]
db1.magedu.com
db2.magedu.com
db3.magedu.com
```
如果主机名称遵循相似的命名模式，还可以使用列表的方式标识各主机
```
示例：
[websrvs]
www[01:100].example.com
[dbsrvs]
db-[a:f].example.com
```

## ansible 配置文件
Ansible 配置文件/etc/ansible/ansible.cfg （一般保持默认）
```
[defaults]
#inventory = /etc/ansible/hosts # 主机列表配置文件
#library = /usr/share/my_modules/ # 库文件存放目录
#remote_tmp = $HOME/.ansible/tmp #临时py命令文件存放在远程主机目录
#local_tmp = $HOME/.ansible/tmp # 本机的临时命令执行目录
#forks = 5 # 默认并发数
#sudo_user = root # 默认sudo 用户
#ask_sudo_pass = True #每次执行ansible命令是否询问ssh密码
#ask_pass = True
#remote_port = 22
host_key_checking = False # 检查对应服务器的host_key，建议取消注释
log_path=/var/log/ansible.log #日志文件
#module_name = command #默认模块

建议将host_key_checking和log注释取消
```
# ansible系列命令
ansible-doc: 显示模块帮助
ansible-doc [options] [module...]   
-a 显示所有模块的文档   
-l, --list 列出可用模块  
-s, --snippet显示指定模块的playbook片段  
```
示例：
ansible-doc –l 列出所有模块
ansible-doc ping 查看指定模块帮助用法
ansible-doc –s ping 查看指定模块帮助用法
```

#### ansible通过ssh实现配置管理、应用部署、任务执行等功能，建议配置ansible端能基于密钥认证的方式联系各被管理节点

##### ansible <host-pattern> [-m module_name] [-a args]

命令 | 说明
---|---
--version | 显示版本
-m module | 指定模块，默认为command
-v、-vv、-vvv| 详细过程
--list-hosts | 显示主机列表，可简写 --list
-k, --ask-pass | 提示输入ssh连接密码，默认Key验证
-K, --ask-become-pass | 提示输入sudo时的口令
-C, --check | 检查，并不执行
-T, --timeout=TIMEOUT | 执行命令的超时时间，默认10s
-u, --user=REMOTE_USER | 执行远程执行的用户
-b, --become | 代替旧版的sudo 切换
--become-user=USERNAME | 指定sudo的runas用户，默认为root

## ansible的Host-pattern
ansible的Host-pattern：匹配主机的列表

- All ：表示所有Inventory中的所有主机  
`ansible all –m ping`
- \* :通配符
```
ansible “*” -m ping
ansible 192.168.1.* -m ping
ansible “*srvs” -m ping
```
- 或关系 ":"
```
ansible “websrvs:appsrvs” -m ping
ansible “192.168.1.10:192.168.1.20” -m ping
```
- 逻辑与 ":&"
```
ansible “websrvs:&dbsrvs” –m ping
在websrvs组并且在dbsrvs组中的主机
```
- 逻辑非":!"
```
ansible 'websrvs:!dbsrvs' –m ping
在websrvs组，但不在dbsrvs组中的主机
注意：此处为单引号
```
- 综合逻辑  
`ansible ‘websrvs:dbsrvs:&appsrvs:!ftpsrvs’ –m ping`
- 正则表达式
```
ansible “websrvs:&dbsrvs” –m ping
ansible “~(web|db).*\.magedu\.com” –m ping
```

## ansible命令执行过程
ansible命令执行过程
1. 加载自己的配置文件 默认/etc/ansible/ansible.cfg
2. 加载自己对应的模块文件，如command
3. 通过ansible将模块或命令生成对应的临时py文件，并将该 文件传输至远程
服务器的对应执行用户$HOME/.ansible/tmp/ansible-tmp-数字/XXX.PY文件
4. 给文件+x执行
5. 执行并返回结果
6. 删除临时py文件，sleep 0退出

执行状态：  
绿色：执行成功并且不需要做改变的操作  
黄色：执行成功并且对目标主机做变更  
红色：执行失败  

```
使用示例:

以wang用户执行ping存活检测
 ansible all -m ping -u wang -k
 
以wang sudo至root执行ping存活检测
 ansible all -m ping -u wang -k -b
 
以wang sudo至mage用户执行ping存活检测
 ansible all -m ping -u wang -k -b --become-user=mage
 
以wang sudo至root用户执行ls
 ansible all -m command -u wang -a 'ls /root' -b --become-user=root -k -K
```

## ansible常用模块
- Command 在远程主机执行命令，默认模块，可忽略-m选项
```
ansible srvs -m command -a ‘service vsftpd start’
ansible srvs -m command -a ‘echo magedu |passwd --stdin wang’
```
> 此命令不支持 $VARNAME < > | ; & 等，用shell模块实现

- Shell：和command相似，用shell执行命令
```
利用shell模块修改用户密码
ansible srv -m shell -a ‘echo magedu |passwd –stdin wang’

调用bash执行命令 类似 cat /tmp/stanley.md | awk -F'|'' '{print $1,$2}' &> /tmp/example.txt
这些复杂命令，即使使用shell也可能会失败
解决办法：写到脚本时，copy到远程，执行，再把需要的结果拉回执行命令的机器
```
> 可以将ansible默认执行模块修改为shell，以便于执行较复杂命令   
vim /etc/ansible/ansible.cfg  
113 # default module name for /usr/bin/ansible  
114 module_name = shell

- Script：在远程主机上运行ansible服务器上的脚本
```
-a "/PATH/TO/SCRIPT_FILE" #写好脚本在本地的目录
ansible websrvs -m script -a '/data/sysinfo.sh'
```

- Copy：从服务器复制文件或文件夹到客户端
```
拷贝并改名，将文件所有者修改并修改权限
ansible srv -m copy -a “src=/root/f1.sh dest=/tmp/f2.sh owner=wang mode=600 backup=yes”
如目标存在，默认覆盖，此处指定先备份

ansible srv -m copy -a “content=‘test content\n’ dest=/tmp/f1.txt”
指定内容，直接生成目标文件

拷贝原文件并修改名称
[root@centos7 bin]#ansible appsvrs -m copy -a 'src=/data/bin/sysinfo62.sh dest=/root/sysinfo.sh'

执行查看结果
[root@centos7 bin]#ansible appsvrs -a 'bash /root/sysinfo.sh'
192.168.34.8 | CHANGED | rc=0 >>
OS version is CentOS Linux release 7.5.1804 (Core) 
Kernel version is 3.10.0-862.el7.x86_64

192.168.34.6 | CHANGED | rc=0 >>
OS version is CentOS release 6.10 (Final)
Kernel version is 2.6.32-754.6.3.el6.x86_64

利用content直接创建文件并写入内容
[root@centos7 bin]#ansible all -m copy -a 'content="[test]\nbaseurl=file:///mnt/cdrom\ngpgcheck=0" dest=/etc/yum.repos.d/test.repo'

[root@centos7 bin]#ansible all -a 'cat /etc/yum.repos.d/test.repo'
192.168.34.50 | CHANGED | rc=0 >>
[test]
baseurl=file:///mnt/cdrom
gpgcheck=0

192.168.34.6 | CHANGED | rc=0 >>
[test]
baseurl=file:///mnt/cdrom
gpgcheck=0

192.168.34.8 | CHANGED | rc=0 >>
[test]
baseurl=file:///mnt/cdrom
gpgcheck=0
```

- Fetch：从客户端取文件至服务器端，copy相反，目录可先tar

```
回传文件到服务器/data目录
ansible all -m fetch -a 'src=/etc/redhat-release dest=/data/'

如果想要回传目录，可以先用tar生成文件后操作
ansible all -a 'tar cf /data/httpd.tar /var/log/httpd' #前面是生成tar文件的目录，后面是要打包的目录
ansible all -m fetch -a 'src=/data/httpd.tar dest=/data/' #前面是各个服务器上的/data目录，后面是ansible主机的/data目录
```

- File：设置文件属性
```
创建文件并修改所有者和权限
ansible all -m file -a "path=/root/a.sh owner=wang mode=755"

创建目标文件的软链接文件
ansible websvrs -m file -a 'src=/app/testfile dest=/app/testfile-link state=link'

创建目标文件的硬链接文件
ansible websvrs -m file -a 'src=/app/testfile dest=/app/testfile2.link state=hard'

创建文件夹
ansible all -m file -a 'path=/data/dir state=directory'
```
- Hostname：管理主机名  
`ansible all -m hostname -a “name=websrv” `
- Cron：计划任务  
支持时间：minute，hour，day，month，weekday
```
各服务每5分钟同步一次时间
ansible all -m cron -a "minute=*/5 weekday=0,6 job='/usr/sbin/ntpdate 172.16.0.1 &>/dev/null' name=Synctime" 

删除计划任务(写任务名称)
ansible srv -m cron -a 'state=absent name=Synctime' 
```

- Yum：管理包
```
安装httpd服务
ansible srv -m yum -a 'name=httpd state=present' 

删除httpd服务
ansible srv -m yum -a 'name=httpd state=absent' 

安装多个服务
ansible srv -m yum -a 'name=httpd,vsftpd,dhcp'

安装httpd服务并更新缓存
ansible srv -m yum -a 'name=httpd update_cache=yes' 
```

- Service：管理服务
```
关闭http服务
ansible srv -m service -a 'name=httpd state=stopped'

启动http服务并设置开机启动
ansible srv -m service -a 'name=httpd state=started enabled=yes'

重新载入http服务
ansible srv -m service -a 'name=httpd state=reloaded’

重启http服务
ansible srv -m service -a 'name=httpd state=restarted' 
```

- User：管理用户
```
创建用户并设置UID、家目录和组
ansible srv -m user -a 'name=user1 comment="test user" uid=2048 home=/app/user1 group=root'

创建系统用户
ansible srv -m user -a 'name=sysuser1 system=yes home=/app/sysuser1' 

删除用户及家目录等数据
ansible srv -m user -a 'name=user1 state=absent remove=yes'
```
- Group：管理组
```
创建系统组
ansible srv -m group -a "name=testgroup system=yes"

删除组
ansible srv -m group -a "name=testgroup state=absent" 
```

## ansible常用命令

### ansible-galaxy
连接 https://galaxy.ansible.com 下载相应的roles
- 列出所有已安装的galaxy  
ansible-galaxy list  
- 安装galaxy  
ansible-galaxy install geerlingguy.redis  
- 删除galaxy  
ansible-galaxy remove geerlingguy.redis  

### ansible-pull
推送命令至远程，效率无限提升，对运维要求较高

### ansible-playbook
执行playbook
```
示例：ansible-playbook hello.yml
cat hello.yml
 #hello world yml file
 - hosts: websrvs
   remote_user: root
   tasks:
     - name: hello world
       command: /usr/bin/wall hello world
 ```
 
### ansible-vault
功能：管理加密解密yml文件

`ansible-vault [create|decrypt|edit|encrypt|rekey|view]`  
ansible-vault encrypt hello.yml 加密  
ansible-vault decrypt hello.yml 解密  
ansible-vault view hello.yml 查看  
ansible-vault edit hello.yml 编辑加密文件  
ansible-vault rekey hello.yml 修改口令  
ansible-vault create new.yml 创建新文件  

### Ansible-console

2.0+新增，可交互执行命令，支持tab

root@test (2)[f:10] $  
 执行用户@当前操作的主机组 (当前组的主机数量)[f:并发数]$   
- 设置并发数： forks n 例如： forks 10  
- 切换组： cd 主机组 例如： cd web  
- 列出当前组主机列表： list  
- 列出所有的内置命令： ?或help  
```
root@all (2)[f:5]$ list
root@all (2)[f:5]$ cd appsrvs #切换主机组
root@appsrvs (2)[f:5]$ list
root@appsrvs (2)[f:5]$ yum name=httpd state=present #安装服务
root@appsrvs (2)[f:5]$ service name=httpd state=started  #启动服务
```

# ansible playbook

playbook是由一个或多个“play”组成的列表   
play的主要功能在于将预定义的一组主机，装扮成事先通过ansible中的task定义好的角色。Task实际是调用ansible的一个module，将多个play组织在一个playbook中，即可以让它们联合起来，按事先编排的机制执行预定义的动作   
Playbook采用YAML语言编写   

## YAML语法简介

- 在单一档案中，可用连续三个连字号(——)区分多个档案。另外，还有选择性的连续三个点号(...)用来表示档案结尾
- 次行开始正常写Playbook的内容，一般建议写明该Playbook的功能
- 使用#号注释代码
- 缩进必须是统一的，不能空格和tab混用
- 缩进的级别也必须是一致的，同样的缩进代表同样的级别，程序判别配置的级别是通过缩进结合换行来实现的
- YAML文件内容是区别大小写的，k/v的值均需大小写敏感
- k/v的值可同行写也可换行写。同行使用:分隔
- \- v可是个字符串，也可是另一个列表
- 一个完整的代码块功能需最少元素需包括 name: task
- 一个name只能包括一个task
- YAML文件扩展名通常为yml或yaml

### List：列表
其所有元素均使用“-”打头
```
示例：
# A list of tasty fruits
- Apple
- Orange
- Strawberry
- Mango
```
### Dictionary：字典

通常由多个key与value构成

```
示例：
---
# An employee record
name: Example Developer
job: Developer
skill: Elite
也可以将key:value放置于{}中进行表示，用,分隔多个key:value

示例：
---
# An employee record
{name: Example Developer, job: Developer, skill: Elite}
```

### YAML语法结构

YAML的语法和其他高阶语言类似，并且可以简单表达清单、散列表、标量等数据结构。其结构（Structure）通过空格来展示，序列（Sequence）里的项用"-"来代表，Map里的键值对用":"分隔
```
示例
name: John Smith
age: 41
gender: Male
spouse:
 name: Jane Smith
 age: 37
 gender: Female
children:
 - name: Jimmy Smith
 age: 17
 gender: Male
 - name: Jenny Smith
 age 13
 gender: Female
```

## Playbook核心元素

- Hosts 执行的远程主机列表
- Tasks 任务集
- Varniables 内置变量或自定义变量在playbook中调用
- Templates 模板，可替换模板文件中的变量并实现一些简单逻辑的文件
- Handlers 和notity结合使用，由特定条件触发的操作，满足条件方才执行，否则不执行
- tags 标签 指定某条任务执行，用于选择运行playbook中的部分代码。ansible具有幂等性，因此会自动跳过没有变化的部分，即便如此，有些代码为测试其确实没有发生变化的时间依然会非常地长。此时，如果确信其没有变化，就可
以通过tags跳过此些代码片断  
`ansible-playbook –t tagsname useradd.yml`

## playbook基础组件

### Hosts：
playbook中的每一个play的目的都是为了让特定主机以某个指定的用户身份执行任务。hosts用于指定要执行指定任务的主机，须事先定义在主机清单中

- 可以是如下形式：  
one.example.com  
one.example.com:two.example.com  
192.168.1.50  
192.168.1.*  
- Websrvs:dbsrvs 或者，两个组的并集  
- Websrvs:&dbsrvs 与，两个组的交集  
- webservers:!phoenix 在websrvs组，但不在dbsrvs组  
 示例: - hosts: websrvs：dbsrvs
> 注意"-"和":"后的空格

### remote_user: 
可用于Host和task中。也可以通过指定其通过sudo的方式在远程主机上执行任务，其可用于play全局或某任务；此外，甚至可以在sudo时使用sudo_user指定sudo时切换的用户

```
- hosts: websrvs
  remote_user: root
  tasks:
    - name: test connection
      ping:
      remote_user: magedu
      sudo: yes   #默认sudo为root
      sudo_user:wang  #sudo为wang
```

### task列表和action
- play的主体部分是task list。task list中的各任务按次序逐个在hosts中指定的所有主机上执行，即在所有主机上完成第一个任务后，再开始第二个任务
- task的目的是使用指定的参数执行模块，而在模块参数中可以使用变量。模块执行是幂等的，这意味着多次执行是安全的，因为其结果均一致
- 每个task都应该有其name，用于playbook的执行结果输出，建议其内容能清晰地描述任务执行步骤。如果未提供name，则action的结果将用于输出

#### tasks：任务列表
两种格式：
1. action: module arguments
1. module: arguments  #模块： 参数 建议使用
> 注意：shell和command模块后面跟命令，而非key=value

- 某任务的状态在运行后为changed时，可通过“notify”通知给相应的handlers
- 任务可以通过"tags“打标签，可在ansible-playbook命令上使用-t指定进行调用
```
示例：
tasks:
  - name: disable selinux
    command: /sbin/setenforce 0
```

##### 如果命令或脚本的退出码不为零，可以使用如下方式替代
```
tasks:
  - name: run this command and ignore the result
    shell: /usr/bin/somecommand || /bin/true
```
##### 或者使用ignore_errors来忽略错误信息
```
tasks:
  - name: run this command and ignore the result
    shell: /usr/bin/somecommand
    ignore_errors: True
```

### 运行playbook
运行playbook的方式  
ansible-playbook <filename.yml> ... [options]  

- 常见选项   
--check -C 只检测可能会发生的改变，但不真正执行操作    
--list-hosts 列出运行任务的主机   
--list-tags 列出tag  
--list-tasks 列出task  
--limit 主机列表 只针对主机列表中的主机执行  
-v -vv -vvv 显示过程  

```
示例
ansible-playbook file.yml --check 只检测
ansible-playbook file.yml
ansible-playbook file.yml --limit websrvs
```

### Playbook与ShellScripts区别
```
Playbook定义
---
- hosts: all

  tasks:
  - name: "安装Apache"
    yum: name=httpd
  - name: "复制配置文件"
    copy: src=/tmp/httpd.conf dest=/etc/httpd/conf/
  - name: "复制配置文件"
    copy: src=/tmp/vhosts.conf dest=/etc/httpd/conf.cd/
  - name: "启动Apache，并设置开机启动"
    service: name=httpd state=started enabled=yes
```
```
SHELL脚本
#!/bin/bash
# 安装Apache
yum install --quiet -y httpd
# 复制配置文件
cp /tmp/httpd.conf /etc/httpd/conf/httpd.conf
cp/tmp/vhosts.conf /etc/httpd/conf.d/
# 启动Apache，并设置开机启动
service httpd start
chkconfig httpd on
```
### Playbook示例
```
示例：sysuser.yml
---
- hosts: all
  remote_user: root
  
  tasks:
    - name: create mysql user
      user: name=mysql system=yes uid=36
    - name: create a group
      group: name=httpd system=yes
```
```
示例：httpd.yml
  1 ---
  2 - hosts: appsvrs                                      
  3   remote_user: root
  4 
  5   tasks:
  6     - name: create group
  7       group: name=apache system=yes gid=80
  8     - name: create user
  9       user: name=apache group=apache uid=80 shell=/sbin/nologin home=/usr/share/httpd system=yes password='$1$72mhO7rH$twFsQ8Q8oDTqtTMxXXfSf/'
 10     - name: install package
 11       yum: name=httpd
 12     - name: config file
 13       copy: src=/data/playbook/httpd.conf dest=/etc/httpd/conf/ backup=yes
 14     - name: service
 15       service: name=httpd state=started enabled=yes

```
> 所有格式必须为空格，不能有一个tab。ssh软件会自动对齐格式，但是会有tab对齐，所以会报错！
## handlers和notify结合使用触发条件
- Handlers
是task列表，这些task与前述的task并没有本质上的不同,用于当关注的资源发生变化时，才会采取一定的操作
- Notify此action可用于在每个play的最后被触发，这样可避免多次有改变发生时每次都执行指定的操作，仅在所有的变化发生完成后一次性地执行指定操作。
- 在notify中列出的操作称为handler，也即notify中调用handler中定义的操作

```
  1 ---                                             
  2 - hosts: appsvrs
  3   remote_user: root
  4 
  5   tasks:
  6     - name: create group
  7       group: name=apache system=yes gid=80
  8     - name: create user
  9       user: name=apache group=apache uid=80 shell=/sbin/nologin home=/usr/share/httpd system=yes password='$1$72mhO7rH$twFsQ8Q8oDTqtTMxXXfSf/'
 10     - name: install package
 11       yum: name=httpd
 12     - name: config file
 13       copy: src=/data/playbook/httpd.conf dest=/etc/httpd/conf/ backup=yes
 14       notify: restart httpd  #配置文件发生变化，出发handlers重启服务
 15     - name: service
 16       service: name=httpd state=started enabled=yes
 17   handlers:
 18     - name: restart httpd
 19       service: name=httpd state=restarted
```
```
- hosts: websrvs
  remote_user: root

  tasks:
    - name: add group nginx
      tags: user
      user: name=nginx state=present
    - name: add user nginx
      user: name=nginx state=present group=nginx
    - name: Install Nginx
      yum: name=nginx state=present
    - name: config
      copy: src=/root/config.txt dest=/etc/nginx/nginx.conf
      notify:     #多条的handlers按顺序执行
    - Restart Nginx
    - Check Nginx Process
  handlers:
    - name: Restart Nginx  #重启服务
      service: name=nginx state=restarted enabled=yes
    - name: Check Nginx process  #检查服务并写入文件
      shell: killall -0 nginx > /tmp/nginx.log
```

### Playbook中tags使用
```
示例：httpd.yml
- hosts: websrvs
  remote_user: root
  
  tasks:
    - name: Install httpd
      yum: name=httpd state=present
    - name: Install configure file
      copy: src=files/httpd.conf dest=/etc/httpd/conf/
      tags: conf #设置复制配置文件标签
    - name: start httpd service
      tags: service
      service: name=httpd state=started enabled=yes

只从复制配置文件开始执行
ansible-playbook –t conf httpd.yml
```

### Playbook中变量使用
#### 变量名：
仅能由字母、数字和下划线组成，且只能以字母开头   
变量来源：  
1. ansible all -m setup 远程主机的所有变量都可直接调用
2. 在/etc/ansible/hosts中定义  
 普通变量：主机组中主机单独定义，优先级高于公共变量  
 公共（组）变量：针对主机组中所有主机定义统一变量
3. 通过命令行指定变量，**优先级最高**   
 ansible-playbook –e varname=value
4. 在playbook中定义
vars:
 - var1: value1
 - var2: value2
5. 在独立的变量YAML文件中定义
6. 在role中定义

#### 变量定义：key=value
示例：http_port=80

#### 变量调用方式：

- 通过{{ variable_name }} 调用变量，且变量名前后必须有空格，有时用
"{{ variable_name }}"才生效
- ansible-playbook –e 选项指定  
ansible-playbook test.yml -e "hosts=www user=test"
```
  1 ---
  2 - hosts: appsvrs
  3   remote_user: root
  4   tasks:
  5     - name: install package
  6       yum: name={{ sv_name }}
  7     - name: service
  8       service: name={{ sv_name }} state=started enabled=yes      
  9       tags: service
  
  #在命令行中定义变量sv_name，playbook中会安装指定服务
  [root@centos7 ansible]#ansible-playbook -e sv_name=vsftpd install_httpd3.yml
```
```
  1 ---
  2 - hosts: appsvrs
  3   remote_user: root
  4   tasks:
  5     - name: install package
  6       yum: name={{ sv_name1 }}
  7     - name: service
  8       service: name={{ sv_name2 }} state=started enabled=yes        
  9       tags: service
  
  #同时定义多个不同变量
  [root@centos7 ansible]#ansible-playbook -e "sv_name1=samba sv_name2=smb" install_httpd3.yml
```
```
推荐使用单独的yml文件定义变量
[root@centos7 ansible]#vim vars.yml 
sv_name1: httpd
sv_name2: httpd

  1 ---
  2 - hosts: appsvrs
  3   remote_user: root
  4   vars_files:
  5     - vars.yml   #调用变量文件   
  6   tasks:
  7     - name: install package
  8       yum: name={{ sv_name1 }}
  9     - name: service
 10       service: name={{ sv_name2 }} state=started enabled=yes
 11       tags: service
```
## 变量
### 主机变量
可以在inventory中定义主机时为其添加主机变量以便于在playbook中使用

```
[root@centos7 ansible]#cat /etc/ansible/hosts |tail -2
192.168.34.6 nodename=centos6
192.168.34.8 nodename=centos7

1 ---
2 - hosts: appsvrs
3   remote_user: root
4 
5   tasks: 
6     - name: hostname
7       hostname: name={{ nodename }}
  
[root@centos7 ansible]#ansible appsvrs -a 'echo $HOSTNAME'
192.168.34.8 | CHANGED | rc=0 >>
centos7

192.168.34.6 | CHANGED | rc=0 >>
centos6
```

### 组变量
组变量是指赋予给指定组内所有主机上的在playbook中可用的变量

```
[root@centos7 ansible]#cat /etc/ansible/hosts |tail -6
[appsvrs]
192.168.34.6 nodename=centos6
192.168.34.8 nodename=centos7

[appsvrs:vars] #定义组变量
suffix=test.com

  1 ---
  2 - hosts: appsvrs
  3   remote_user: root
  4 
  5   tasks: 
  6     - name: hostname
  7       hostname: name={{ nodename }}.{{ suffix }}

[root@centos7 ansible]#ansible appsvrs -a 'echo $HOSTNAME'
192.168.34.8 | CHANGED | rc=0 >>
centos7.test.com

192.168.34.6 | CHANGED | rc=0 >>
centos6.test.com
```
```
普通变量
[websrvs]
192.168.99.101 http_port=8080 hname=www1
192.168.99.102 http_port=80 hname=www2
公共（组）变量
[websvrs:vars]
http_port=808
mark=“_”
[websrvs]
192.168.99.101 http_port=8080 hname=www1
192.168.99.102 http_port=80 hname=www2
ansible websvrs –m hostname –a 'name={{ hname }}{{ mark }}{{ http_port }}'

命令行指定变量：
ansible websvrs –e http_port=8000 –m hostname –a 'name={{ hname }}{{ mark }}{{ http_port }}''
```
# 模板templates

- 文本文件，嵌套有脚本（使用模板编程语言编写）
- Jinja2语言，使用字面量，有下面形式  
字符串：使用单引号或双引号  
数字：整数，浮点数  
列表：[item1, item2, ...]  
元组：(item1, item2, ...)  
字典：{key1:value1, key2:value2, ...}  
布尔型：true/false  
- 算术运算：+, -, *, /, //, %, **
> //是取除法之后的整数，不要余数
- 比较操作：==, !=, >, >=, <, <=
- 逻辑运算：and, or, not
- 流表达式：For If When

templates功能：根据模块文件动态生成对应的配置文件  
templates文件必须存放于templates目录下，且命名为 .j2 结尾  
yaml/yml 文件需和templates目录平级，目录结构如下：  
 ```
 ./
   ├── temnginx.yml
   └── templates
         └── nginx.conf.j2
 ```
 ```
 Templates示例:
 
1.准备nginx模板文件
 cp /etc/nginx/nginx.conf /data/ansible/templates/nginx.conf.j2
 
2.修改模板中运算核心的选项
 vim nginx.conf.j2
 worker_processes {{ ansible_processor_vcpus**2 }}; #核心数乘2
 或worker_processes {{ ansible_processor_vcpus+2 }};  #核心数加2
 
3.准备yml文件
cat temnginx2.yml
- hosts: appsvrs
  remote_user: root
  
  tasks:
    - name: template config to remote hosts
      template: src=/data/ansible/templates/nginx.conf.j2  dest=/etc/nginx/nginx.conf  #将本机的模板文件拷贝到远程服务器
      
4.运行playbook测试
ansible-playbook temnginx2.yml
```

# when
条件测试:如果需要根据变量、facts或此前任务的执行结果来做为某task执行与否的前提时要用到条件测试,通过when语句实现，在task中使用，jinja2的语法格式  

when语句
在task后添加when子句即可使用条件测试；
when语句支持Jinja2表达式语法  
```
示例：
- hosts: websrvs
  remote_user: root
  
  tasks:
    - name: add group nginx
      tags: user
      user: name=nginx state=present
    - name: add user nginx
      user: name=nginx state=present group=nginx
    - name: Install Nginx
      yum: name=nginx state=present
    - name: restart Nginx
      service: name=nginx state=restarted
      when: ansible_distribution_major_version == “6”
```
```
示例：when条件判断
tasks:
  - name: install conf file to centos7
    template: src=nginx.conf.c7.j2 dest=/etc/nginx/nginx.conf
    when: ansible_distribution_major_version == "7"  #判断版本是否为7
  - name: install conf file to centos6
    template: src=nginx.conf.c6.j2 dest=/etc/nginx/nginx.conf
    when: ansible_distribution_major_version == "6"  #判断版本是否为6
```

## 迭代：with_items
- 迭代：当有需要重复性执行的任务时，可以使用迭代机制  
对迭代项的引用，固定变量名为”item“  
要在task中使用with_items给定要迭代的元素列表  
列表格式：  
字符串  
字典  
```
示例：
- name: add several  users
  user: name={{ item }} state=present groups=wheel
  
  with_items:
    - testuser1
    - testuser2
    
上面语句的功能等同于下面的语句：
- name: add user testuser1
  user: name=testuser1 state=present groups=wheel
- name: add user testuser2
  user: name=testuser2 state=present groups=wheel
```
```
示例：将多个文件进行copy到被控端
---
- hosts: testsrv
  remote_user: root

  tasks
    - name: Create rsyncd config
      copy: src={{ item }} dest=/etc/{{ item }}
      with_items:
        - rsyncd.secrets
        - rsyncd.conf
```
```
- hosts: websrvs
  remote_user: root
  
  tasks:
    - name: copy file
      copy: src={{ item }} dest=/tmp/{{ item }} #循环拷贝文件到目标位置
      with_items:
        - file1
        - file2
        - file3
        - name: yum install httpd
          yum: name={{ item }} state=present #循环安装列表中的服务
      with_items:
        - apr
        - apr-util
        - httpd
```
```
- hosts：websrvs
  remote_user: root
  
  tasks
    - name: install some packages
      yum: name={{ item }} state=present #循环安装列表中的服务
      with_items:
        - nginx
        - memcached
        - php-fpm
```
### 迭代嵌套子变量
```
- hosts：websrvs
  remote_user: root
  
  tasks:
    - name: add some groups
      group: name={{ item }} state=present #创建列表中的组
      with_items:
        - group1
        - group2
        - group3
    - name: add some users
      user: name={{ item.name }} group={{ item.group }} state=present
      with_items:  #新建用户并加入之前创建的组
        - { name: 'user1', group: 'group1' }
        - { name: 'user2', group: 'group2' }
        - { name: 'user3', group: 'group3' }
```

# Playbook中template for if
适合在多主机的情况下批量修改配置文件的参数
```
{% for vhost in nginx_vhosts %}
server {
    listen {{ vhost.listen | default('80 default_server') }}; 
    
{% if vhost.server_name is defined %}
server_name {{ vhost.server_name }};
{% endif %}

{% if vhost.root is defined %}
root {{ vhost.root }};
{% endif %}
```
```
定义一个yml文件
vim temnginx.yml
---
- hosts: mageduweb
 remote_user: root
 vars:
 nginx_vhosts: #变量列表
 - web1
 - web2
 - web3
 tasks:
 - name: template config
 template: src=nginx.conf.j2 dest=/etc/nginx/nginx.conf
 
模板文件
vim templates/nginx.conf.j2
{% for vhost in #使用for循环在变量列表中取值
nginx_vhosts %}
server {
 listen {{ vhost }} #将取到的值写到配置文件中
}
{% endfor %}

生成的结果：
server {
 listen web1
}
server {
 listen web2
}
server {
 listen web3
}
```
```
定义三大组不同参数的变量
vim temnginx.yml
- hosts: mageduweb
 remote_user: root
 vars:  #变量列表
 nginx_vhosts:
 - web1:
 listen: 8080
 root: "/var/www/nginx/web1/"
 - web2:
 listen: 8080
 server_name: "web2.magedu.com"
 root: "/var/www/nginx/web2/"
 - web3:
 listen: 8080
 server_name: "web3.magedu.com"
 root: "/var/www/nginx/web3/"
 tasks:
 - name: template config to
 template: src=nginx.conf.j2 dest=/etc/nginx/nginx.conf

模板文件
vim templates/nginx.conf.j2
{% for vhost in nginx_vhosts %}
server {
 listen {{ vhost.listen }}
 {% if vhost.server_name is defined %}  #此处判断server_name变量是否在变量列表中有定义
 server_name {{ vhost.server_name }}  #如果有就打印
 {% endif %} #if和endif是成对出现
 root {{ vhost.root }}
}
{% endfor %}

生成的结果
server {
 listen 8080
 root /var/www/nginx/web1/
}
server {
 listen 8080
 server_name web2.magedu.com
 root /var/www/nginx/web2/
}
server {
 listen 8080
 server_name web3.magedu.com
 root /var/www/nginx/web3/
}
```
# roles
ansible自1.2版本引入的新特性，用于层次性、结构化地组织playbook。roles
能够根据层次型结构自动装载变量文件、tasks以及handlers等。要使用roles只需
要在playbook中使用include指令即可。简单来讲，roles就是通过分别将变量、
文件、任务、模板及处理器放置于单独的目录中，并可以便捷地include它们的一
种机制。角色一般用于基于主机构建服务的场景中，但也可以是用于构建守护进程
等场景中
- 复杂场景：建议使用roles，代码复用度高   
变更指定主机或主机组    
如命名不规范维护和传承成本大  
某些功能需多个Playbook，通过includes即可实现 

## roles目录结构
每个角色，以特定的层级目录结构进行组织  
roles目录结构：  
playbook.yml  
roles/
- project/
- tasks/
- files/
- vars/
- templates/
- handlers/
- default/ 不常用
- meta/ 不常用

## roles各目录作用
/roles/project/ :项目名称,有以下子目录
- files/ ：存放由copy或script模块等调用的文件
- templates/：template模块查找所需要模板文件的目录
- tasks/：定义task,role的基本元素，至少应该包含一个名为main.yml的文件；其它的文件需要在此文件中通过include进行包含
- handlers/：至少应该包含一个名为main.yml的文件；其它的文件需要在此文件中通过include进行包含
- vars/：定义变量，至少应该包含一个名为main.yml的文件；其它的文件需要在此文件中通过include进行包含
- meta/：定义当前角色的特殊设定及其依赖关系,至少应该包含一个名为main.yml的文件，其它文件需在此文件中通过include进行包含
- default/：设定默认变量时使用此目录中的main.yml文件

## 创建role
创建role的步骤
1. 创建以roles命名的目录
1. 在roles目录中分别创建以各角色名称命名的目录，如webservers等
1. 在每个角色命名的目录中分别创建files、handlers、meta、tasks、
templates和vars目录；用不到的目录可以创建为空目录，也可以不创建
1. 在playbook文件中，调用各角色
```
示例：
nginx-role.yml
roles/
└── nginx
 ├── files
 │ └── main.yml
 ├── tasks
 │ ├── groupadd.yml
 │ ├── install.yml
 │ ├── main.yml
 │ ├── restart.yml
 │ └── useradd.yml
 └── vars
 └── main.yml
```
## playbook调用角色
1. 方法1：
```
- hosts: websrvs
  remote_user: root
  
  roles:
    - mysql
    - memcached
    - nginx
```
2. 方法2：
```
传递变量给角色
 - hosts:
   remote_user:
   
   roles:
     - mysql
     - { role: nginx, username: nginx }
     
 键role用于指定角色名称
 后续的k/v用于传递变量给角色
```
3. 方法3：
```
还可基于条件测试实现角色调用
 roles:
   - { role: nginx, username: nginx, when: ansible_distribution_major_version == ‘7’ }
```

## 完整的roles架构
```
nginx-role.yml 顶层任务调用yml文件
---
- hosts: testweb
  remote_user: root
  
  roles:
    - role: nginx
    - role: httpd 可执行多个role
    
cat roles/nginx/tasks/main.yml
---  #定义yml文件的执行顺序
- include: groupadd.yml
- include: useradd.yml
- include: install.yml
- include: restart.yml
- include: filecp.yml

roles/nginx/tasks/groupadd.yml
---
- name: add group nginx
  user: name=nginx state=present
  
  
  cat roles/nginx/tasks/filecp.yml
---
- name: file copy
  copy: src=tom.conf dest=/tmp/tom.conf
  
以下文件格式类似：
useradd.yml,install.yml,restart.yml

ls roles/nginx/files/
tom.conf
```

## roles playbook tags使用
```
roles playbook tags使用
 ansible-playbook --tags="nginx,httpd,mysql" nginx-role.yml
vim nginx-role.yml
---
- hosts: testweb
  remote_user: root
  roles:
    - { role: nginx ,tags: [ 'nginx', 'web' ] ,when: ansible_distribution_major_version == "6“ }
    - { role: httpd ,tags: [ 'httpd', 'web' ] }
    - { role: mysql ,tags: [ 'mysql', 'db' ] }
    - { role: marridb ,tags: [ 'mysql', 'db' ] }
    - { role: php }
 ```
 
 ## 学习参考资料
http://galaxy.ansible.com  
https://galaxy.ansible.com/explore#/  
http://github.com/  
http://ansible.com.cn/  
https://github.com/ansible/ansible  
https://github.com/ansible/ansible-examples  
