ARG PHP_TAG
FROM php:${PHP_TAG}
# FROM php:7.3-fpm
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libonig-dev \
        libmcrypt-dev \
        libpng-dev \
        libcurl3-dev \
        libxml2-dev \
	    libzip-dev \
	    openssl \
      zip \
	    unzip \
        # for imap
        libc-client-dev libkrb5-dev \
    && docker-php-ext-install -j$(nproc) bcmath gd json mbstring pdo_mysql xml zip curl opcache \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install -j$(nproc) imap
    # && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    # && docker-php-ext-install -j$(nproc) gd

# Install memcached
RUN apt-get update && apt-get install --no-install-recommends -y memcached libmemcached-dev libmemcached-tools libzip-dev zlib1g git \
  && docker-php-ext-configure zip \
  && docker-php-ext-install zip \
  && git clone https://github.com/php-memcached-dev/php-memcached --branch v3.2.0 /usr/src/php/ext/memcached \
  && cd /usr/src/php/ext/memcached \
  && docker-php-ext-configure memcached \
  && docker-php-ext-install memcached
