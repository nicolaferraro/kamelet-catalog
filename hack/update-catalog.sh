#!/bin/sh

location=$(dirname $0)
rootdir=$location/../


cd $rootdir

echo "{\"kind\": \"List\", \"apiVersion\": \"v1\", \"items\": [" > dist/catalog.tmp

first=true
for f in `ls *.kamelet.yaml | sort -V`; do
    if [ "$first" = false ]; then
        echo "," >> dist/catalog.tmp
    fi
    cat $f | yq . >> dist/catalog.tmp
    first=false
done

echo "]}" >> dist/catalog.tmp

# format and finalize
cat dist/catalog.tmp | jq > dist/catalog.json
rm dist/catalog.tmp
