
#!/bin/bash
yum update -y
yum install httpd php php-mysql stress -y
cd /etc/httpd/config/
cp  httpd.config httpd.conf-bak
service restart httpd
chkconfig httpd on
cd /var/www/html/
wget -q -O http://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
cp -r wordpress/* /var/www/html/
chmod -R 755 wp-content
chmod -R apache:apache /var/www/html/wp-content/
rm -rf wordpress  
rm -rf latest.tar.gz
