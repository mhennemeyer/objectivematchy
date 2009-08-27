#!/usr/bin/env ruby -wKU

site_folder = File.expand_path(".")
puts "In #{site_folder}.:"
puts `webgen`


timestamp = Time.now.to_i
deploy_folder = "#{site_folder}/deploy/#{timestamp}/objectivematchy"

 
`mkdir -p #{deploy_folder}`
if File.directory?(deploy_folder)
  puts "Local Deploy Folder: #{deploy_folder}"
else
  raise "Couldn't make deploy dir: #{deploy_folder}."
end

`cd #{site_folder}/out && cp -r * #{deploy_folder}`
puts Dir.entries(deploy_folder).join(" ")
if Dir.entries(deploy_folder).join(" ") =~ /\s*index.html\s*/
  puts "Output moved to #{deploy_folder}"
else
  raise "Couldn't copy output to #{deploy_folder}"
end

puts `cd #{deploy_folder} && cd .. && scp -r objectivematchy root@matchy.org:/var/www/`

puts "Finished"