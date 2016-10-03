#!/bin/bash

# Give downloaded and unzipped CSV file as argument
source=$1
target='data/uk-data-controllers.csv'

test -f "$source" || echo 'give file as argument' && exit 1

# Make the field names from ICO lowercase
head -n 1 < $source | tr '[:upper:]' '[:lower:]' > $target

# For the actual data, remove all of the newlines. Then add another newline for dos-style newlines.
# This corrects the fact that the HTML supplied by ICO contains newlines.
awk 'NR > 1 { print }' < $source | tr -d '\n' | sed $'s/\r/\\\n/g' >> $target
