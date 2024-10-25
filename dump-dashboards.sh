#!/bin/bash

set -eu -o pipefail

FULLURL="$1"
APIKEY="$2"

headers="Authorization: Bearer $APIKEY"
in_path=dashboards_raw
base_path="dashboards"
set -o nounset

echo "Exporting Grafana dashboards from $FULLURL"
mkdir -p $in_path

curl -H "$headers" -s "$FULLURL/api/search?query=&" > tmp.json

for dash in $(curl -H "$headers" -s "$FULLURL/api/search?query=&" | jq -r '.[] | select(.type == "dash-db") | .uid'); do
    curl -H "$headers" -s "$FULLURL/api/search?query=&" 1>/dev/null
    dash_path="$in_path/$dash.json"
    curl -H "$headers" -s "$FULLURL/api/dashboards/uid/$dash" | jq -r . > $dash_path
    jq -r .dashboard $dash_path > $in_path/dashboard.json
    title=$(jq -r .dashboard.title $dash_path | sed "s/\//-/g")
    folder="${base_path}/$(jq -r '.meta.folderTitle' $dash_path | sed "s/\//-/g")"
    mkdir -p "$folder"
    mv -f $in_path/dashboard.json "$folder/${title}.json"
    echo "exported $folder/${title}.json"
done
rm -rf $in_path
rm tmp.json
