# express-starter
Scripts for setting up a local Express dev environment.

## Pre-installation Steps
The Express dev starter kit uses Lando on Mac OSX to build out the evirnoment needed to run Express. Lando is a great tool to experiment with other development environment setups than Drupal 7. 

Follow the installtion steps listed at: [https://docs.devwithlando.io/installation/system-requirements.html](https://docs.devwithlando.io/installation/system-requirements.html)

The steps go through system requirements as well as installing and updating Lando. You should always assume the latest release of Lando is the one you should be installing. 

## Build Process
The `scripts/` folder contains two Bash shell scripts that place all the files in the right places and then gives you a manual command to run on the Lando appserver once built.

To build your Express site:

```bash
# Clone in this repo. Replace ~/Sites with your directory of choice. 
cd ~/Sites
git clone git@github.com:CuBoulder/express-starter.git my-site
cd my-site

# Make sure the scripts are executable. 
chmod +x ./scripts/build-express.sh

# Run build script. 
./scripts/build-express.sh

# Start Lando. Make sure Docker for Mac is running.
lando start

# SSH into the appserver and install Drupal.
lando ssh
cd web
drush si express --db-url=mysql://drupal7:drupal7@database:3306/drupal7

# Go to your Express site after install.
exit
lando info

# Use a URL you see there. Listed after localhost are URLS that will never change. 
# This will only work if your computer is online, otherwise please follow: 
# https://docs.devwithlando.io/tutorials/offline-dev.html
```
