#!/bin/bash

echo "Cache busting..."

EXPORT_DIR="docs"

TIMESTAMP=$(date +%s)

cd "$EXPORT_DIR" || exit

rm index-*.*

for file in index.*
do
    mv "$file" "${file/index/index-$TIMESTAMP}"
done

mv index-"${TIMESTAMP}".html index.html

sed -i -- "s/index/index-${TIMESTAMP}/g" index.html

echo "Cache busting complete. Files renamed with timestamp: $TIMESTAMP"
