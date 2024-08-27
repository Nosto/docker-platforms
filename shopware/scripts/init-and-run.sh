#!/bin/bash -x

if [ ! -f /var/www/html/shopware/.installed ]; then
  until mysql -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -h"${MYSQL_HOST}"; do
    >&2 echo "MySQL is unavailable - sleeping"
    sleep 5
  done
  cd /var/www/html/shopware

  # Setup variables to populate the .env file
  cp .env.example .env
  if [ "$USE_SSL" == "true" ] ; then
      echo "SetEnvIf X-Forwarded-Proto https HTTPS=on" >> /var/www/html/shopware/.htaccess
      sed -i -e 's*SHOP_URL=https://composer.test/path*SHOP_URL=https://'${VIRTUAL_HOST}'*g' .env
    else
      sed -i -e 's*SHOP_URL=https://composer.test/path*SHOP_URL=http://'${VIRTUAL_HOST}'*g' .env
  fi
  sed -i -e 's*ADMIN_EMAIL=admin@example.com*ADMIN_EMAIL=devnull@example.com*g' .env
  sed -i -e 's*ADMIN_NAME="Demo User"*ADMIN_NAME="Admin"*g' .env
  sed -i -e 's*ADMIN_USERNAME=demo*ADMIN_USERNAME='${ADMIN_USER}'*g' .env
  sed -i -e 's*ADMIN_PASSWORD=demo*ADMIN_PASSWORD='${ADMIN_PASSWORD}'*g' .env
  sed -i -e 's*IMPORT_DEMODATA=true*IMPORT_DEMODATA=y*g' .env
  MYSQL_URI="mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_HOST}:3306/${MYSQL_DATABASE}";
  sed -i -e 's*DATABASE_URL=mysql://shopware:shopware@127.0.0.1:3600/sw-composer*DATABASE_URL='${MYSQL_URI}'*g' .env

  chmod +x ./app/bin/install.sh

  yes | ./app/bin/install.sh -e

  cd /var/www/html/shopware/Plugins/Community/Frontend/NostoTagging
  composer install --no-dev
  cd /var/www/html/shopware/

  bin/console sw:plugin:refresh
  bin/console sw:plugin:install NostoTagging
  bin/console sw:plugin:activate NostoTagging
  
  chown -R www-data:www-data /var/www/html/shopware/
  touch /var/www/html/shopware/.installed
fi

apache2-foreground
