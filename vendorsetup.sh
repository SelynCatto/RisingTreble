#!/bin/bash
TOP=$(pwd)
PATCHES=$TOP/device/phh/treble/patches
RESET=true

function patch() {
    cd $TOP/$2

    if $RESET; then 
        git am --abort
        git reset --hard FETCH_HEAD
    fi

    #git config --local user.name "generic"
    #git config --local user.email "generic@email.com"
    git am $FOLDER/*
    if [ $? -ne 0 ]; then
         echo "!!! WARNING: Patching failed."
    fi
    #git config --local --unset user.name
    #git config --local --unset user.email
}

function apply() {
    for FOLDER in $PATCHES/$1/*; do
        PATCHDIR=$(basename "$FOLDER") # Remove additional path from DIR name

        SOURCEPATH=${PATCHDIR/platform_/} # Remove platform_ from dir name
        SOURCEPATH=${SOURCEPATH//_//} # replace _ with / to make a path to directory to patch

	if [ $SOURCEPATH == "build" ]; then SOURCEPATH="build/make"; fi # Replace build with build/make
        if [ $SOURCEPATH == "treble/app" ]; then SOURCEPATH="treble_app"; fi

        patch $FOLDER $SOURCEPATH
    done

    cd $TOP
    RESET=false
}

rm -rf vendor/hardware_overlay
git clone https://github.com/trebledroid/vendor_hardware_overlay vendor/hardware_overlay -b pie --depth 1

rm -rf vendor/vndk-tests
git clone https://github.com/phhusson/vendor_vndk-tests vendor/vndk-tests -b master --depth 1

rm -rf vendor/interfaces
git clone https://github.com/trebledroid/vendor_interfaces vendor/interfaces -b android-14.0 --depth 1

rm -rf vendor/lptools
git clone https://github.com/phhusson/vendor_lptools vendor/lptools -b master --depth 1

rm -rf packages/apps/QcRilAm
git clone https://github.com/AndyCGYan/android_packages_apps_QcRilAm packages/apps/QcRilAm -b master --depth 1

echo "Getting keys, if this sync fails you need to change the script to call a valid keys repo with your own signing keys."
rm -rf vendor/rising/keys
git clone https://github.com/ItsLynix/RisingKeys vendor/rising/keys -b master --depth 1

rm -rf treble_app
git clone https://github.com/TrebleDroid/treble_app treble_app -b master --depth=1

rm -rf prebuilts/vndk/v28
git clone https://android.googlesource.com/platform/prebuilts/vndk/v28 ./prebuilts/vndk/v28
cd prebuilts/vndk/v28
git reset --hard 204f1bad00aaf480ba33233f7b8c2ddaa03155dd
cd ../../..

apply "TrebleDroid"
apply "UniversalX"
cd vendor/lineage
git am --abort
git reset --hard 21d91cce4404e54fcf55184c50c33ae441d9cd58
cd ../../
apply "naz664"


# Build treble app after applying patch
cd treble_app
bash build.sh release
cp -v TrebleApp.apk ../vendor/hardware_overlay/TrebleApp/app.apk
cd ..
