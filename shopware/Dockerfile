FROM nosto/php-apache:7.2 as nosto/shopware:5.6.2

MAINTAINER Cid Lopes "cid@nosto.com"

RUN docker-php-ext-install zip
RUN apt-get update --allow-releaseinfo-change || apt-get update --allow-releaseinfo-change && \
	apt-get install -y -qq vim nano git

# Download packages in parallel
RUN composer global require hirak/prestissimo
RUN cd /opt && git clone https://github.com/shopwareLabs/sw-cli-tools.git && \
    cd sw-cli-tools && git checkout tags/0.3.0 && composer install
RUN cd /var/www/html && \
  	composer create-project shopware/composer-project --no-interaction --stability=dev shopware && \
  	composer require shopware/shopware:5.6.2 --update-with-dependencies

RUN for config_file in $(find /etc/apache2 -type f -exec grep -l "DocumentRoot" {} \;) ; do  sed -i -e 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/shopware|' $config_file ; done

FROM nosto/shopware:5.6.2

ADD scripts/init-and-run.sh /usr/local/bin/init-and-run
CMD ["init-and-run"]