#!/bin/sh

# copy Project Templates

project_templates_folder="#{$HOME}/Library/'Application Support'/Developer/Shared/Xcode/'Project Templates'"

if [ -e "${project_templates_folder}" ]
then
  echo 
else
  mkdir -p $project_templates_folder
fi

if [ -e "${project_templates_folder}/ObjectiveMatchy" ]
then
  rm -rf "${project_templates_folder}/ObjectiveMatchy"
fi

cd Templates/Project && echo $project_templates_folder #cp -R ObjectiveMatchy $project_templates_folder && cd ..

# copy Target Templates