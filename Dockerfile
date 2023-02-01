FROM php:8.0-fpm

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -

RUN apt-get update \
    && apt-get -y install git zip unzip vim nodejs

RUN docker-php-ext-install pdo_mysql

RUN npm install -g yarn

WORKDIR /var/app

COPY . /var/app
COPY ./docker/laravel/.env /var/app

RUN cd /usr/bin && curl -s https://getcomposer.org/installer | php && ln -s /usr/bin/composer.phar /usr/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_NO_INTERACTION 1

RUN yarn install
RUN yarn run build
RUN composer update

ENTRYPOINT php artisan serve --host 0.0.0.0 --port 9000
