#!/bin/bash -x

until mysql -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -h"${MYSQL_HOST}"; do
  >&2 echo "MySQL is unavailable - sleeping"
  sleep 5
done

if [ ! -f /var/www/html/prestashop/.installed ]; then
  cd /var/www/html/prestashop/install

  php index_cli.php \
    --step=all \
    --language=en \
    --base_uri=/ \
    --domain=${VIRTUAL_HOST} \
    --db_server=${MYSQL_HOST} \
    --db_user=${MYSQL_USER} \
    --db_password=${MYSQL_PASSWORD} \
    --email=${ADMIN_EMAIL} \
    --password=${ADMIN_PASSWORD} \
    --db_create=1 \
    --db_clear=1 \
    --newsletter=0 \
    --send_email=0

  cd /var/www/html/prestashop && rm -rf install && mv admin adminn0st0

  mysql -h ${MYSQL_HOST} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} \
        -D ${MYSQL_DATABASE} \
        -Bse 'UPDATE ps_configuration SET value = 0 WHERE name = "PS_CANONICAL_REDIRECT"; UPDATE ps_configuration SET value = 0 WHERE name = "PS_SSL_ENABLED"; INSERT INTO ps_configuration (name,value) VALUES ("PS_SSL_ENABLED_EVERYWHERE","0");'
  
  # Install Prestashop Nosto Extension
  cd /var/www/html/prestashop/modules/nostotagging && \
    composer install --no-dev
  
  cd /var/www/html/prestashop
  bin/console prestashop:module install nostotagging

  bin/console doctrine:query:sql 'UPDATE ps_configuration SET value = 2 WHERE name = "PS_MAIL_METHOD"'

  touch .installed
  chown -R www-data:www-data /var/www/html/prestashop
fi

apache2-foreground
