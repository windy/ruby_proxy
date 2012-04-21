require 'rubygems'
require 'java'
#$CLASSPATH << "/Applications/Sikuli-IDE.app/Contents/Resources/Java/"
#This is key to making it work under ruby. The path above is the default
#installation location on the Mac which contains all of the
#relevant sikuli jar files.
require "atu/sikuli-script.jar"



module Sikuli
	java_import 'org.sikuli.script.Region'
	java_import 'org.sikuli.script.Screen'
	java_import 'org.sikuli.script.Settings'
	java_import 'org.sikuli.script.Pattern'
	java_import 'org.sikuli.script.SikuliEvent'
	java_import 'org.sikuli.script.SikuliScript'
	include Java::OrgSikuliScript
end

class Java::OrgSikuliScript::Region
	alias old_paste paste
	def paste(*args)
		len = args.length
		if len == 1
			old_paste(nil,java.lang.String.new(args[0].to_java_bytes,"utf-8"))
		elsif  len== 2
			old_paste(args[0],java.lang.String.new(args[1].to_java_bytes,"utf-8"))
		end
	end
end
if __FILE__ == $0
  puts Sikuli
  @region = Sikuli::Region.new(0, 0, 1440, 900)
  puts @region.class
  puts Sikuli::C.new.class
end
