#!/usr/bin/env ruby

project_folder = File.expand_path(".")
raise "Project Folder corrupt" unless Dir.entries(project_folder).join(" ") =~ /ObjectiveMatchyIphone/
puts "Project Folder: #{project_folder} <br />"
## read version number

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

puts "Version: #{version} <br />"

## create release folder

release_folder = File.expand_path("ObjectiveMatchy-#{version}")

if File.exist?(release_folder)
  raise "Release Folder #{release_folder} already exists"
else
  `mkdir ObjectiveMatchy-#{version}`
end

puts "Release Folder: #{release_folder} <br />"

## build lib and framework

puts "Start building libraries <br />"

# out = `cd ObjectiveMatchyIphone && touch /tmp/null && xcodebuild -target ObjectiveMatchyIphone clean  build 3> /tmp/null 2> /tmp/null 1> /tmp/null && xcodebuild -target ObjectiveMatchyIphoneStatic clean build 3> /tmp/null 2> /tmp/null 1> /tmp/null && cd ..  `
# 
# raise "There was a Problem with building the libraries. Output: #{out}" unless $?.exitstatus == 0

puts "Finished building libraries <br />"


## copy lib and framework

`cd #{release_folder} &&  cp -R ../ObjectiveMatchyIphone/build/Release/ObjectiveMatchyIphone.framework . && cp ../ObjectiveMatchyIphone/build/Release-iphoneos/libObjectiveMatchyIphone.a . && cd ..`

raise "Framework has not been copied over to Release Folder." unless Dir.entries(release_folder).join(" ") =~ /ObjectiveMatchyIphone\.framework/
raise "Library has not been copied over to Release Folder." unless Dir.entries(release_folder).join(" ") =~ /libObjectiveMatchyIphone\.a/
puts "Framework and lib copied to Release Folder <br />"


## copy OMFeatures

`cd #{release_folder} && cp -R ../OMFeatures . && cd ..`
raise "OMFeatures has not been copied over to Release Folder." unless Dir.entries(release_folder).join(" ") =~ /OMFeatures/
puts "OMFeatures copied to Release Folder. <br />"


## copy Templates

`cd #{release_folder} && cp -R ../Templates . && cd ..`
raise "Templates Folder has not been copied over to Release Folder." unless Dir.entries(release_folder).join(" ") =~ /Templates/
puts "Templates Folder copied to Release Folder. <br />"


## copy install_templates.sh

`cd #{release_folder} && cp  ../install_templates.sh . && cd ..`
raise "Install Script has not been copied over to Release Folder." unless Dir.entries(release_folder).join(" ") =~ /install_templates/
puts "Install Script copied to Release Folder. <br />"


## update Templates

# find all project templates
def project_templates(path)
  all_dirs = `cd #{path} && find . -type d`
  dirs = all_dirs.reject {|f| f =~ /\.\Z/ || f =~ /\.\.\Z/}.map {|f| ((f =~ /\A\.\/(.*)/) && f = $1) || f }.map {|f| path + "/" + f}.select {|f| File.directory?(f)}
  dirs_with_project = dirs.select {|d| Dir.entries(d).join(" ") =~ /\.xcodeproj/}
end

app_templates_folder = "#{release_folder}/Templates/Project/ObjectiveMatchy/Application"
lib_templates_folder = "#{release_folder}/Templates/Project/ObjectiveMatchy/Library"

app_dirs = project_templates(app_templates_folder)
raise "No Application Templates were found" unless app_dirs
puts "Application Templates: <br /> #{app_dirs.join(' <br />')} <br />"

lib_dirs = project_templates(lib_templates_folder)
raise "No Library Templates were found" unless lib_dirs
puts "Library Templates: <br /> #{lib_dirs.join(' <br />')} <br />"

dirs = app_dirs + lib_dirs

dirs.each do |d|
  `cd #{d} && rm -rf libObjectiveMatchyIphone.a && cd #{release_folder} && cp    libObjectiveMatchyIphone.a '#{d}'`
  raise "lib has not been copied over to '#{d}'." unless Dir.entries(d).join(" ") =~ /libObjectiveMatchyIphone\.a/
  
  `cd #{d} && rm -rf ObjectiveMatchyIphone.framework &&  cd #{release_folder} && cp -R ObjectiveMatchyIphone.framework '#{d}'`
  raise "framework has not been copied over to '#{d}'." unless Dir.entries(d).join(" ") =~ /ObjectiveMatchyIphone\.framework/
  
  `cd #{d} && rm -rf SenTestingKit.framework && cd #{project_folder} && cp -R SenTestingKit.framework '#{d}'`
  raise "SenTestingKit has not been copied over to '#{d}'." unless Dir.entries(d).join(" ") =~ /SenTestingKit\.framework/
  
  `cd #{d} && rm -rf OCMock.framework && cd #{project_folder} && cp -R OCMock.framework '#{d}'`
  raise "OCMock has not been copied over to '#{d}'." unless Dir.entries(d).join(" ") =~ /OCMock\.framework/
  
  `cd #{d} && rm -rf OMFeatures && cd #{release_folder} && cp -R OMFeatures '#{d}'`
  raise "OMFeatures has not been copied over to '#{d}'." unless Dir.entries(d).join(" ") =~ /OMFeatures/
end

puts "Updated Templates with new Libraries. <br />"


## zip

# `cd #{project_folder} && /usr/bin/zip -r ObjectiveMatchy-#{version}.zip ObjectiveMatchy-#{version}`
# raise "Zip couldn't be created. <br />" unless Dir.entries(project_folder).join(" ") =~ /ObjectiveMatchy-#{version}/

# puts "Release Folder zipped: ObjectiveMatchy-#{version}.zip <br />"