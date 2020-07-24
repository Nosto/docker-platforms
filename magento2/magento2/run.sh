#!/bin/bash

# Check if repo is clonned
if [ ! "$(ls -A nosto-magento2)" ]; then
    git clone git@github.com:Nosto/nosto-magento2.git
fi
docker-compose up --build