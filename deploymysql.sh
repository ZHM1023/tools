#!/usr/bin/env bash
#
# Author: bavdu
# Email: bavduer@163.com
# Date: 2019/04/19
# Usage: deploy mysql source installstion.

yum -y groupinstall "Development Tools"
yum -y install ncurses ncurses-devel bison libgcrypt perl make cmake

if id mysql;then
  echo "mysql user is exists."
else
  groupadd mysql && useradd -M -g mysql -s /sbin/nologin mysql
fi

tar xf $1 -C /usr/local/

chown -R mysql.mysql /usr/local/mysqld
echo "export PATH=$PATH:/usr/local/mysqld/mysql/bin" >>/etc/profile
source /etc/profile

rm -rf /etc/my.cnf
cp -f /usr/local/mysqld/my.cnf /etc/my.cnf

cp -f /usr/local/mysqld/mysql/support-files/mysql.server /etc/init.d/mysqld
chkconfig --add mysqld
chkconfig mysqld on

ln -s /usr/local/mysqld/tmp/mysql.sock /tmp/mysql.sock
cp -f /usr/local/mysqld/mysql/support-files/mysql.server /usr/bin/mysql.service
