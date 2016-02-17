FROM ubuntu:trusty
MAINTAINER Frank Wei

# Install EPEL
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

RUN apt-get -y update

RUN apt-get -y install vim tar

RUN apt-get -y install httpd

# install php
RUN apt-get install -y php php-mysql php-devel php-gd php-pecl-memcache php-pspell php-snmp php-xmlrpc php-xml

# Install MBstring
RUN apt-get install mbstring php-mbstring -y

# Install Mcrypt
RUN apt-get install mcrypt php-mcrypt -y

# Install wget and tar
RUN apt-get install wget tar -y

# Add IonCube Loaders
RUN mkdir /tmp/ioncube_install
WORKDIR /tmp/ioncube_install
RUN wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -O /tmp/ioncube_install/ioncube_loaders_lin_x86-64.tar.gz
RUN tar zxf /tmp/ioncube_install/ioncube_loaders_lin_x86-64.tar.gz
RUN mv /tmp/ioncube_install/ioncube/ioncube_loader_lin_5.3.so /usr/lib64/php/modules
RUN rm -rf /tmp/ioncube_install

# Add Ioncube.ini
ADD 20-ioncube.ini /etc/php.d/20-ioncube.ini

# Add HTTPD Conf
ADD httpd.conf /etc/httpd/conf/httpd.conf

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
