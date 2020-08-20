FROM nosto/magento-base:2.4.0

ADD scripts/init-and-run.sh /usr/local/bin/init-and-run

USER www-data

WORKDIR /var/www/html/magento2

CMD ["init-and-run"]
