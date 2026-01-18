#!/bin/bash
echo "Cache busting"

# Go to the folder where the project is exported to
cd docs || exit

# Get the current timestamp
timestamp=$(date +"%Y%m%d%H%M%S")

# Loop through each file in the current directory
for file in *; do
  if [ -f "$file" ] && [[ "$file" != index.html ]]; then
    filename="${file%.*}"
    extension="${file##*.}"
    mv "$file" "${filename}_${timestamp}.${extension}"
    #Replace instances of file name in html
    sed -i -- "s/${filename}.${extension}/${filename}_${timestamp}.${extension}/g" index.html
  fi
done

sed -i -- "s/mainPack: null/mainPack: 'index_${timestamp}.pck'/g" index_$timestamp.js
sed -i -- "s/executable: ''/executable: 'index_${timestamp}'/g" index_$timestamp.js

sed -i -- "s/const exe = this.config.executable;/const exe = 'index_${timestamp}';/g" index_$timestamp.js