#!/bin/sh
npm install
bower install --allow-root
grunt build
cp -r /home/deploy/abeer/dist/* /var/www/app