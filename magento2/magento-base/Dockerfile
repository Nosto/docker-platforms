FROM php:7.2-apache

MAINTAINER Cid Lopes "alannettto@gmail.com"

ENV TERM=xterm
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN apt-get update && \
    apt-get -y -qq install apt-transport-https locales jq unzip wget \
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

ADD config/auth.json /root/.composer/
COPY conf/customphp.ini /usr/local/etc/php/conf.d/customphp.ini

# Install Magento 2
RUN cd /var/www/html && \
    composer self-update && composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=2.3.4 magento2 && \
    cd magento2 && \
    find . -type d -exec chmod 770 {} \; && find . -type f -exec chmod 660 {} \; && chmod u+x bin/magento

# Install Sample Data
RUN cd /var/www/html/magento2 && \
    git clone https://github.com/magento/magento2-sample-data.git && \
    M2_BRANCH="$(cat composer.json | jq -r '.version')" && \
    cd magento2-sample-data && \
    git checkout $M2_BRANCH && \
    cd /var/www/html/magento2/ && \
    # Create Symlinks
    php -f magento2-sample-data/dev/tools/build-sample-data.php -- --ce-source="$(pwd)" && \
    chown -R www-data:www-data /var/wwwRUN   chown -R www-data:www-data /var/www

RUN rm /root/.composer/auth.json

ENV PATH $PATH:/var/www/html/magento2/bin

RUN for config_file in $(find /etc/apache2 -type f -exec grep -l "DocumentRoot" {} \;) ; do  sed -i -e 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/magento2|' $config_file ; done

ADD config/magento.cron /etc/cron.d/magento
RUN chmod 0600 /etc/cron.d/magento
ADD config/robots.txt /var/www/html/magento2