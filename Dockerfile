FROM kibatic/symfony:8.2-fpm-alpine

RUN apk update
RUN apk add docker

ADD index.php /var/www/public/index.php
RUN touch /var/www/public/metrics
RUN chmod 755 -R /var/www/public

ADD symfony_version.sh /symfony_version.sh
RUN chmod 755 /symfony_version.sh
ADD crontab /exporter-crontab
RUN /usr/bin/crontab /exporter-crontab
