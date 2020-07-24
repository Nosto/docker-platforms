FROM nosto/php-apache:7.2

MAINTAINER Cid Lopes "alannettto@gmail.com"

ADD config/auth.json /root/.composer/

# Install Magento 2
RUN cd /var/www/html && \
    composer self-update && composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=2.3.4 magento2 && \
    cd magento2 && \
    find . -type d -exec chmod 770 {} \; && find . -type f -exec chmod 660 {} \; && chmod u+x bin/magento

# Install Sample Data
RUN cd /var/www/html/magento2 && \
    git clone https://github.com/magento/magento2-sample-data.git && \
    M2_BRANCH="$(cat composer.json | jq -r '.version')" && \
    cd magento2-sample-data && \
    git checkout $M2_BRANCH && \
    cd /var/www/html/magento2/ && \
    # Create Symlinks
    php -f magento2-sample-data/dev/tools/build-sample-data.php -- --ce-source="$(pwd)" && \
    chown -R www-data:www-data /var/www

RUN rm /root/.composer/auth.json

ENV PATH $PATH:/var/www/html/magento2/bin

RUN for config_file in $(find /etc/apache2 -type f -exec grep -l "DocumentRoot" {} \;) ; do  sed -i -e 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/magento2|' $config_file ; done

ADD config/magento.cron /etc/cron.d/magento
RUN chmod 0600 /etc/cron.d/magento
ADD config/robots.txt /var/www/html/magento2