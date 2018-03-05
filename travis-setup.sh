#!/usr/bin/env bash

START=`date +%s`

# Store local project root.
ROOT=$(pwd)
echo Project root is: ${ROOT}

# Define initial gathering of Drupal and Express.
DRUPAL_TAG=7.57
# The tag is only used here to create the DSLM directory.
EXPRESS_TAG=2.8.5

# Download Drupal.
echo "Cloning and checking out ${DRUPAL_TAG}..."
cd ${ROOT}/code/dslm_base/cores

drush dl drupal-${DRUPAL_TAG} -y
cd drupal-${DRUPAL_TAG}/modules
rm -rf php aggregator blog book color contact translation dashboard forum locale openid overlay poll rdf search statistics toolbar tracker trigger

# Checkout Express.
echo "Cloning and checking out Express ${EXPRESS_TAG}..."
cd ${ROOT}/code/dslm_base/profiles
git clone --depth 1 git@github.com:CuBoulder/express.git express-${EXPRESS_TAG}

# Download DSLM if it doesn't already exist on host machine.
drush dl dslm-7.x -y

# Append DSLM config to drushrc.php
echo "Checking DSLM config..."
echo
drush dslm
echo
echo "If you don't see DSLM path info, add it to ~/.drush/drushrc.php"
echo

echo "Parking /web path via Valet..."
cd ${ROOT}/web
valet park
echo
echo "You should now be able to create a site using './create-site.sh -p express' and have it served at http://express.test/"

END=`date +%s`

RUNTIME=$((END-START))
echo "Project setup took ${RUNTIME} seconds."
