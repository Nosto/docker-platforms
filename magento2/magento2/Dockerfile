FROM nosto/magento-base:2.4.0

ADD scripts/init-and-run.sh /usr/local/bin/init-and-run
ADD scripts/xdebug.sh /usr/local/bin/xdebug

RUN echo 'www-data ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Install XDebug && APCu
RUN pecl install xdebug apcu && \
    docker-php-ext-enable apcu

# Install gosu
RUN curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.6/gosu-$(dpkg --print-architecture)" && \
    chmod +x /usr/local/bin/gosu
#@TODO: Might not be needed and can be removed to slim the image

USER www-data

RUN composer global require hirak/prestissimo
WORKDIR /var/www/html/magento2

CMD ["init-and-run"]
