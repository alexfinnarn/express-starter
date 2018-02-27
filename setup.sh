#!/usr/bin/env bash

START=`date +%s`

ROOT=$(pwd)

# Add Drupal.
drush dl drupal-7.57
mv drupal-7.57 src

# Make files folder and copy settings.php file.
cd ${ROOT}/src/sites/default
cp default.settings.php settings.php && chmod 777 settings.php
mkdir files && chmod -R 777 files

# Add the Express profile.
cd ${ROOT}/src/profiles
git clone git@github.com:CuBoulder/express.git

# Add all bundles on prod.
cd ../sites/all/modules
cp ${ROOT}/scripts/manifest.txt ./
cp ${ROOT}/scripts/import-bundles.sh ./
./import-bundles.sh manifest.txt

# Copy composer setup file and make bin folder.
cp ${ROOT}/scripts/composer-setup.sh src/
mkdir src/bin

# Install Behat dependencies.
cd ${ROOT}/src/profiles/express/tests/Behat
composer install

# Build and run Docker image.
cd ${ROOT}
docker build -t express-php .
docker run --rm -d -p 8058:80 --name express express-php

# Install Drupal site.

END=`date +%s`
TIME=$((${END}-${START}))

echo "-----"
echo "-----"
echo Project setup took ${TIME} seconds.
echo "-----"
echo "-----"
