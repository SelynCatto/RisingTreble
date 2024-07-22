#!/bin/bash
TOP=$(pwd)
PATCHES=$TOP/device/phh/treble/patches
function patch() {
    cd $TOP/$2

    git format-patch FETCH_HEAD
    echo "moving patches to $FOLDER/"
    rm -rf $FOLDER/*.patch
    mv *.patch $FOLDER/
}

function getPatch() {
    for FOLDER in $PATCHES/TrebleDroid/*; do
        PATCHDIR=$(basename "$FOLDER") # Remove additional path from DIR name

        SOURCEPATH=${PATCHDIR/platform_/} # Remove platform_ from dir name
        SOURCEPATH=${SOURCEPATH//_//} # replace _ with / to make a path to directory to patch

	if [ $SOURCEPATH == "build" ]; then SOURCEPATH="build/make"; fi # Replace build with build/make
        if [ $SOURCEPATH == "treble/app" ]; then SOURCEPATH="treble_app"; fi

        patch $FOLDER $SOURCEPATH
    done

    cd $TOP
}

getPatch
