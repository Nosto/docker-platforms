#!/bin/bash

# Check if repo is clonned
if [ ! "$(ls -A nosto-shopware)" ]; then
    git clone git@github.com:Nosto/nosto-shopware.git
fi

docker-compose up --build -d
./copy_root_to_host.sh