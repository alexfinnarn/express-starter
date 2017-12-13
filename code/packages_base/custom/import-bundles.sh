#!/usr/bin/env bash

# Store local project root.
ROOT='/Users/alfi2595/Sites/exs'
echo Project root is: ${ROOT}

cd ${ROOT}/code/packages_base/custom

start=`date +%s`

while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "Cloning down: $line"
    git clone ${line}
done < "$1"

end=`date +%s`

runtime=$((end-start))
echo Cloning took ${runtime} seconds.
