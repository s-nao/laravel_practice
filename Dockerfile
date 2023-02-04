FROM php:8.1-fpm

RUN apt-get update \
    && apt-get -y install git zip unzip vim

RUN docker-php-ext-install pdo_mysql

WORKDIR /var/www

COPY . /var/www
COPY ./docker/laravel/.env /var/www
COPY ./docker/laravel/php-8.1.ini /usr/local/etc/php

RUN chown www-data storage/ -R

RUN cd /usr/bin && curl -s https://getcomposer.org/installer | php && ln -s /usr/bin/composer.phar /usr/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_NO_INTERACTION 1

RUN composer update

