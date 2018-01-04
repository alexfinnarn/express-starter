# express-starter
Scripts for setting up a local Express dev environment.

## Pre-installation Steps
The Express dev starter kit uses Lando on Mac OSX to build out the evirnoment needed to run Express. Lando is a great tool to experiment with other development environment setups than Drupal 7. 

Follow the installation steps listed at: [https://docs.devwithlando.io/installation/system-requirements.html](https://docs.devwithlando.io/installation/system-requirements.html)

The steps go through system requirements as well as installing and updating Lando. You should always assume the latest release of Lando is the one you should be installing. Look in the issues of this repo or the "Troubleshooting" section for issues with Lando releases. 

## Build Process

```bash
# Clone in this repo. Replace "my-root" with your directory of choice. 
git clone git@github.com:CuBoulder/express-starter.git my-root
cd my-root
```

### Drupal And Express Setup 

The `scripts/` folder contains a shell script that sets up the initial codebase needed for an Express site: Drupal core and the Express profile. You can change the pinned versions of Drupal and Express initially installed; however, you have to add them in a way that DSLM expects them to show up as mentioned below in "Adding More Cores And Profiles". 

```bash
# Run build script. 
./scripts/build-code.sh
```
### Bundle Code Setup

The Express Starter Kit uses Drupal's DSLM Drush plugin to manage symlinking code into site directories and making managing code on several sites easy. This project mimics a typical DSLM project's code structure. The script you just ran adds the Drupal and Express code to a folder in `code/dslm_base`. Express bundle code is managed in another folder `code/packages_base/custom`. In that directory, a manifest text file has been generated via `scripts/gather_bundles.php` containing all of the Express bundles currently located on the Web Express production servers.

```bash
cd code/packages_base/custom
./import-bundles.sh manifest.txt
```

## Adding More Cores And Profiles

You are now ready to create a site with your core, profile, and bundles of choice. However, you will need to clone in more profiles or cores if you want to setup Express sites using different versions than what is cloned down by default. You can checkout different branches in the default Express profile to quickly switch profile code, and that is what a lot of Express developers end up doing rather than adding several copies of Drupal and Express to their codebase. 

```bash
# Optionally add code to cores and profiles. 
cd code/dslm_base/cores

# Drush dl was used since the 7.x Drupal core Express repo is huge and takes awhile to download.
# You can clone down git@github.com:CuBoulder/drupal-7.x.git instead, but this example shows the hardening process.
#
# DSLM expects cores and profiles to be named a certain way with name + version, e.g. drupal-7.56 or express-2.8.0.
drush dl drupal-7.54
cd modules
rm -rf php aggregator blog book color contact translation dashboard forum locale openid overlay poll rdf search statistics toolbar tracker trigger

cd ../profiles
git clone -b 2.7.0 git@github.com:CuBoulder/express.git express-2.8.0
```

You should now have two choices for cores and profiles when creating sites. 

## Start Lando

The `.lando.yml` file located in the project root contains all of the configuration for setting up the LAMP stack that your Express site will run on. Currently, the DSLM environmental variables are the only things you might be concerned with if DSLM seems wonky. Running `lando drush dslm` should print out the variables you see defined in the Lando config file. 

```bash
# Start Lando. Make sure Docker for Mac is running.
lando start
```
## Create Sites

A command to create sites is located in the config file under tooling. You will need to run a command to add some tools to your site that couldn't be installed when Lando was booting up. 

```bash
cd my-root
lando add-tools
```

You can now run a command including the path you want your site at and an interactive prompt will ask you what code you want to install. Note that SQL has reserved words that cannot be used for a path, e.g. "like", because the path is also the db name.

```bash
cd my-root
lando create-site my-path

# If you are installing a backup of a site, then follow: 
# https://docs.devwithlando.io/tutorials/drupal7.html#importing-your-database 
```

## Go To Your Express Site After Install.

Lando has a command where you can see all of the configuration for your project including the publicly accessible URLs to your site. 

```bash
lando info

# Use a URL you see there. Listed after localhost are URLs that will never change. 
# This will only work if your computer is online, otherwise please follow: 
# https://docs.devwithlando.io/tutorials/offline-dev.html
```

In addition to the appserver URLs, you will see the extenral connection for services like the database container which you can use in a tools like Sequel Pro. 

## Troubleshooting

Lando has a few debugging options, and there are some well known Drupal workarounds. 

```bash
# For all logs...
lando logs

# Service logs, e.g. the appserver.
lando logs -s appserver

# Tail logs...
lando logs -t -f

# Rebuild Lando app.
lando rebuild

# LDAP requires SSL login. If for some reason, you need to login via HTTP...
drush vset ldap_servers_require_ssl_for_credentials 0

# The LDAP login was working, but you can use drush to login if it isn't. 
lando ssh
cd web
lando drush uli your-user-name

# Or for the super user...
lando ssh
cd web
drush uublk 1
drush uli 1

# You may experience issues if another service is listening on ports 80 and 443.
# Find out if any service listens on those ports. 
sudo lsof -n -i :80 | grep LISTEN
sudo lsof -n -i :443 | grep LISTEN

# If any services are listed, you can try killing them or stop them a different way. 
sudo kill -9 $PID
```

More tips:

- You can always try `lando rebuild` from your project directory if things are not working.
- Make sure Docker for Mac is running when you start Lando
- Check through issues at [https://github.com/lando/lando/issues](https://github.com/lando/lando/issues) and file an issue if you don't see a related one. As always, provide as much information as possible in your issue.
- Open an issue in this repo if the problem is a build step or Drupal/Express install problem. For Express bugs or issues, please file those ate [https://github.com/CuBoulder/express/issues](https://github.com/CuBoulder/express/issues)

