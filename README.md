# express-starter
Scripts for setting up a local Express dev environment using Laravel Valet.

## Valet Installation
Laravel thankfully has great documentation for installation located at: https://laravel.com/docs/5.6/valet. You will need Homebrew before you run `valet install`, but that command should check for and install PHP, NGINX, and DNSmasq if those aren't installed on your machine.

The Travis build for this project shows steps you can manually take to install needed dependencies: https://github.com/CuBoulder/express-starter/blob/valet/.travis.yml#L10. If you have any issues installing Valet, please refer to the [troubleshooting section](https://github.com/CuBoulder/express-starter#troubleshooting) of this readme.

## Express Setup
Once Valet is installed and you have confirmed `.test` domains are working properly, it is time to set up a site and codebase. To properly install sites via Drush and have the `local_hosting` module installed automatically, you must alter the `~/.drush/drushrc.php` file. There are environmental variables that can be targeted through PHP-FPM and NGINX requests, but the PHP CLI environment Drush uses does not have any of those variables.

```bash
# Edit the drushrc file. You can use nano or "open -e" instead of Vim.
vim ~/.drush/drushrc.php

# Add $_SERVER['VALET_ENV'] = 'yes'; to file.
# An example drushrc.php file is located in the /config folder of this repo.
```

Now you can clone down this repository and build out the codebase.

```bash
# Clone down this repo on the "valet" branch. 
git clone --branch valet git@github.com:CuBoulder/express-starter.git exs
cd exs

# The setup script will copy down Express code, add DSLM, add MySQL and PHP settings, and "park" the /web directory.
./setup.sh

# Create a site with a "-p" path option. The site will be live at "path.test" when installation finishes.
# For this example, a site is created at "http://express.test/".
./create-site.sh -p express
```

The Valet Drupal driver currently has an issue with autocomplete requests. The URI is set in `$_GET['q']` but is overwritten always as `/index.php` losing where the autocomplete path was initially heading. To mitigate this issue until a PR is merged in, you should add https://github.com/laravel/valet/pull/456/files to the `DrupalValetDriver.php`. Afterwards, make sure the correct driver is serving your site by going into the site directory and typing `valet which`.

### Services Configuration

The configuration for nginx, PHP, and MySQL can be changed, but we don't do this on install since restarting the services has been spotty. Changing the default configuration isn't neccessary to have a fast running site, but you may want to experiment with values if you think parts of the application are running slow.

The configuration files are located in the `/config` folder. You need to restart MySQL and PHP when making changes. Look in the readme for more information: https://github.com/CuBoulder/express-starter/blob/valet/config/README.md

### Valet Share

You can go into a directory of a site and use `valet share` to get a publicly accessible URL for your local site. However, since the request is passed through a proxy, Drupal will report that your local site's URL, e.g. "express.test", is the `$base_url`. Any asset with an absolute path does not get loaded then on the shared URL version of the site. The "ngrok.io" service used to share the site adds additional HTTP headers that can be targeted to change the base URL when requests are passed through the proxy.

You need to add the following to your settings.php file.

```php
if (isset($_SERVER['HTTP_X_FORWARDED_HOST'])) {
  $base_url = $_SERVER['HTTP_X_FORWARDED_PROTO']. '://'. $_SERVER['HTTP_X_FORWARDED_HOST'];
}
```

Then you can use `valet share` and see your site at a URL like, `https://0b39de83.ngrok.io/`.

## Troubleshooting

### MySQL User

This install assumes that mysql is configured using root with no password.  If you've configured mysql using a password, brew will not reset that.  Use `mysqladmin -u root -p'root' password ''` or edit https://github.com/CuBoulder/express-starter/blob/valet/create-site.sh#L77 to add your user and password, e.g. `drush si express --db-url=mysql://my-user:my-pass@localhost:3306/${SITE} -y`.

### Bundle Clone Hangs

When `./setup.sh` asks "Do you want to clone down all bundles from prod? (y/n)" you must be able to connect to Atlas to lookup the git urls and hashes of the current code objects. You must be on a wired connection or connected to the UCOMM VPN when running this. 

### git checkout feature/123 says nothing is found

Because cloning a repository with all branches takes much longer, all cores, profiles and packages are cloned with a depth of 1 by default. As a result, `git fetch --all` will return nothing. To change a specific project to include all branches, run `git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"` before `git fetch --all`.  

### Apache Listening On Port 80

Be sure Apache/httpd (from Apple or Homebrew) is no longer the default listener for port 80.  

```bash
# Find out if any service listens on port 80.
# You should only see "nginx" and not "httpd".
sudo lsof -n -i :80 | grep LISTEN
```

The drush commands can run the Drupal install for Valet using the command line PHP properly, but an "It Works!" response for http://express.test can actually be coming from Apache and not Nginx. Use the following to kill all httpd processes and prevent it from restarting.

```bash
sudo killall httpd
sudo launchctl unload /System/Library/LaunchDaemons/org.apache.httpd.plist
```

### Homebrew PHP Versions

[DomainException] Unable to determine linked PHP is documented in https://github.com/laravel/valet/issues/470.  It may not be possible to resolve this error using the `brew install php72` recommended in https://laravel.com/docs/5.6/valet.  Using `brew install php71` works and is what we are using with Apache in production.

### AJAX Autocomplete Lookups Fail

Apply https://www.drupal.org/files/issues/autocomplete-security-optional-2749007-9.patch to core. This will eventually be included in our version of Drupal core
run ` drush vset autocomplete_security_enforce_no_clean_url FALSE`
