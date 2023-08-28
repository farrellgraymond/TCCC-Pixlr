#!/bin/bash -e

# First, extract the manifest.json from every Pixlr file in the repository, to ease tracking of contents changes in each card
MANIFEST_DIR="translation-manifests"
PIXLR_FILES_DIR="Pixlr Source Files"
XARGS_SH_CMD="unzip -p '{}' manifest.json | jq . | tee '../${MANIFEST_DIR}/{}.manifest.json'"

echo "=== Ensuring directory [${MANIFEST_DIR}] is deleted and recreated..."
rm -rf ${MANIFEST_DIR}
mkdir -p ${MANIFEST_DIR}

echo "=== Phase 1: Extracting all Pixlr file manifests in [${PIXLR_FILES_DIR}]..."
pushd "${PIXLR_FILES_DIR}" >/dev/null

# Now, extract the translation text from the manifests, including the text colour
for filename in *.pxz; do
    echo "------ Extracting manifest from [$filename]...";
    unzip -p "$filename" manifest.json | jq . > "../${MANIFEST_DIR}/${filename}.manifest.json"
done
popd >/dev/null

echo "=== Phase 1 Manifest extraction complete! Extracted manifests can be found in [${MANIFEST_DIR}/*.manifest.json]"

echo "=== Phase 2: Extracting all translation strings from manifests..."

# Now, extract the translation text from the manifests, including the text colour
for filename in ${MANIFEST_DIR}/*.manifest.json; do
    echo "------ Extracting strings from [$filename]...";
    cat "$filename" | jq -r '.stack[] | select(.type=="text")| select(.visible==true) | select(.opacity>0) | {content, fillValue: .format.fill.value}' | jq -s '.' > "$filename.translation-strings.json";
done

echo "=== Phase 2 Translation string extraction complete! Extracted translation strings can be found in [${MANIFEST_DIR}/*.manifest.json.translation-strings.json]"