#!/bin/bash

TEMPLATE_IN=$1
TEMPLATE_OUT=`echo $1 | sed -e 's/\.png/-trimmed\.png/'`
IMG_PROFILE="template-image-profile.icc"

echo "Trimming header [${TEMPLATE_IN}] tp 650px tall, writing output to [${TEMPLATE_OUT}]..."
convert "${TEMPLATE_IN}" -crop 4250x650+0+0 "${TEMPLATE_OUT}"

# The IMG_PROFILE seems sometimes needed, sometimes not; haven't figured out the pattern yet, leaving this here for now until it's solved
# convert "${TEMPLATE_IN}" -profile "${IMG_PROFILE}" -crop 4250x650+0+0 "${TEMPLATE_OUT}"

echo "Header trimming complete!"
