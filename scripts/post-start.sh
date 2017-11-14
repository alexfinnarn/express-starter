#!/usr/bin/env bash

# Install Drupal
lando start
lando ssh
cd web
drush si express --db-url=mysql://drupal7:drupal7@database:3306/drupal7
