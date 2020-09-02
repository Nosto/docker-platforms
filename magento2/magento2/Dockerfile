FROM nosto/php-apache:7.3

ADD scripts/init-and-run.sh /usr/local/bin/init-and-run
ADD config/magento.cron /etc/cron.d/magento
RUN chmod 0600 /etc/cron.d/magento
ADD config/robots.txt /var/www/html/magento2

USER www-data

WORKDIR /var/www/html/magento2

CMD ["init-and-run"]
