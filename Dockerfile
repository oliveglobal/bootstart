##############Ubuntu LAMP stack with Apache, MariaDB, PHP, and SSL##########################

FROM ubuntu

MAINTAINER Ranjan Kumar

ENV DEBIAN_FRONTEND noninteractive

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Install Apache, SSL, PHP, and some PHP modules

RUN apt-get update && apt-get install -y apache2 \
 openssl \
 php56 \
 php56-cli \
 php56-apcu

# Install MariaDB and set default root password

RUN echo 'mariadb-server mariadb-server/root_password  password mypassword' | debconf-set-selections
RUN echo 'mariadb-server mariadb-server/root_password_again password mypassword' | debconf-set-selections
RUN apt-get install mariadb-server -y

# Disable the default Apache site config
# Install your site's Apache configuration and activate SSL

ADD my_apache.conf /etc/apache2/sites-available/
RUN a2dissite 000-default
RUN a2ensite my_apache
RUN a2enmod ssl

# Remove APT files
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 443 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
