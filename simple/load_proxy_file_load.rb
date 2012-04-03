$LOAD_PATH.unshift File.join( File.dirname(__FILE__), '..','lib')

require 'ruby_proxy'

ATU::require 'hello'

a = ATU::Hello.new

puts a.say