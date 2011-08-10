require 'rubygems'
require 'java'
#$CLASSPATH << "/Applications/Sikuli-IDE.app/Contents/Resources/Java/"
#This is key to making it work under ruby. The path above is the default
#installation location on the Mac which contains all of the
#relevant sikuli jar files.
require "sikuli-script.jar"

module B
class C
end
end


#~ include Java
module ATU
  module Sikuli
    java_import 'org.sikuli.script.Region'
    java_import 'org.sikuli.script.Screen'
    java_import 'org.sikuli.script.Settings'
    java_import 'org.sikuli.script.SikuliEvent'
    java_import 'org.sikuli.script.SikuliScript'
    include Java::OrgSikuliScript
    include B
  end
  #Sikuli = Java::OrgSikuliScript
end
if __FILE__ == $0
  puts ATU::Sikuli
  @region = ATU::Sikuli::Region.new(0, 0, 1440, 900)
  puts @region.class
  puts ATU::Sikuli::C.new.class
end