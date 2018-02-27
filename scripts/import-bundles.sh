#!/usr/bin/env bash

start=`date +%s`

while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "Cloning down: $line"
    git clone ${line}
done < "$1"

end=`date +%s`

runtime=$((end-start))
echo Cloning took ${runtime} seconds.
