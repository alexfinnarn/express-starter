#!/bin/sh

# Store local project root.
ROOT=$(pwd)
echo Project root is: ${ROOT}

# Site path is first argument.
SITE="$1"
echo Path is: ${SITE}

# Add Drupal at a path.
cd ${ROOT}/web

echo Adding Drupal core at /${SITE}...
drush dslm-new ${SITE}

# Add profile to site.
echo Adding profile to site...
cd ${SITE}
drush dslm-add-profile

# Add bundles, if needed.
echo "Add bundles to site? Y/n  "
while read options; do
  case "$options" in
    Y) echo "Which bundles? '0' to cancel  ";
      read bundles
        case ${bundles} in
            0) echo "Exiting..."; break ;;
            *) echo "Adding bundles"; drush dslm-add-custom ${bundles};;
        esac
    break;;
    n) echo "Skipping bundles..."; break ;;
    *) echo "Please enter Y/n" ;;
  esac
done

# Install site
start=`date +%s`
echo Installing site...eat a sandwich, have a danish.
drush si express --db-url=mysql://root:@database:3306/${SITE} -y
end=`date +%s`

runtime=$((end-start))
echo Site installation took ${runtime} seconds.

# Disable parts of site not available on this setup.
echo Disabling Memcache and Varnish...
drush dis memcache varnish -y

# Add to settings file.


