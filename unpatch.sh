#!/bin/bash
TOP=$(pwd)
PATCHES=$TOP/device/phh/treble/patches
function unpatch() {
    cd $TOP/$2

    git reset --hard FETCH_HEAD
    echo "removing patches from $SOURCEPATH"
}

function getPatch() {
    for FOLDER in $PATCHES/TrebleDroid/*; do
        PATCHDIR=$(basename "$FOLDER") # Remove additional path from DIR name

        SOURCEPATH=${PATCHDIR/platform_/} # Remove platform_ from dir name
        SOURCEPATH=${SOURCEPATH//_//} # replace _ with / to make a path to directory to patch

	if [ $SOURCEPATH == "build" ]; then SOURCEPATH="build/make"; fi # Replace build with build/make
        if [ $SOURCEPATH == "treble/app" ]; then SOURCEPATH="treble_app"; fi

        unpatch $FOLDER $SOURCEPATH
    done

    cd $TOP
}

getPatch
