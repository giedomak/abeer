#!/bin/sh
npm install
bower install
grunt build
cp -r /home/deploy/abeer/dist/* /var/www/app