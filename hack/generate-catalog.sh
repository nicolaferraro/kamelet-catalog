#!/bin/sh

location=$(dirname $0)
rootdir=$location/../


cd $rootdir

echo "{\"kind\": \"List\", \"apiVersion\": \"v1\", \"items\": [" > catalog.tmp

first=true
for f in `ls *.kamelet.yaml | sort -V`; do
    if [ "$first" = false ]; then
        echo "," >> catalog.tmp
    fi
    cat $f | yq . >> catalog.tmp
    first=false
done

echo "]}" >> catalog.tmp

# format and finalize
cat catalog.tmp | jq > catalog.json
rm catalog.tmp
