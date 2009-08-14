#!/usr/bin/env ruby

# read version number

m, mm, mmm = 0,0,0
version = ""
File.open("version", File::RDWR) do |f|
  numbers = f.readlines.join("").split(".")
  raise "version file corrupt" if numbers.length != 3
  m, mm, mmm = numbers
  version = [m,mm,(mmm.to_i + 1).to_s].join(".")
  f.pos = 0
  f.write version
end

# create release folder

release_folder = "ObjectiveMatchy-#{version}"

if File.exist?(release_folder)
  raise "Release Folder #{release_folder} already exists"
else
  `mkdir ObjectiveMatchy-#{version}`
end

# build lib and framework

#`cd ObjectiveMatchyIphone && xcodebuild -target ObjectiveMatchyIphone clean  build && xcodebuild -target ObjectiveMatchyIphoneStatic clean build && cd ..`

# copy lib and framework

`cd #{release_folder} && cp -R ../ObjectiveMatchyIphone/build/Release/ObjectiveMatchyIphone.framework . && cp ../ObjectiveMatchyIphone/build/Release-iphoneos/libObjectiveMatchyIphone.a . && cd ..`

# copy OMFeatures

`cd #{release_folder} && cp -R ../OMFeatures . && cd ..`

# copy Templates

`cd #{release_folder} && cp -R ../Templates . && cd ..`

# copy install_templates.sh

`cd #{release_folder} && cp  ../install_templates.sh . && cd ..`

# update Templates

# for each folder $dir in Templates/Project/Application and Templates/Project/Library
#   copy framework and lib to $dir
# app_templates="${release_folder}/Templates/Project/ObjectiveMatchy/Application"
# 
# cd $app_templates
# for f in (find . \( ! -name .  -prune \) -type d)
# do
#   echo $f
# done
# 
# 
# # zip
# 
# #/usr/bin/zip -r "${release_folder}.zip" $release_folder