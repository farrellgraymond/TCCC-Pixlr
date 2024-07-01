#!/bin/bash

TEMPLATE_IN=$1
TEMPLATE_OUT=`echo $1 | sed -e 's/PNG Template\.png/Template\.png/'`

HEADER_LEFT="TCCC CPP upper left logo.png"
HEADER_RIGHT="TCCC CPP upper right text.png"
IMG_PROFILE="template-image-profile.icc"

echo "Applying TCCC CPP headers to [${TEMPLATE_IN}], writing output to [${TEMPLATE_OUT}]..."
convert -size 4250x5500 -profile "${IMG_PROFILE}" xc:transparent -page +0+0 "${TEMPLATE_IN}" -page +0+0 "${HEADER_LEFT}" -page +2750+0 "${HEADER_RIGHT}" -layers flatten "${TEMPLATE_OUT}"

# Upon further consideration, there doesn't seem to be a good reason for the Template PDF - the PNG is inserted into Pixlr files, the PDF is not used at present
#PDF_OUT=`echo $1 | sed -e 's/PNG Template\.png/Template\.pdf/'`
#echo "Generating PDF of [${TEMPLATE_OUT}] at [${PDF_OUT}]..."
#magick "${TEMPLATE_OUT}" "${PDF_OUT}"

echo "Header application complete!"
