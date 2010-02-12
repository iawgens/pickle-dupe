$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'pickle-dupe'
require 'spec'
require 'spec/autorun'

require File.expand_path(File.join(File.dirname(__FILE__), '../features/app'))

require 'dupe'
# ActiveResources
class Recipe < ActiveResource::Base
  self.site = ''
end

Spec::Runner.configure do |config|
  
end
