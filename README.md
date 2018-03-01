# express-starter
Scripts for setting up a local Express dev environment using Laravel Valet.

## Valet Installation
Laravel thankfully has great documentation for installation located at: https://laravel.com/docs/5.6/valet. You will need Homebrew before you run `valet install`, but that command should check for and install PHP, NGINX, and DNSmasq if those aren't installed on your machine.

## Express Setup
Once Valet is installed and you have confirmed `.test` domains are working properly, it is time to set up a site and codebase. 

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
### Services Configuration

The configuration for nginx, PHP, and MySQL can be changed, but we don't do this on install since restarting the services has been spotty. Changing the default configuration isn't neccessary to have a fast running site, but you may want to experiment with values if you think parts of the application are running slow.

The configuration files are located in the `/config` folder. You need to restart MySQL and PHP when making changes.

## Troubleshooting

This install assumes that mysql is configured using root with no password.  If you've configured mysql using a password, brew will not reset that.  Use `mysqladmin -u root -p'root' password ''`

./create-site.sh must be able to connect to Atlas to lookup the git urls and hashes of the current code objects. You must be on a wired connection or connected to the UCOMM VPN when running this. 

Be sure Apache/httpd (from Apple or brew) is no longer the default listener for port 80.  The drush commands can run the Drupal install for Valet using the command line PHP properly, but an "It Works!" response for http://express.test can actually be coming from Apache and not Nginx. Use the following to kill all httpd processes and prevent it from restarting.

```sudo killall httpd
sudo launchctl unload /System/Library/LaunchDaemons/org.apache.httpd.plist
```

[DomainException] Unable to determine linked PHP is documented in https://github.com/laravel/valet/issues/470.  It may not be possible to resolve this error using the `brew install php72` recommended in https://laravel.com/docs/5.6/valet.  Using `brew install php71` works and is what we are using with Apache in production.

