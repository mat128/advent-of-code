#!/bin/bash
input=$1
destinations=$(mktemp)
trap "rm -f $destinations" EXIT

cat $input | cut -d' ' -f4- > $destinations
cat $input | cut -d' ' -f1 | xargs -I% /bin/sh -c "grep -q % $destinations || echo %"
