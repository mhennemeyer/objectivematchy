require 'rubygems'
require 'spec'


Dir.new(File.dirname(__FILE__)).entries.select {|f| f =~ /_spec.rb$/ }.each do |f| 
  puts f
  puts `spec #{f}`
end