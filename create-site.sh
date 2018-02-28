#!/bin/sh

# Store local project root.
ROOT=$(pwd)
echo Project root is: ${ROOT}

# Gather options. Currently only hard linking...
LINKS="symbolic"
while getopts ":hp:" opt; do
  case $opt in
    h)
      echo "Creating site with hard links" >&2
      LINKS="hard"
      ;;
    p)
      echo "Site path is ${OPTARG}" >&2
      SITE="${OPTARG}"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

# @todo Learn how to throw error in the while loop above.
if [ -z "$SITE" ]; then
  echo "Command needs a path option, e.g. 'lando create-site -p express'"
  exit 1
fi

# Add Drupal at a path.
cd ${ROOT}/web

# Add site in a temp directory if -h is passed.
if [ "$LINKS" =  "hard" ]; then
  echo Adding Drupal core at /${SITE}...
  SITE=${SITE}-temp
  drush dslm-new ${SITE}
else
  echo Adding Drupal core at /${SITE}...
  drush dslm-new ${SITE}
fi

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

# Remove symbolic links, if necessary.
if [ "$LINKS" =  "hard" ]; then
  echo Removing symbolic links...
  TEMP_SITE="${SITE%%-*}"
  cp -LR  ${ROOT}/web/${SITE}  ${ROOT}/web/${TEMP_SITE}
  SITE=${TEMP_SITE}
  cd ${ROOT}/web/${SITE}
fi

# Install site
start=`date +%s`
echo Installing site...eat a sandwich, have a danish.
drush si express --db-url=mysql://root:@localhost:3306/${SITE} -y
end=`date +%s`

runtime=$((end-start))
echo Site installation took ${runtime} seconds.

# Remove temp site links since they can't be removed while copying them above.
if [ "$LINKS" =  "hard" ]; then
  echo "Removing temporary symbolic links..."
  rm -rf ${ROOT}/web/${SITE}-temp
fi

# Disable parts of site not available on this setup.
#echo Disabling Memcache and Varnish...
#drush dis memcache varnish -y

# Add to settings file.


