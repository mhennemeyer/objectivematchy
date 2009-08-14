#!/bin/sh

# read version number passed to script

version=$1

# create release folder

release_folder="ObjectiveMatchy-${version}"

if [ -e $release_folder ]
then
  printf "%b" "Release Folder ${release_folder} already exists"
  exit 1
else
  mkdir "ObjectiveMatchy-${version}"
fi

# build lib and framework

#cd ObjectiveMatchyIphone && xcodebuild -target ObjectiveMatchyIphone clean  build && xcodebuild -target ObjectiveMatchyIphoneStatic clean build && cd ..

# copy lib and framework

cd $release_folder && cp -R ../ObjectiveMatchyIphone/build/Release/ObjectiveMatchyIphone.framework . && cp ../ObjectiveMatchyIphone/build/Release-iphoneos/libObjectiveMatchyIphone.a . && cd ..

# copy OMFeatures

cd $release_folder && cp -R ../OMFeatures . && cd ..

# copy Templates

cd $release_folder && cp -R ../Templates . && cd ..

# copy install_templates.sh

cd $release_folder && cp  ../install_templates.sh . && cd ..

# update Templates

# zip

/usr/bin/zip -r "${release_folder}.zip" $release_folder