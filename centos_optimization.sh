#!/bin/bash  
#参考自网络，仅学习使用！
  
[ -f /etc/profile ] && source /etc/profile  
[ -f /etc/init.d/functions ] && source /etc/init.d/functions  
  
function Inspect(){  
# NO_1：检查是否root用户  
    if [[ "$(whoami)" != "root" ]]; then  
        echo "please run this script as root !" >&2  
        exit 1  
    fi  
  
# No_2: 检查系统是否为64位系统，不是就退出  
    platform=`uname -i`  
    if [ $platform != "x86_64" ];then  
        echo "this script is only for 64bit Operating System !"  
        exit 1  
    fi  
  
# NO_3: 检查系统是否是CentOS7  
##Explain: Custom version '6' or '7'  
    distributor=`cat /etc/redhat-release|awk '{print $1}'`  
    VERSION=`cat /etc/redhat-release`  
    if [ $distributor != 'CentOS' ]; then  
        echo "this script is only for ${distributor} series"  
        exit 1  
    fi  
  
cat << EOF
  
   your system Version information: ${VERSION}          
   start optimizing...  
  
EOF
}  
  
function Choice_6_7(){  
# No.4：确认输入Y或者N  
yn="1"  
cat <<EOF
`echo -e "\033[32m Please select CentOS6 or CentOS7 ?  \033[0m"`  
`echo -e "\033[32m     1: CentOS.6.x  \033[0m"`  
`echo -e "\033[32m     2: CentOS.7.x  \033[0m"`  
  
EOF
  
    echo -n "please input [1\2]: "  
    read yn    
    if [ "$yn" != "1" -a "$yn" != "2" ]; then  
        echo "bye-bye!"  
        exit 0  
      else  
        if [ $yn -eq 1 ];then  
            main_6  
          else  
            main_7  
        fi  
    fi  
}  
  
function Count_down(){  
# No.5：倒计时  
    for i in `seq -w 3 -1 1`  
      do  
        echo -ne "\b___${i}";  
        sleep 1;  
    done   
    echo -e "\b Good Luck ^_^!"  
    echo   
}  
  
#=============优化开始==================  
  
# 1: instll repo  
function CentOS6_repo(){  
    yum -y install  wget &>/dev/null
    if [ ! -e "/etc/yum.repos.d/bak" ]; then 
        mkdir /etc/yum.repos.d/bak  
        mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/bak/CentOS-Base.repo.backup  
    fi  
  
    wget -q -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo  
    wget -q -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-6.repo  
    yum clean all >/dev/null 2>&1  
    yum makecache >/dev/null 2>&1  
    echo -e "\033[31m install CentOS6.x repo OK! \033[0m"  
}  
  
function CentOS7_repo(){  
    yum -y install wget &>/dev/null  
    if [ ! -e "/etc/yum.repos.d/bak" ]; then  
        mkdir /etc/yum.repos.d/bak  
        mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/bak/CentOS-Base.repo.backup  
    fi  
    wget -q -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo  
    wget -q -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo  
    yum clean all >/dev/null 2>&1  
    yum makecache >/dev/null 2>&1  
    echo -e "\033[31m install CentOS7.x repo OK! \033[0m"  
}  
  
# 2: 安装必要的软件包  
function Install_Soft(){  
    yum -y install tree nmap sysstat lrzsz dos2unix telnet &>/dev/null  
    yum -y install ntpdate &>/dev/null  
    yum -y install openssl openssh bash &>/dev/null  
    yum -y install bash-comp* &>/dev/null  
    echo -e "\033[31m Soft install Ok! \033[0m"  
}  
  
# 3: 关闭SELinux  
function SELinux(){  
    sed -i 's#SELINUX=enforcing#SELINUX=disabled#' /etc/selinux/config  
    setenforce 0 &>/dev/null  
    echo -e "\033[31m SELinux stop ok \033[0m"  
}  
  
# 4: 设置系统运行级别  
function CentOS6_init(){  
    INIT=`grep '^id:3:initdefault:$' /etc/inittab|wc -l`  
      if [ $INIT -ne 1 ];then  
        echo "id:3:initdefault:" >>/etc/inittab  
      fi  
    echo -e "\033[31m Runlevel 3 Ok! \033[0m"  
}  
  
# 5: 精简开机启动项  
function C6_start_item(){  
    chkconfig --list|grep "3:on"|grep -vE "sshd|crond|network|rsyslog|sysstat"|awk '{print $1}'|sed -r  's#^(.*)#chkconfig \1 off#g'|bash  
    echo -e "\033[31m Stop CentOS_6 Useless service Ok! \033[0m"  
}  
  
function C7_start_item(){  
    #stop firewalld  
    systemctl stop firewalld  
    systemctl disable firewalld &>/dev/null  
    #systemctl stop postfix  
    #systemctl disable postfix  
    echo -e "\033[31m Stop CentOS_7 Useless service Ok! \033[0m"  
}  
  
