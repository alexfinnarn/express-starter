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

# The app is called "Express" in the .lando.yml file. If you have more that one project, then you will need to change the name of the project. 
nano .lando.yml

# Replace "name: express" with whatever you want the app called. Ends up creating "https://express.lndo.site:444" with the "express" project name. 

# Exit nano saving file.

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

## Troubleshooting

- You can always try `lando rebuild` from your project directory if things are not working.
- Make sure Docker for Mac is running when you start Lando
- Check through issues at [https://github.com/lando/lando/issues](https://github.com/lando/lando/issues) and file an issue if you don't see a related one. As always, provide as much information as possible in your issue.
- Open an issue in this repo if the problem is a build step or Drupal/Express install problem. For Express bugs or issues, please file those ate [https://github.com/CuBoulder/express/issues](https://github.com/CuBoulder/express/issues)
