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

out = `cd ObjectiveMatchyIphone && touch /tmp/null && xcodebuild -target ObjectiveMatchy clean  build 3> /tmp/null 2> /tmp/null 1> /tmp/null && xcodebuild -target ObjectiveMatchyIphoneStaticDevice clean build 3> /tmp/null 2> /tmp/null 1> /tmp/null  && xcodebuild -target ObjectiveMatchyIphoneStaticSimulator clean build 3> /tmp/null 2> /tmp/null 1> /tmp/null && cd ..  `

raise "There was a Problem with building the libraries. Output: #{out}" unless $?.exitstatus == 0

puts "Finished building libraries <br />"


## copy lib and framework

`cd #{release_folder} &&  cp -R ../ObjectiveMatchyIphone/build/Release/ObjectiveMatchy.framework . && cp ../ObjectiveMatchyIphone/build/Release-iphoneos/libObjectiveMatchyIphoneDevice.a . && cp ../ObjectiveMatchyIphone/build/Release-iphonesimulator/libObjectiveMatchyIphoneSimulator.a . && cd ..`

raise "Framework has not been copied over to Release Folder." unless Dir.entries(release_folder).join(" ") =~ /ObjectiveMatchy\.framework/
raise "Simulator Library has not been copied over to Release Folder." unless Dir.entries(release_folder).join(" ") =~ /libObjectiveMatchyIphoneSimulator\.a/
raise "Device Library has not been copied over to Release Folder." unless Dir.entries(release_folder).join(" ") =~ /libObjectiveMatchyIphoneDevice\.a/
puts "Framework and libs copied to Release Folder <br />"