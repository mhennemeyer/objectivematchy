require 'rubygems'
require 'spec'
require File.dirname(__FILE__) + '/../om_features.rb'

class String
  def ignore_whitespace
    self.gsub(/\s+/, " ")
  end
end