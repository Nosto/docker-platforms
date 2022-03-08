#!/bin/bash

if [ ! "$(ls -A shopware_root)" ]; then
    mkdir shopware_root
    echo "Copying shopware root files to host storage for IDE completion, this will take a while..."
    docker run -i --name shopware_root_code_gen \
        --volume=$(pwd)/shopware_root:/var/www/html/shopware_copy \
         nosto/shopware:5.6.2 \
         mv "/var/www/html/shopware/" "/var/www/html/shopware_copy"

    docker rm -f shopware_root_code_gen
fi