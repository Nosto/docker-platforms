FROM nosto/php-apache:7.2

MAINTAINER Cid Lopes "alannettto@gmail.com"

ENV PRESTASHOP_VERSION 1.7.6.7
ENV PRESTASHOP_ARCHIVE prestashop_${PRESTASHOP_VERSION}

RUN cd / && wget https://github.com/PrestaShop/PrestaShop/releases/download/${PRESTASHOP_VERSION}/${PRESTASHOP_ARCHIVE}.zip && \
	cd / && mkdir -m 755 -p /var/www/html/prestashop && \
	cd / && unzip ${PRESTASHOP_ARCHIVE} -d /var/www/html/prestashopwrap/ && \
	cd /&& unzip /var/www/html/prestashopwrap/prestashop.zip -d /var/www/html/prestashop/ && \
	chown -R www-data:www-data /var/www/html/prestashop && \
    rm -rf /${PRESTASHOP_ARCHIVE}.zip \
    rm -rf /var/www/html/prestashopwrap

RUN for config_file in $(find /etc/apache2 -type f -exec grep -l "DocumentRoot" {} \;) ; do  sed -i -e 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/prestashop|' $config_file ; done
