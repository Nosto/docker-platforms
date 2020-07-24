#!/bin/bash

# Check if repo is clonned
if [ ! "$(ls -A nosto-prestahop)" ]; then
    git clone git@github.com:Nosto/nosto-prestahop.git
fi
docker-compose up --build