# 6: 更改SSH配置文件  
function C6_ssh(){  
if [ -f /etc/ssh/sshd_config ];then  
cat >>/etc/ssh/sshd_config <<EOF
Port 22  
PermitEmptyPasswords no  
UseDNS no  
GSSAPIAuthentication no  
LoginGraceTime 3m  
#PermitRootLogin no  
#ListenAddress 172.16.1.41  
EOF
fi  
/etc/init.d/sshd restart >/dev/null 2>&1  
echo -e "\033[31m Configure sshd Ok! \033[0m"  
}  
  
function C7_ssh(){  
if [ -f /etc/ssh/sshd_config ];then  
cat >>/etc/ssh/sshd_config <<EOF
Port 22  
PermitEmptyPasswords no  
UseDNS no  
GSSAPIAuthentication no  
LoginGraceTime 3m  
#PermitRootLogin no  
#ListenAddress 172.16.1.41  
EOF
fi  
systemctl restart sshd  
echo -e "\033[31m Configure sshd Ok! \033[0m"  
}  
  
# 7: 字符集设置  
function C6_UTF(){  
    if [ -f /etc/sysconfig/i18n ];then  
        LANG="en_US.UTF-8"  
        echo 'LANG="en_US.UTF-8"'>/etc/sysconfig/i18n  
        echo -e "\033[31m Character set to UTF-8 \033[0m"  
      else  
        echo "/etc/sysconfig/i18n No file! false"  
    fi  
}  
  
function C7_UTF(){  
    if [ -f /etc/locale.conf ];then  
        LANG="en_US.UTF-8"  
        echo 'LANG="en_US.UTF-8"' >/etc/locale.conf  
      fi  
    echo -e "\033[31m Character set to UTF-8 \033[0m"  
}  
  
# 8: 设置时间同步  
function NTPdate(){  
    /usr/sbin/ntpdate time.nist.gov >/dev/null 2>&1  
    echo "#Time synchronization system-`date +%F`" >/var/spool/cron/root  
    echo '*/5 * * * * /usr/sbin/ntpdate time.nist.gov >/dev/null 2>&1' >>/var/spool/cron/root  
    date  
    echo -e "\033[31m ntpdate Ok! \033[0m"  
}  
  
# 9: 调整Linux系统文件描述符数量  
function Ulimit(){  
    sed -i "/^ulimit -SHn.*/d" /etc/rc.local  
    sed -i "/^ulimit -s.*/d" /etc/profile  
    sed -i "/^ulimit -c.*/d" /etc/profile  
    sed -i "/^ulimit -SHn.*/d" /etc/profile  
  
if [ -f /etc/security/limits.conf ];then  
    cp -a /etc/security/limits.conf /etc/security/limits.conf.`date +%F`.bak  
cat >> /etc/security/limits.conf <<EOF
  
#-- File descriptor number adjustment --------  
*                -       nofile          65535  
EOF
fi  
echo -e "\033[31m limits Ok! \033[0m"  
}  
  
# 10: Linux服务器内核参数优化  
function Sysctl(){  
    if [ ! -f /etc/sysctl.conf.`date +%F`.bak ];then  
        cp -a /etc/sysctl.conf /etc/sysctl.conf.`date +%F`.bak  
    fi  
    sed -i "/^net.ipv4.tcp_fin_timeout/d" /etc/sysctl.conf  
    sed -i "/^net.ipv4.tcp_tw_reuse/d" /etc/sysctl.conf  
    sed -i "/^net.ipv4.tcp_tw_recycle/d" /etc/sysctl.conf  
    sed -i "/^net.ipv4.tcp_syncookies/d" /etc/sysctl.conf  
    sed -i "/^net.ipv4.tcp_keepalive_time/d" /etc/sysctl.conf  
    sed -i "/^net.ipv4.ip_local_port_range/d" /etc/sysctl.conf  
    sed -i "/^net.ipv4.tcp_max_syn_backlog/d" /etc/sysctl.conf  
    sed -i "/^net.ipv4.tcp_max_tw_buckets/d" /etc/sysctl.conf  
    sed -i "/^net.ipv4.route.gc_timeout/d" /etc/sysctl.conf  
    sed -i "/^net.ipv4.tcp_syn_retries/d" /etc/sysctl.conf  
    sed -i "/^net.ipv4.tcp_synack_retries/d" /etc/sysctl.conf  
    sed -i "/^net.core.somaxconn/d" /etc/sysctl.conf  
    sed -i "/^net.core.netdev_max_backlog/d" /etc/sysctl.conf  
    sed -i "/^net.ipv4.tcp_max_orphans/d" /etc/sysctl.conf  
  
#add  
cat >> /etc/sysctl.conf <<EOF
  
#-----------Kernel optimization--------  
net.ipv4.tcp_fin_timeout = 2  
net.ipv4.tcp_tw_reuse = 1  
net.ipv4.tcp_tw_recycle = 1  
net.ipv4.tcp_syncookies = 1  
net.ipv4.tcp_keepalive_time = 600  
net.ipv4.ip_local_port_range = 4000    65000  
net.ipv4.tcp_max_syn_backlog = 16384  
net.ipv4.tcp_max_tw_buckets = 36000  
net.ipv4.route.gc_timeout = 100  
net.ipv4.tcp_syn_retries = 1  
net.ipv4.tcp_synack_retries = 1  
net.core.somaxconn = 16384  
net.core.netdev_max_backlog = 16384  
net.ipv4.tcp_max_orphans = 16384  
EOF
  
    #delete  
    sed -i "/^kernel.shmmax/d" /etc/sysctl.conf  
    sed -i "/^kernel.shmall/d" /etc/sysctl.conf  
  
    #add  
    shmmax=`free -l |grep Mem |awk '{printf("%d\n",$2*1024*0.9)}'`  
    shmall=$[$shmmax/4]  
    echo "kernel.shmmax = "$shmmax >> /etc/sysctl.conf  
    echo "kernel.shmall = "$shmall >> /etc/sysctl.conf  
    sysctl -p >/dev/null 2>&1  
    echo -e "\033[31m Kernel optimization Ok! \033[0m"  
}  
  
