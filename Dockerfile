# Take the standarad defacto PHP image.
FROM php:7.2-apache

# Source -> destination volume mapping must be done from command line.
#COPY ./src /var/www/html

# Copy configuration.
COPY config/zzz-php.ini /usr/local/etc/php

# Copy bash profile.
COPY config/.bashrc /root


COPY scripts/composer-setup.sh /root


# Add some packages.
RUN apt-get update \
  && apt-get install -y \
    vim \
    wget \
    git \
    zip \
    unzip \
    libjpeg-dev \
    libpng-dev \
    libwebp-dev \
  && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr --with-webp-dir=/user \
  && docker-php-ext-install gd \
  #&& cd /root \
  #&& mkdir bin \
  #&& ./composer-setup.sh \
  #&& ./bin/composer require "drush/drush:8.*"
