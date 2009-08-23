#!/bin/sh

# This script will copy the ObjectiveMatchy Project- and Target-Templates for Xcode
# to your User Templates Folder at: '~/Library/Application Support/Developer/Shared/Xcode/'

# copy Project Templates

project_templates_folder="${HOME}/Library/Application Support/Developer/Shared/Xcode/Project Templates"
echo "$project_templates_folder"

if [ -e "$project_templates_folder" ]
then
  echo 
else
  mkdir "$project_templates_folder"
fi

if [ -e "${project_templates_folder}/ObjectiveMatchy" ]
then
  rm -rf "${project_templates_folder}/ObjectiveMatchy"
fi

cd Templates/Project && cp -R ObjectiveMatchy "$project_templates_folder" && cd ../..

# copy Target Templates

target_templates_folder="${HOME}/Library/Application Support/Developer/Shared/Xcode/Target Templates"
echo "$target_templates_folder"

if [ -e "$target_templates_folder" ]
then
  echo 
else
  mkdir "$target_templates_folder"
fi

if [ -e "${target_templates_folder}/ObjectiveMatchy" ]
then
  rm -rf "${target_templates_folder}/ObjectiveMatchy"
fi

cd Templates/Target && cp -R ObjectiveMatchy "$target_templates_folder" && cd ../..