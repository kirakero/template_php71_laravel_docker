FROM notafroggie/php71_common

COPY . /srv/app
COPY .docker/vhost.conf /etc/apache2/sites-available/000-default.conf

RUN composer dumpautoload

