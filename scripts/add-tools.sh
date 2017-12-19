#!/usr/bin/env bash

# Download DSLM since drush wasn't available on "lando start".
drush dl dslm-7.x

# Echo in MySQL settings since the config file load doesn't stick.
mysql -u root -h database -e "set @@global.innodb_file_per_table=0;"
mysql -u root -h database -e "set @@global.innodb_flush_log_at_trx_commit=2;"
