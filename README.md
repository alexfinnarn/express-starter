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

# The setup script will copy down code and setup DSLM.
./setup.sh
```



