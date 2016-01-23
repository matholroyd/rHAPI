require 'rubygems'
require 'active_support'
require 'active_support/inflector/inflections'

%w{
  connection
  property
  contact
  company
  lead
  configuration
  r_hapi_exception
}.each do |file|
  require File.expand_path("../r_hapi/#{file}", __FILE__)
end

require 'curb'
require 'json'

module RHapi
  extend Configuration
end
