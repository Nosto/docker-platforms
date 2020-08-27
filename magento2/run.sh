#!/bin/bash

# Check if repo is clonned
if [ ! "$(ls -A nosto-magento2)" ]; then
    git clone git@github.com:Nosto/nosto-magento2.git
fi

if [ ! "$(ls -A magento_root)" ]; then
	mkdir magento_root
	echo "Copying Magento root files to host storage, this will take a while..."
	docker run -i --name mage_code_gen \
		--volume=$(pwd)/magento_root:/var/www/html/magento_copy \
		 nosto/magento-base:2.4.0 \
		 mv "/var/www/html/magento2/" "/var/www/html/magento_copy"

	docker rm -f mage_code_gen
fi

docker-compose up -d