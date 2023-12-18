FROM nosto/php-apache:7.4 as nosto-shopware

MAINTAINER Cid Lopes "cid.lopes@nosto.com"

RUN docker-php-ext-install zip
RUN apt-get update --allow-releaseinfo-change || apt-get update --allow-releaseinfo-change && \
	apt-get install -y -qq vim nano git

RUN cd /opt && git clone https://github.com/shopwareLabs/sw-cli-tools.git && \
    cd sw-cli-tools && git checkout tags/0.5.3 && composer install
RUN cd /var/www/html && \
  	composer create-project shopware/composer-project --no-interaction --stability=dev shopware && \
  	composer require shopware/shopware:5.7.19 --update-with-dependencies

RUN for config_file in $(find /etc/apache2 -type f -exec grep -l "DocumentRoot" {} \;) ; do  sed -i -e 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/shopware|' $config_file ; done

FROM nosto-shopware

ADD scripts/init-and-run.sh /usr/local/bin/init-and-run
CMD ["init-and-run"]