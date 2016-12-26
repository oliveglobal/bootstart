#!/bin/bash
yum update -y
yum install httpd php php-mysql mysql mysql-server -y
chkconfig httpd on
chkconfig mysqld on
service restart httpd
service restart mysqld
cp /etc/httpd/config/httpd.conf  /etc/httpd/config/httpd.conf-bak
wget -q -O http://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
cp -r wordpress/* /var/www/html/
chmod -R 755 /var/www/html/wp-content/
chmod -R apache:apache /var/www/html/wp-content/
rm -rf wordpress  latest.tar.gz
