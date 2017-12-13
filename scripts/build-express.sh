#!/usr/bin/env bash

DRUPAL_TAG=7.56
EXPRESS_TAG=2.8.0

# Store local project root.
ROOT=$(pwd)
echo Project root is: ${ROOT}

# Export DSLM variables.
drush dl dslm-7.x
export DSLM_BASE="/app/code/dslm_base"
export PACKAGES_BASE="/app/code/packages_base"

# Download Drupal.
echo Downloading Drupal...
cd ${ROOT}/code/dslm_base/cores
drush dl drupal-${DRUPAL_TAG}

# Too slow to clone down whole repo.
#git clone git@github.com:CuBoulder/drupal-7.x.git ${DRUPAL_TAG}
#cd ${DRUPAL_TAG}
#git checkout ${DRUPAL_TAG}

# Checkout Express.
echo Cloning and checking out Express.
cd ${ROOT}/code/dslm_base/profiles
git clone git@github.com:CuBoulder/express.git express-${EXPRESS_TAG}
cd express-${EXPRESS_TAG}

#latesttag=$(git describe --tags)
echo checking out ${EXPRESS_TAG}
git checkout ${EXPRESS_TAG}

echo Now "lando ssh" and "drush dl dslm-7.x" to build a site.

# Move Drupal to docroot.
cd ${ROOT}/web
drush dslm new

# Install site
#echo Installing site...
#drush si express --db-url=mysql://drupal7:drupal7@database:3306/drupal7 -y

# Install Behat dependencies.
#echo Installing Behat dependencies...
#cd profiles/express/test/behat
#composer install

# Start up headless Chrome.
#echo Starting headless Chrome...
#google-chrome-stable --disable-gpu --headless --remote-debugging-address=0.0.0.0 --remote-debugging-port=9222 > /dev/null 2>&1 &
