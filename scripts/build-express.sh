#!/usr/bin/env bash

# Define Drupal version.
echo What version of Drupal would you like to download?
read DRUPAL

# Download Drupal.
echo Downloading Drupal...
drush dl drupal-${DRUPAL}
echo Drupal downloaded.

# Move Drupal to docroot.
echo Copying Drupal to docroot.
mv drupal-${DRUPAL} web
echo Drupal copied to docroot.

# Define Express branch.
echo What branch of Express would you like to checkout?
read EXPRESS

# Checkout Express.
echo Cloning and checking out Express.
cd web/profiles
git clone git@github.com:CuBoulder/express.git
cd express

#latesttag=$(git describe --tags)
echo checking out ${EXPRESS}
git checkout ${EXPRESS}

