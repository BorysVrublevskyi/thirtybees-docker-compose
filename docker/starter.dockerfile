FROM alpine:latest
COPY starter-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
# COPY starter-entrypoint.sh docker-entrypoint.sh
WORKDIR /var/www/html/
RUN apk --update add openssl wget unzip && rm -rf /var/cache/apk/*
# CMD  ["/bin/bash", "-c"]
CMD /usr/local/bin/docker-entrypoint.sh
