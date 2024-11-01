#!/bin/bash

# This script can be applied to all images in a given subdirectory by using an invocation like this:
# find . -name '*PNG Template.png' -print0 | xargs -0 -n 1 ./apply-cpp-template-headers.sh

TEMPLATE_IN=`realpath "$1"`

# Pass the correct args to our worker script which handles all headers generically
pushd header-resources
./do-template-header-apply.sh ASM "${TEMPLATE_IN}"
popd

