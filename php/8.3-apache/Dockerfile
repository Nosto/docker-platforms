FROM php:8.3-apache

ENV TERM=xterm
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN apt-get update && \
    apt-get -y -qq install apt-transport-https locales jq zip unzip wget \
        libfreetype6-dev libjpeg-dev libpng-dev mariadb-client \
        libmcrypt-dev libzip-dev libxml2-dev libxslt1-dev libicu-dev libonig-dev \
        vim nano git wget gnupg cron sudo && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales && \
    localedef -i en_US -f UTF-8 en_US.UTF-8 && \
    apt-get -y clean && \
    touch /var/log/cron.log

RUN a2enmod rewrite headers expires

# Install PHP extensions & composer
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd pdo_mysql soap xsl zip opcache bcmath intl sockets && \
    php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

RUN apt-get update && apt-get install -y \
    libpcre2-dev \
    libxml2-dev \
    && pecl install ast \
    && docker-php-ext-enable ast \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo 'www-data ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY conf/customphp.ini /usr/local/etc/php/conf.d/customphp.ini
ADD scripts/xdebug.sh /usr/local/bin/xdebug
