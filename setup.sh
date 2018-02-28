#!/usr/bin/env bash

START=`date +%s`

# Store local project root.
ROOT=$(pwd)
echo Project root is: ${ROOT}

# Add PHP and MySQL config, if desired.
echo "Do you want to copy php.ini and my.cnf settings? (y/n)"
read ADD_CONFIG

if [ "$ADD_CONFIG" =  "y" ]; then
  PHP_DIR="$(php -i | grep 'Scan this dir for additional .ini files ' | tr -d '[:space:]'  | cut -d'>' -f2)"
  echo
  echo "Copying php.ini to ${PHP_DIR}..."
  cp config/php/zzzzzz-express-custom.ini ${PHP_DIR}

  echo "Copying .my.cnf to user directory (~/)..."
  cp config/mysql/.my.cnf ~/
  echo

  echo "Restarting MySQL..."
  mysql.server restart

  echo "Checking MySQL status..."
  mysql.server status
  echo
fi

# Define initial gathering of Drupal and Express.
DRUPAL_TAG=7.57
# The tag is only used here to create the DSLM directory.
EXPRESS_TAG=2.8.5

# Download Drupal.
echo "Cloning and checking out ${DRUPAL_TAG}..."
cd ${ROOT}/code/dslm_base/cores

# Main
#git clone --depth 1 git@github.com:CuBoulder/drupal-7.x.git drupal-${DRUPAL_TAG}
#cd drupal-${DRUPAL_TAG}
#git checkout ${DRUPAL_TAG}-hardened

drush dl drupal-${DRUPAL_TAG}
cd drupal-${DRUPAL_TAG}/modules
rm -rf php aggregator blog book color contact translation dashboard forum locale openid overlay poll rdf search statistics toolbar tracker trigger

# Checkout Express.
echo "Cloning and checking out Express ${EXPRESS_TAG}..."
cd ${ROOT}/code/dslm_base/profiles

# If checking out a tag...
# git clone -b ${EXPRESS_TAG} git@github.com:CuBoulder/express.git express-${EXPRESS_TAG}

# Checking out default of dev branch.
git clone --depth 1 git@github.com:CuBoulder/express.git express-${EXPRESS_TAG}

# Add bundles from prod, if wanted.
echo "Do you want to clone down all bundles from prod? (y/n)"
read ADD_BUNDLES

if [ "$ADD_BUNDLES" =  "y" ]; then
  cd ${ROOT}/code/packages_base/custom
  drush scr gather_bundles.php
  ./import-bundles.sh manifest.txt
fi

# Download DSLM if it doesn't already exist on host machine.
drush dl dslm-7.x

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
