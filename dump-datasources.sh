#!/bin/bash

set -eu -o pipefail

FULLURL="$1"
APIKEY="$2"

headers="Authorization: Bearer $APIKEY"
in_path=dashboards_raw
set -o nounset

echo "Exporting Grafana dashboards from $FULLURL"
mkdir -p $in_path

curl -H "$headers" -s "$FULLURL/api/datasources" > tmp.json

mkdir -p datasources
cat tmp.json |jq -c -M '.[]' | while read -r datasource; do
    name=$(echo "$datasource" | jq -r '.name' | sed 's/[^a-zA-Z0-9]/_/g')
    echo "$datasource" > "datasources/${name}.json"
done

# cleanup
rm tmp.json
