#!/bin/sh

if [ ! -f "/var/www/html/index.php" ]; then
    wget -O thirtybees.zip https://github.com/thirtybees/thirtybees/releases/download/1.3.0/thirtybees-v1.3.0.zip
    unzip thirtybees.zip -d /var/www/html/
    chown -R 33. /var/www/html
fi
