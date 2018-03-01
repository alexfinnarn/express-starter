## Optimizing Performance

This topic could go on forever with all of the options you can change across MySQL, PHP, and NGINX configuration. A lot of the times, if you don't know what you're doing, it's best to use defaults; however, there are a key few options that will give you a good performance boost. Since we are all using beefy MacBook Pros, hardware limitations aren't too much of a concern.

### PHP

Several php.ini settings were cobbled together from various sources. Some of the options below are commented out to let you know they exist, and you might not want to enable or change them. You can look to the internets for other advice, and please update the ini settings below with what you find out.

Example "zzzzzz-express-custom.ini" file:

```ini
[Date]
date.timezone = "America/Denver"

; Globals
expose_php= off
max_execution_time = 30
max_input_time = 60
max_input_vars = 1000
memory_limit = 512M
upload_max_filesize = 256M
post_max_size = 256M
error_reporting = E_ALL & ~E_DEPRECATED
ignore_repeated_errors = off
html_errors = off
display_errors = off
display_startup_errors = on
log_errors = on

[Opcache]

opcache.revalidate_freq=0
;opcache.validate_timestamps=0
opcache.max_accelerated_files=20000
opcache.memory_consumption=512
opcache.interned_strings_buffer=16
;opcache.fast_shutdown=1
```

To actually make the new settings take effect, you need to first copy the file to the correct location and restart Valet.

```bash
# Grab the active directory where PHP is scanning for additional ini files.
PHP_DIR="$(php -i | grep 'Scan this dir for additional .ini files ' | tr -d '[:space:]'  | cut -d'>' -f2)"

# Prefix your ini file with z's so it gets loaded last.
cp config/php/zzzzzz-express-custom.ini ${PHP_DIR}

# Restart Valet.
valet restart
```

To verify that your settings changes took effect, you can go to a Drupal site at "/admin/reports/status/php" and look for one of the settings listed above. For example, if you changed `memory_limit = 512M` to `memory_limit = 1G`, you can search to hopefully see that it now says `1G`.

You should also see a "Additional .ini files parsed" part of the table and your ini file, "zzzzzz-express-custom.ini" should end up at the end of the list of files.

### MySQL

The MySQL configuration is trickier to figure out since MySQL can connect to many different driver implementations in various languages outside of PHP. You will see a lot of commented out lines that were tried without knowing if it did anything. Shrug.

```ini
[mysqld]
#max_connections=150
#max_user_connections=150

key_buffer_size=64M
#myisam_sort_buffer_size=64M
#table_cache=1024
#max_allowed_packet=8M
#query_cache_limit=2M
#tmp_table_size=32M

innodb_buffer_pool_size=256M
innodb_log_buffer_size=8MB
innodb_thread_concurrency=0

innodb_file_per_table=0
innodb_flush_log_at_trx_commit=2

# Remove leading # to set options mainly useful for reporting servers.
# The server defaults are faster for transactions and fast SELECTs.
# Adjust sizes as needed, experiment to find the optimal values.
# https://haydenjames.io/my-cnf-tuning-avoid-this-common-pitfall/
#join_buffer_size = 128M
#sort_buffer_size = 2M
#read_rnd_buffer_size = 2M

# https://haydenjames.io/mysql-query-cache-size-performance/
query_cache_type = 1
query_cache_limit = 256K
query_cache_min_res_unit = 2k
query_cache_size = 80M
```

To have the MySQL changes take effect, you have to restart the MySQL service separately. 

```bash
# Via Homebrew as reccomended.
brew services restart mysql

# See status.
brew services list

# Via mysql.server, if installed.
mysql.server restart

# See status.
mysql.server status
```

### NGINX

Who knows? TBD...