# 11: 定时清理邮件目录的垃圾文件  
function Rm_mail(){  
if [ -d /var/spool/clientmqueue/ ];then  
  find /var/spool/clientmqueue/ -type f|xargs rm -f  
  mkdir -p /var/spool/scripts/  
cat >/var/spool/scripts/Dtm.sh <<EOF
#!/bin/bash  
#Explain: Delete temporary mail  
find /var/spool/clientmqueue/ -type f|xargs rm -f  
EOF
  
echo ' ' >>/var/spool/cron/root  
echo '#Delete temporary mail' >>/var/spool/cron/root  
echo '/bin/sh /var/spool/scripts/Dtm.sh >/dev/null 2>&1' >>/var/spool/cron/root  
fi  
  
if [ -d /var/spool/postfix/maildrop/ ];then  
  find /var/spool/postfix/maildrop/ -type f|xargs rm -f  
  mkdir -p /var/spool/scripts/  
cat >/var/spool/scripts/Dtm02.sh <<EOF
#!/bin/bash  
#Explain: Delete temporary mail  
find /var/spool/postfix/maildrop/ -type f|xargs rm -f  
EOF
  
echo ' ' >>/var/spool/cron/root  
echo "#Delete temporary mail" >>/var/spool/cron/root  
echo '/bin/sh /var/spool/scripts/Dtm02.sh >/dev/null 2>&1' >>/var/spool/cron/root  
fi  
echo -e "\033[31m Spam mail clearance Ok! \033[0m"  
}  
  
# 12: 隐藏Linux版本信息显示  
function RM_Versioninfo(){  
    if [ -f /etc/issue ];then  
        >/etc/issue  
    fi  
  
    if [ -f /etc/issue.net ];then  
        >/etc/issue.net  
    fi  
    echo -e "\033[31m Version information delete Ok! \033[0m"  
}  
  
# 13: hosts config  
function Hosts(){  
cat >>/etc/hosts <<EOF
`hostname -I`  `hostname`  
EOF
}  
  
function done_ok(){  
cat << EOF
  
+------------------------------------------------------------------------+  
                   optimizer is done   
 Congratulations on your system optimization complete  
              System reboot ount down 10s                 
+------------------------------------------------------------------------+  
  
EOF
}  
  
function REBOOT(){  
for i in `seq -w 9 -1 0`  
  do  
    echo -ne "\b__$i";  
    sleep 1;  
done   
echo -e "\b system reboot..."  
sleep 1  
reboot &>/dev/nill  
}  
  
function main_6(){  
    Count_down  
    CentOS6_repo  
    Install_Soft  
    SELinux  
    CentOS6_init  
    C6_start_item  
    C6_ssh  
    C6_UTF  
    NTPdate  
    Ulimit  
    Sysctl  
    Rm_mail  
    RM_Versioninfo  
    Hosts  
    done_ok  
    REBOOT  
}  
  
function main_7(){  
    Count_down  
    CentOS7_repo  
    Install_Soft  
    SELinux  
    C7_start_item  
    C7_ssh  
    C7_UTF  
    NTPdate  
    Ulimit  
    Sysctl  
    Rm_mail  
    RM_Versioninfo  
    Hosts  
    done_ok  
    REBOOT  
}  
  
function main(){  
    Inspect  
    Choice_6_7  
}
  
main
exit 0
