FROM centos:6

WORKDIR /tmp

###INSTALL WGET AND GET LATEST EPEL-RELEASE###
RUN yum -y install epel-release wget && \
    wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm && \
    wget https://centos6.iuscommunity.org/ius-release.rpm && \
    rpm -Uvh ius-release*.rpm && \
    yum -y update

###INSTALL ANSIBLE###
RUN yum -y install ansible

###INSTALL JET###
RUN curl -SLO "https://s3.amazonaws.com/codeship-jet-releases/1.19.3/jet-linux_amd64_1.19.3.tar.gz"
RUN tar -xaC /usr/local/bin -f jet-linux_amd64_1.19.3.tar.gz
RUN chmod +x /usr/local/bin/jet

###INSTALL JQ PARSER###
RUN wget http://stedolan.github.io/jq/download/linux64/jq
RUN chmod +x ./jq
RUN cp jq /usr/bin

###INSTALL GIT###
RUN yum -y install git

###INSTALL PHP###
RUN yum -y install php56u php56u-gd php56u-mcrypt php56u-mbstring php56u-mysql php56u-opcache php56u-fpm php56u-mbstring php56u-pdo php56u-memcache php56u-memcached php56u-xml php56u-redis

###INSTALL COMPOSER###
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

###INSTALL XMLPARSER###
RUN pear install XML_Parser

###INSTALL UNZIP###
RUN yum -y install unzip

###INSTALL AWSCLI###
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && \
    unzip awscli-bundle.zip && \
    ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

RUN echo -e "date.timezone=\"Asia/Singapore\"" > /etc/php.d/timezone.ini
RUN yum -y install gcc-c++ make
RUN curl -sL https://rpm.nodesource.com/setup_9.x | bash -

###INSTALL MEMCACHED###
RUN yum -y install memcached 
RUN memcached -d -u root -m 512 -p root 127.0.0.1

###INSTALL REDIS###
RUN yum -y install redis
RUN service redis start