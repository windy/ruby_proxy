$LOAD_PATH.unshift File.dirname(__FILE__)
require 'setup'

$all_tests.each { |f| require f }
