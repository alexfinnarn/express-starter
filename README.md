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

### Troubleshooting

This install assumes that mysql is configured using root with no password.  If you've configured mysql using a password, brew will not reset that.  Use `mysqladmin -u root -p'root' password ''`

./create-site.sh must be able to connect to Atlas to lookup the git urls and hashes of the current code objects. You must be on a wired connection or connected to the UCOMM VPN when running this. 
