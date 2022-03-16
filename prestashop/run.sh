#!/bin/bash

# Check if repo is clonned
if [ ! "$(ls -A nosto-prestashop)" ]; then
    git clone git@github.com:Nosto/nosto-prestashop.git
fi

if [ ! "$(ls -A prestashop_root)" ]; then
    mkdir prestashop_root
    echo "Copying prestashop root files to host storage for IDE completion, this will take a while..."
    docker run -i --name prestashop_root_code_gen \
        --volume=$(pwd)/prestashop_root:/var/www/html/prestashop_copy \
         nosto/prestashop-base:1.7.6.7 \
         mv "/var/www/html/prestashop/" "/var/www/html/prestashop_copy"

    docker rm -f prestashop_root_code_gen
fi

docker-compose up -d db_ps prestashop