#!/usr/bin/env bash

# Define initial gathering of Drupal and Express.
DRUPAL_TAG=7.56-hardered
EXPRESS_TAG=2.8.0

# Store local project root.
ROOT='/Users/alfi2595/Sites/exs'
echo Project root is: ${ROOT}

# Download Drupal.
echo Cloning and checking out ${DRUPAL_TAG}...
cd ${ROOT}/code/dslm_base/cores
git clone git@github.com:CuBoulder/drupal-7.x.git ${DRUPAL_TAG}
cd ${DRUPAL_TAG}
git checkout ${DRUPAL_TAG}

# Checkout Express.
echo Cloning and checking out Express ${EXPRESS_TAG}...
cd ${ROOT}/code/dslm_base/profiles
git clone git@github.com:CuBoulder/express.git express-${EXPRESS_TAG}
cd express-${EXPRESS_TAG}
git checkout ${EXPRESS_TAG}

# Install Behat dependencies.
#echo Installing Behat dependencies...
#cd ${ROOT}/code/dslm_base/profiles/express-${EXPRESS_TAG}/tests/behat
#composer install

