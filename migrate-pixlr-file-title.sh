#!/bin/bash -e

# This script can be used to bulk-update a set of skill cards using an invocation like the one below:
# find Pixlr\ Source\ Files -name 'TCCC CPP *' -print0 | xargs -0 -n 1 ./migrate-pixlr-file-title.sh

PXZ_FILENAME="$1"
MANIFEST_FILENAME="manifest.json"
OLD_MANIFEST_FILENAME="${MANIFEST_FILENAME}.old"

echo "=== Updating display name for [${PXZ_FILENAME}]..."

echo "------ Verifying [${PXZ_FILENAME}] is a zipfile, script will exit if it is not..."
unzip -t "${PXZ_FILENAME}" > /dev/null 2>&1

echo "------ Extracting old manifest and updating display name to include \"UKR\"..."

# Extract the manifest file we plan to update from the source file
unzip -p "${PXZ_FILENAME}" ${MANIFEST_FILENAME} > ${OLD_MANIFEST_FILENAME}

CURRENT_NAME=`cat ${OLD_MANIFEST_FILENAME} | jq ".name"`

echo "Current name: ${CURRENT_NAME}"

if [[ $CURRENT_NAME =~ "UKR" ]]; then
  echo "Name already contains \"UKR\"! Exiting..."
  rm ${OLD_MANIFEST_FILENAME}
  exit 1
fi

# This regex will insert the string 'UKR' into strings formatted like this:
#
# 7 Two-Handed Windlass Tourniquet (TFC)
# 52 Pt1 Rigid Splint Instruction
# 
# Turning them into:
#
# 7 UKR Two-Handed Windlass Tourniquet (TFC)
# 52 Pt1 UKR Rigid Splint Instruction
# jq '(.name |= gsub("^(?<a>\\d+ (Pt\\d )?)(?<b>.*)$"; "\(.a)UKR \(.b)"))'
cat ${OLD_MANIFEST_FILENAME} | jq '(.name |= gsub("^(?<a>\\d+ (Pt\\d )?)(?<b>.*)$"; "\(.a)UKR \(.b)"))' > ${MANIFEST_FILENAME}

echo "Updated name: `cat ${MANIFEST_FILENAME} | jq \".name\"`"

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
rm ${OLD_MANIFEST_FILENAME} ${MANIFEST_FILENAME}

echo "=== Display name update for [${PXZ_FILENAME}] complete!"