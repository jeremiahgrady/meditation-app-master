php:8.2-fpm-alpine

# Update all base packages that often isn't up to date from "php:8.2-fpm-alpine"
RUN apk --no-cache upgrade

RUN apk --no-cache --update add \
  wget \
  curl \
  build-base \
  libxml2-dev \
  pcre-dev \
  zlib-dev \
  autoconf \
  oniguruma-dev \
  openssl \
  openssl-dev \
  freetype-dev \
  libjpeg-turbo-dev \
  jpeg-dev \
  libpng-dev \
  imagemagick-dev \
  imagemagick \
  icu-dev \
  ca-certificates \
  linux-headers \
  libzip-dev

RUN docker-php-ext-configure gd --with-freetype=/usr/lib/ --with-jpeg=/usr/lib/

RUN docker-php-ext-install \
    mbstring \
    pdo \
    pdo_mysql \
    xml \
    pcntl \
    bcmath \
    zip \
    intl \
    gd \
    sockets

RUN update-ca-certificates

# Install new relic php extension
#RUN wget -r -l1 -nd -A"linux-musl.tar.gz" https://download.newrelic.com/php_agent/release/
#RUN gzip -dc newrelic*.tar.gz | tar xf -
#RUN cd newrelic-php5* && cp ./agent/x64/newrelic-20210902.so /usr/local/lib/php/extensions/no-debug-non-zts-20210902/newrelic.so
#COPY runtime/new-relic.ini /usr/local/etc/php/conf.d/new-relic.ini

# Install new relic daemon
#RUN cd newrelic-php5* && cp ./daemon/newrelic-daemon.x64 /usr/bin/newrelic-daemon
#RUN touch /tmp/newrelic-php_agent.log && touch /tmp/newrelic-daemon.log

# Cleanup
#RUN rm -rf newrelic-php5-*

COPY runtime/bootstrap /opt/bootstrap
COPY runtime/bootstrap.php /opt/bootstrap.php
COPY runtime/php.ini /usr/local/etc/php/php.ini

RUN chmod 755 /opt/bootstrap
RUN chmod 755 /opt/bootstrap.php

ENTRYPOINT []

CMD /opt/bootstrap
