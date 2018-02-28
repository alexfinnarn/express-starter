<?php

/**
 * @file
 * Gather bundles from prod and make a file listing.
 */

print 'starting...';
$curl = curl_init();
curl_setopt($curl, CURLOPT_URL, 'https://osr-atlas03.int.colorado.edu/atlas/code');
curl_setopt($curl, CURLOPT_RETURNTRANSFER, TRUE);
$code_items= (array) json_decode(curl_exec($curl));

$code_array = @array_flip(array_map('_get_git_urls', $code_items['_items']));
$code_string = implode("\n", array_keys($code_array));

$handle = fopen('manifest.txt', 'w') or die('Cannot open file: manifest.txt');
$content = file_get_contents('manifest.txt');

// Write the contents back to the file
file_put_contents('manifest.txt', $content .= $code_string);


function _get_git_urls($item) {
  if (strpos($item->git_url, 'git://') === false && strpos($item->git_url, 'https://') === false && strpos($item->git_url, 'express.git') === false && strpos($item->git_url, 'drupal-7.x.git') === false) {
    return $item->git_url;
  }
}
