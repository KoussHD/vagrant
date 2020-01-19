echo "******************************************************************************"
echo "Prepare yum repos and install base packages." `date`
echo "******************************************************************************"
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
#cd /etc/yum.repos.d
#rm -f public-yum-ol7.repo
#wget https://yum.oracle.com/public-yum-ol7.repo
#yum install -y yum-utils
#yum-config-manager --enable ol7_developer_EPEL
#yum install -y zip unzip # sshpass 
#yum install -y oracle-database-preinstall-19c
#yum -y update
echo "******************************************************************************"
echo "Kernel parameters." `date`
echo "******************************************************************************"
cat > /etc/sysctl.d/98-oracle.conf <<EOF
fs.file-max = 6815744
kernel.sem = 250 32000 100 128
kernel.shmmni = 4096
kernel.shmall = 1073741824
kernel.shmmax = 4398046511104
kernel.panic_on_oops = 1
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
net.ipv4.conf.all.rp_filter = 2
net.ipv4.conf.default.rp_filter = 2
fs.aio-max-nr = 1048576
net.ipv4.ip_local_port_range = 9000 65500
EOF

/sbin/sysctl -p /etc/sysctl.d/98-oracle.conf


echo "******************************************************************************"
echo "Limits." `date`
echo "******************************************************************************"
cat > /etc/security/limits.d/oracle-database-server-19c-preinstall.conf <<EOF
oracle   soft   nofile    1024
oracle   hard   nofile    65536
oracle   soft   nproc    16384
oracle   hard   nproc    16384
oracle   soft   stack    10240
oracle   hard   stack    32868
oracle   hard   memlock    134217728
oracle   soft   memlock    134217728
EOF


echo "******************************************************************************"
echo "Firewall." `date`
echo "******************************************************************************"
systemctl stop firewalld
systemctl disable firewalld


echo "******************************************************************************"
echo "SELinux." `date`
echo "******************************************************************************"
sed -i -e "s|SELINUX=enabled|SELINUX=permissive|g" /etc/selinux/config
setenforce permissive


echo "******************************************************************************"
echo "User setup." `date`
echo "******************************************************************************"
groupadd -g 54321 oinstall
groupadd -g 54322 dba
groupadd -g 54323 oper

useradd -u 54321 -g oinstall -G dba,oper oracle


echo "******************************************************************************"
echo "Fix for Oracle on RHEL8." `date`
echo "******************************************************************************"
rm -f /usr/lib64/libnsl.so.1
rm -f /usr/lib/libnsl.so.1
ln -s /usr/lib64/libnsl.so.2.0.0 /usr/lib64/libnsl.so.1
ln -s /usr/lib/libnsl.so.2.0.0 /usr/lib/libnsl.so.1