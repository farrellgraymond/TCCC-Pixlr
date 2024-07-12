#!/bin/bash

HEADER_LEVEL=$1
TEMPLATE_IN=$2
TEMPLATE_OUT=`echo $2 | sed -e 's/\.png/-2\.png/'`

HEADER_LEFT="TCCC ${HEADER_LEVEL} upper left logo.png"
HEADER_RIGHT="TCCC ${HEADER_LEVEL} upper right text.png"
IMG_PROFILE="template-image-profile.icc"

if [ ! -f "$HEADER_LEFT" ]; then
    echo "Header image ${HEADER_LEFT} not found! Exiting...";
    exit 3;
fi

if [ ! -f "$HEADER_RIGHT" ]; then
    echo "Header image ${HEADER_RIGHT} not found! Exiting...";
    exit 3;
fi

echo "Applying TCCC Level [${HEADER_LEVEL}] headers to [${TEMPLATE_IN}], writing output to [${TEMPLATE_OUT}]..."
convert -size 4250x5500 xc:transparent -page +0+0 "${TEMPLATE_IN}" -page +0+0 "${HEADER_LEFT}" -page +2750+0 "${HEADER_RIGHT}" -layers flatten "${TEMPLATE_OUT}"

# The IMG_PROFILE seems sometimes needed, sometimes not; haven't figured out the pattern yet, leaving this here for now until it's solved
# convert -size 4250x5500 -profile "${IMG_PROFILE}" xc:transparent -page +0+0 "${TEMPLATE_IN}" -page +0+0 "${HEADER_LEFT}" -page +2750+0 "${HEADER_RIGHT}" -layers flatten "${TEMPLATE_OUT}"

# Upon further consideration, there doesn't seem to be a good reason for the Template PDF - the PNG is inserted into Pixlr files, the PDF is not used at present
#PDF_OUT=`echo $1 | sed -e 's/PNG Template\.png/Template\.pdf/'`
#echo "Generating PDF of [${TEMPLATE_OUT}] at [${PDF_OUT}]..."
#magick "${TEMPLATE_OUT}" "${PDF_OUT}"

echo "Header application complete!"
