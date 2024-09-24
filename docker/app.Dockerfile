FROM php:8.2-fpm-alpine AS base

RUN useradd -r webuser -u 1000

RUN apk --update add wget \
    curl \
    git \
    grep \
    build-base \
    libmemcached-dev \
    libmcrypt-dev \
    libxml2-dev \
    imagemagick-dev \
    pcre-dev \
    libtool \
    make \
    autoconf \
    g++ \
    cyrus-sasl-dev \
    libgsasl-dev \
    supervisor

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN docker-php-ext-install mysqli pdo pdo_mysql xml
RUN pecl channel-update pecl.php.net \
    && pecl install memcached \
    && pecl install imagick \
    && docker-php-ext-enable memcached \
    && docker-php-ext-enable imagick

RUN rm /var/cache/apk/*

WORKDIR /var/www


COPY ../dev/docker-compose/php/supervisord-app.conf /etc/supervisord.conf

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]

FROM base AS dev

COPY ../ /var/www
COPY ../dev/docker-compose/php/app.ini /usr/local/etc/php/conf.d/app.ini

RUN composer install --prefer-dist --no-ansi --no-dev --no-autoloader

COPY ../bootstrap bootstrap
COPY ../app app
COPY ../config config
COPY ../routes routes

RUN composer dump-autoload -o

FROM dev AS fpm

COPY --from=dev /var/www/html /var/www/html

EXPOSE 5173

