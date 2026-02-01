#!/bin/bash

echo "Cache busting..."

# Define the export directory
EXPORT_DIR="docs"

# Generate a timestamp (seconds since epoch)
TIMESTAMP=$(date +%s)

# Go to the export directory
cd "$EXPORT_DIR" || exit

# Remove OLD renamed files from previous exports
# (Godot export doesn't overwrite them if names are different)
rm index-*.*

# Rename the new export files to include the timestamp
for file in index.*
do
    mv "$file" "${file/index/index-$TIMESTAMP}"
done

# Name the index.html file back to just index.html so the URL remains the same
mv index-"${TIMESTAMP}".html index.html

# Replace all instances of the original 'index' filename with the new timestamped name in the index.html
sed -i -- "s/index/index-${TIMESTAMP}/g" index.html

echo "Cache busting complete. Files renamed with timestamp: $TIMESTAMP"
