#!/bin/bash -e

# This script can be used to bulk-update a set of skill cards using an invocation like the one below:
# find Pixlr\ Source\ Files -name 'TCCC CPP *' -print0 | xargs -0 -n 1 ./remove-red-outlines.sh

PXZ_FILENAME="$1"
MANIFEST_FILENAME="manifest.json"

echo "=== Removing red outlines from [${PXZ_FILENAME}]..."

echo "------ Verifying [${PXZ_FILENAME}] is a zipfile, script will exit if it is not..."
unzip -t "${PXZ_FILENAME}" > /dev/null 2>&1

echo "------ Extracting old manifest and removing red outlines..."

# This regex will remove all of the outlines from red "bold" card notes since a readability
# test indicates that the text is plenty readable with the red by itself and the outlines
# actually make it a bit harder to read compared to non-outlined
#
# jq 'del (.stack[] | select(.type=="text") | select(.style.outline.color=="#f00505") | .style.outline)'
unzip -p "${PXZ_FILENAME}" ${MANIFEST_FILENAME} | jq 'del (.stack[] | select(.type=="text") | select(.style.outline.color=="#f00505") | .style.outline)' > ${MANIFEST_FILENAME}

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

echo "=== Display name update for [${PXZ_FILENAME}] complete!"