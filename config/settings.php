<?php

/**
 * @file
 * Additional configuration to add to the Drupal settings file.
 */

// Never allow updating modules through UI.
$conf['allow_authorize_operations'] = FALSE;

// Caching across all of wwwng.
$conf['cache'] = 1;
$conf['block_cache'] = 1;
// $conf['block_cache_bypass_node_grants'] = TRUE;

// Compress cached pages always off; we use mod_deflate
$conf['page_compression'] = 0;

// Aggregate css and js files.
$conf['preprocess_css'] = TRUE;
$conf['preprocess_js'] = TRUE;

// Drupal doesn't cache if we invoke hooks during bootstrap.
$conf['page_cache_invoke_hooks'] = FALSE;
