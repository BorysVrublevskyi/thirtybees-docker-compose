ARG DEBIAN_TAG
ARG PHP_INI_DIR=/usr/local/etc/php
ARG PHP_LDFLAGS=-Wl,-O1 -pie
ARG PHP_CFLAGS=-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64
ARG PHP_CPPFLAGS=-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64
FROM debian:${DEBIAN_TAG}
# FROM debian:bullseye-slim
COPY debian-php7-fpm-entrypoint.sh /usr/local/bin/docker-php-entrypoint
RUN apt-get update && apt-get --no-install-recommends --no-install-suggests --yes --quiet install \
    openssl php-fpm php-bcmath php-gd php-json php-mbstring php-mysql php-xml php-zip \
    php-imap php-curl php-opcache php-memcached && \
    apt-get clean && apt-get --yes --quiet autoremove --purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
        /usr/share/doc/* /usr/share/groff/* /usr/share/info/* /usr/share/linda/* \
        /usr/share/lintian/* /usr/share/locale/* /usr/share/man/*
RUN mkdir --mode=07500 /run/php && chown www-data:www-data /run/php
ENTRYPOINT ["docker-php-entrypoint"]
WORKDIR /var/www/html
# RUN /bin/sh -c set -eux
# cd /usr/local/etc
# if [ -d php-fpm.d ]; then
#     sed 's!=NONE/!=!g' php-fpm.conf.default | tee php-fpm.conf >/dev/null
#     cp php-fpm.d/www.conf.default php-fpm.d/www.conf
# else
#     mkdir php-fpm.d
#     cp php-fpm.conf.default php-fpm.d/www.conf
#     {
#         echo '[global]'
#         echo 'include=etc/php-fpm.d/*.conf'
#     } | tee php-fpm.conf
# fi
# {
#     echo '[global]'
#     echo 'error_log = /proc/self/fd/2'
#     echo
#     echo '; https://github.com/docker-library/php/pull/725#issuecomment-443540114'
#     echo 'log_limit = 8192'
#     echo
#     echo '[www]'
#     echo '; if we send this to /proc/self/fd/1, it never appears'
#     echo 'access.log = /proc/self/fd/2'
#     echo
#     echo 'clear_env = no'
#     echo
#     echo '; Ensure worker stdout and stderr are sent to the main error log.'
#     echo 'catch_workers_output = yes'
#     echo 'decorate_workers_output = no'
# } | tee php-fpm.d/docker.conf
# {
#     echo '[global]'
#     echo 'daemonize = no'
#     echo
#     echo '[www]'
#     echo 'listen = 9000'
# } | tee php-fpm.d/zz-docker.conf
# RUN /bin/sh -c set -eux; 	cd /usr/local/etc; 	if [ -d php-fpm.d ]; then 		sed 's!=NONE/!=!g' php-fpm.conf.default | tee php-fpm.conf > /dev/null; 		cp php-fpm.d/www.conf.default php-fpm.d/www.conf; 	else 		mkdir php-fpm.d; 		cp php-fpm.conf.default php-fpm.d/www.conf; 		{ 			echo '[global]'; 			echo 'include=etc/php-fpm.d/*.conf'; 		} | tee php-fpm.conf; 	fi; 	{ 		echo '[global]'; 		echo 'error_log = /proc/self/fd/2'; 		echo; echo '; https://github.com/docker-library/php/pull/725#issuecomment-443540114'; echo 'log_limit = 8192'; 		echo; 		echo '[www]'; 		echo '; if we send this to /proc/self/fd/1, it never appears'; 		echo 'access.log = /proc/self/fd/2'; 		echo; 		echo 'clear_env = no'; 		echo; 		echo '; Ensure worker stdout and stderr are sent to the main error log.'; 		echo 'catch_workers_output = yes'; 		echo 'decorate_workers_output = no'; 	} | tee php-fpm.d/docker.conf; 	{ 		echo '[global]'; 		echo 'daemonize = no'; 		echo; 		echo '[www]'; 		echo 'listen = 9000'; 	} | tee php-fpm.d/zz-docker.conf
STOPSIGNAL SIGQUIT
EXPOSE 9000
CMD ["php-fpm7.4"]
