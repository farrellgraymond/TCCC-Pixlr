#!/bin/bash -e

PXZ_FILENAME="$1"
REPO_URL="https://github.com/farrellgraymond/TCCC-Pixlr"
MANIFEST_FILENAME="manifest.json"

echo "=== Updating last modified date for [${PXZ_FILENAME}]..."

echo "------ Verifying [${PXZ_FILENAME}] is a zipfile, script will exit if it is not..."
unzip -t "${PXZ_FILENAME}" > /dev/null 2>&1

LASTMOD_STR=`date -u '+%Y-%m-%dT%H:%M:%SZ'`
echo "------ Last modified date string calculated as: [${LASTMOD_STR}]"

LASTMOD_CONTENT="LAST UPDATED: ${LASTMOD_STR}"

# Create our last-updated text element 
LASTMOD_JSON="{
      \"name\": \"LAST UPDATED\",
      \"type\": \"text\",
      \"rect\": {
        \"x\": 292,
        \"y\": 7053,
        \"w\": 2900,
        \"h\": 92,
        \"r\": 0
      },
      \"opacity\": 1,
      \"locked\": true,
      \"visible\": true,
      \"link\": \"\",
      \"content\": \"${LASTMOD_CONTENT}\",
      \"format\": {
        \"size\": 64,
        \"align\": \"right\",
        \"bold\": true,
        \"italic\": false,
        \"underline\": false,
        \"uppercase\": false,
        \"linespace\": 0,
        \"letterspace\": 0,
        \"font\": {
          \"name\": \"Verdana\",
          \"content\": \"verdana.woff\"
        },
        \"fill\": {
          \"type\": \"color\",
          \"value\": \"#000000\"
        }
      }
    }"

# Create our watermark/translated-by label
PEREKLAD_JSON="{
      \"name\": \"Переклад tccc.org.ua...\",
      \"type\": \"text\",
      \"rect\": {
        \"x\": 4145,
        \"y\": 95,
        \"w\": 750,
        \"h\": 90,
        \"r\": 0
      },
      \"opacity\": 1,
      \"locked\": false,
      \"visible\": true,
      \"link\": \"\",
      \"content\": \"Переклад tccc.org.ua\",
      \"format\": {
        \"size\": 66,
        \"align\": \"left\",
        \"bold\": true,
        \"italic\": false,
        \"underline\": false,
        \"uppercase\": false,
        \"linespace\": 0,
        \"letterspace\": 0,
        \"font\": {
          \"name\": \"Verdana\",
          \"content\": \"verdana.woff\"
        },
        \"fill\": {
          \"type\": \"color\",
          \"value\": \"#777777\"
        }
      }
    }"

echo "------ Extracting old manifest and updating with detected last-modified time..."
# Extract the manifest file we plan to update from the source file, and pump it straight through jq
# to insert or update our last-modified time before echoing it out as a file
unzip -p "${PXZ_FILENAME}" ${MANIFEST_FILENAME} | jq "del(.stack[] | select(.type==\"text\") | select(.content | contains(\"LAST UPDATED:\"))) | del(.stack[] | select(.type==\"text\") | select(.content | contains(\"Переклад tccc.org.ua\"))) | .stack += [${PEREKLAD_JSON}] | .stack += [${LASTMOD_JSON}]" > ${MANIFEST_FILENAME}

# Well this is strange - why do we do this? Why explicitly set the time on the manifest
# to a fixed time?
# 
# This is done so that if the contents of the manifest don't actually change, then the
# generated zipfile will not change either since the metadata associated with the
# manifest remains identical. This ensures that running this command produces a "stable"
# zipfile that only shows diffs to git if something *actually* changed - without this line,
# we would always see diffs in all zipfiles because the manifest timestamp always changes
touch -t 202308232323.23 ${MANIFEST_FILENAME}

echo "------ Adding updated manifest to [${PXZ_FILENAME}]..."
# Now that we have our updated manifest, push it back into the zipfile - we have to do it this way,
# since the zip command requires the filename to be present in order to update it (no stdin tricks)
zip "${PXZ_FILENAME}" ${MANIFEST_FILENAME}
rm ${MANIFEST_FILENAME}

echo "=== Last-modified [${LASTMOD_STR}] update for [${PXZ_FILENAME}] complete!"
