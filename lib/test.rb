$LOAD_PATH << File.dirname(__FILE__)
$LOAD_PATH << 'C:\jruby-1.5.6\lib\ruby\gems\1.8\gems\sikuli-0.2.3\lib'
require 'rubygems'
require 'ruby_proxy'

ATU::require 'rubygems'
ATU::require 'java'
 
ATU::require 'C:\jruby-1.5.6\lib\ruby\gems\1.8\gems\sikuli-0.2.3\lib\sikuli'

screen = ATU::Sikuli::Screen.new
screen.click(10,10)
#~ browser = ATU::Watir::Browser.new(:ff)

#~ browser.goto("http://google.hk")