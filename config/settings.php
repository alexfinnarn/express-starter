<?php

/**
 * @file
 * Additional configuration to add to the Drupal settings file.
 */

$conf['drupal_http_request_fails'] = FALSE;
$path = 'express';
$host = $_SERVER['HTTP_HOST'];

// Never allow updating modules through UI.
$conf['allow_authorize_operations'] = FALSE;

// Caching across all of wwwng.
$conf['cache'] = 1;
$conf['block_cache'] = 1;
$conf['block_cache_bypass_node_grants'] = TRUE;

// Compress cached pages always off; we use mod_deflate
$conf['page_compression'] = 0;

// Min cache lifetime 0, max 5 mins * 60 = 300 seconds.
$conf['cache_lifetime'] = 0;
$conf['page_cache_maximum_age'] = 300;

// Aggregate css and js files.
$conf['preprocess_css'] = TRUE;
$conf['preprocess_js'] = TRUE;

// Drupal doesn't cache if we invoke hooks during bootstrap.
$conf['page_cache_invoke_hooks'] = FALSE;

// Setup cache_form bin.
$conf['cache_class_cache_form'] = 'DrupalDatabaseCache';

// Set memcache as default.
$conf['cache_backends'][] = 'profiles/express/modules/contrib/memcache/memcache.inc';
$conf['cache_default_class'] = 'MemCacheDrupal';

// Memcache bins and stampede protection.
$conf['memcache_bins'] = array('cache' => 'default');

// Set to FALSE on Jan 5, 2012 - drastically improved performance.
$conf['memcache_stampede_protection'] = FALSE;
$conf['memcache_stampede_semaphore'] = 15;
$conf['memcache_stampede_wait_time'] = 5;
$conf['memcache_stampede_wait_limit'] = 3;
$conf['memcache_key_prefix'] = $path;

// Disable poorman cron.
$conf['cron_safe_threshold'] = 0;

// No IP blocking from the UI, we'll take care of that at a higher level.
$conf['blocked_ips'] = array();


$base_url = 'https://express.lndo.site:444/' . $path;

// Need to do this to until we can properly support SSL.
$conf['securepages_enable'] = FALSE;
$conf['ldap_servers_require_ssl_for_credentails'] = '0';

// Tell Drupal about reverse proxy
//$conf['cache_backends'][] = 'profiles/express/modules/contrib/memcache/memcache.inc';
//$conf['reverse_proxy'] = TRUE;
// Drupal will look for IP in $_SERVER['X-Forwarded-For']
//$conf['reverse_proxy_header'] = 'X-Forwarded-For';
// Varnish version
//$conf['varnish_version'] = 3;

// Set varnish as the page cache.
//$conf['cache_class_cache_page'] = 'VarnishCache';

// Define Varnish Server Pool
//$conf['reverse_proxy_addresses'] = array('localhost',);
//$conf['varnish_control_terminal'] = 'localhost:6082';
//$conf['varnish_control_key'] = substr(file_get_contents('/etc/varnish/secret'),0,-1);



