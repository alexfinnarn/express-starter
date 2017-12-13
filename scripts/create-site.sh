#!/bin/sh

# Store local project root.
ROOT=$(pwd)
echo Project root is: ${ROOT}

# Site path is first argument.
SITE="$1"
echo ${SITE}

# Add Drupal at a path.
cd ${ROOT}/web

drush dslm-new ${SITE}

# Add profile to site.
cd ${SITE}
drush dslm-add-profile

# Add bundles, if needed.
echo Add bundles...
drush dslm-add-custom

# Create database.
echo Creating database...
drush sql-create --db-url=mysql://drupal7:drupal7@database:3308/${SITE} -y

# Install site
echo Installing site...
drush si express --db-url=mysql://drupal7:drupal7@database:3308/${SITE} -y
