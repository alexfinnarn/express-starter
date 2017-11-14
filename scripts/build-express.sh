#!/usr/bin/env bash

# Download Drupal.
echo Downloading Drupal...
drush dl drupal-7.56
echo Drupal downloaded.

# Move Drupal to docroot.
echo Copying Drupal to docroot.
cp -R drupal-7.56/* web
echo Drupal copied to docroot.

# Clone Express.
echo Cloning and checking out Express.
cd web/profiles
git clone git@github.com:CuBoulder/express.git

# Checkout latest tag.
cd express
latesttag=$(git describe --tags)
echo checking out ${latesttag}
git checkout ${latesttag}

