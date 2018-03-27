#!/bin/bash

BASE_DIR="/home/grimreapersam/Projects/inkstone"
APK_DIR="$BASE_DIR/.build/android/project/build/outputs/apk"
ZIPALIGN="/home/grimreapersam/Android/Sdk/build-tools/27.0.1/zipalign"


cd $BASE_DIR
rm -r .build
meteor remove-platform android
meteor add-platform android

meteor build .build --server localhost:3785
cp -R cordova-build-override/* .build/android/project/assets/.
pushd .build/android/project/cordova
./build --release
popd

cd $APK_DIR
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 project-armv7-release-unsigned.apk inkstone
$ZIPALIGN -f 4 project-armv7-release-unsigned.apk project-armv7-release.apk

cp project-armv7-release.apk $BASE_DIR

