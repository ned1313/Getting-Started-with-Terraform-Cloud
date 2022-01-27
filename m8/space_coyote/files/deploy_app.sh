#!/bin/bash
# Script to deploy a very simple web application.
# The web app has a customizable image and some text.

sudo apt -y update
sudo apt -y install apache2 cowsay unzip
sudo systemctl start apache2

wget https://github.com/ned1313/FlappyBird-JavaScript/archive/refs/heads/master.zip
unzip master.zip
sudo chown -R ubuntu:ubuntu /var/www/html

cp -r FlappyBird-JavaScript-master/* /var/www/html/

cowsay Space Coyote - Curses!!!