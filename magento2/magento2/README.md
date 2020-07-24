# Dockerized NostoTagging Magento 2 Enviroment

This project runs under traefik.


## First steps
- Modify your `docker-compose.yml` file and add you Magento keys. You can find those by logging into you `developer.magento.com` account, under API keys.
- Execute `./run.sh` to clone the nosto-magento2 and start the containers in the background
- It should run on you browser at the host `magento2.dev.nos.to` on port 80.


## Using XDebug

There's a script inside the container to enable/disable XDebug. The default exposed port is 9002.
To run the script, use `docker-compose exec magento2 'sudo -E xdebug on'`

## ElasticSearch
<!-- @TODO// -->

## RabbitMQ
Use `magento2.dev.nos.to:15672` to access the management panel.
User is `guest` and password is also `guest`