#!/usr/bin/env bash

# Define initial gathering of Drupal and Express.
DRUPAL_TAG=7.57

# We can't use tags since we don't always tag.
# EXPRESS_TAG=2.8.0

# Store local project root.
ROOT=$(pwd)
echo Project root is: ${ROOT}

# Download Drupal.
echo Cloning and checking out ${DRUPAL_TAG}...
cd ${ROOT}/code/dslm_base/cores

#git clone git@github.com:CuBoulder/drupal-7.x.git drupal-${DRUPAL_TAG}
#cd ${DRUPAL_TAG}
#git checkout ${DRUPAL_TAG}

drush dl drupal-${DRUPAL_TAG}
cd drupal-${DRUPAL_TAG}/modules
rm -rf php aggregator blog book color contact translation dashboard forum locale openid overlay poll rdf search statistics toolbar tracker trigger

# Checkout Express.
echo Cloning and checking out Express ${EXPRESS_TAG}...
cd ${ROOT}/code/dslm_base/profiles
git clone -b ${EXPRESS_TAG} git@github.com:CuBoulder/express.git express-${EXPRESS_TAG}

# Install Behat dependencies.
#echo Installing Behat dependencies...
#cd ${ROOT}/code/dslm_base/profiles/express-${EXPRESS_TAG}/tests/behat
#composer install

