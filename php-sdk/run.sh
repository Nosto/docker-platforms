#!/bin/bash

# Check if repo is clonned
if [ ! "$(ls -A nosto-php-sdk)" ]; then
    git clone git@github.com:Nosto/php-sdk.git
fi

docker-compose run composer install