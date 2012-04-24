$LOAD_PATH.unshift File.join( File.dirname(__FILE__), '..','lib')

require 'ruby_proxy'

# add ruby proxy LOAD_PATH
ATU << File.dirname(__FILE__)

# load other class with ruby proxy
ATU::require 'hello'

a = ATU::Hello.new

puts a.say
