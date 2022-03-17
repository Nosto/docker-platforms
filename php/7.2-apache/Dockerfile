FROM php:7.2-apache

MAINTAINER Cid Lopes "cid.lopes@nosto.com"

ENV TERM=xterm
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN apt-get update && \
    apt-get -y -qq install apt-transport-https locales jq zip unzip wget \
        libfreetype6-dev libjpeg-dev libpng-dev mariadb-client \
        libmcrypt-dev libxml2-dev libxslt1-dev libicu-dev \
        vim nano git wget gnupg cron sudo && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales && \
    localedef -i en_US -f UTF-8 en_US.UTF-8 && \
    apt-get -y clean && \
    touch /var/log/cron.log

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN a2enmod rewrite headers expires

# Install PHP extensions & composer
RUN pecl install ast mcrypt-1.0.1 && \
    docker-php-ext-enable ast && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd mysqli pdo_mysql mbstring soap xsl zip opcache bcmath intl pcntl && \
    docker-php-ext-enable mcrypt && \
    php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    composer global require hirak/prestissimo

COPY conf/customphp.ini /usr/local/etc/php/conf.d/customphp.ini
ADD scripts/xdebug.sh /usr/local/bin/xdebug