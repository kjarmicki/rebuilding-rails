require 'rack/test'
require 'test/unit'

gem_dir = File.join(__dir__, "..", "lib")
$LOAD_PATH.unshift File.expand_path(gem_dir)

require "rulers"
