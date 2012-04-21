$LOAD_PATH.unshift File.join( File.dirname(__FILE__), '..','lib')
require 'ruby_proxy'

RubyProxy::Config.command = "/home/windy/.rvm/rubies/jruby-1.6.7/bin/ruby"

ATU.require 'sikuli'

a = ATU::Sikuli::Screen.new
a.click(10,10)
