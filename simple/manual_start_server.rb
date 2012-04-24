require 'rubygems'
require 'ruby_proxy'

# ruby proxy will not start the proxy server automation
# you should use `ruby_proxy_server` to start it manual
# if not, you need install ruby proxy gems again on the other ruby version
RubyProxy::Config.autostart = false
#ATU.command = "ruby"
RubyProxy::Config.ip = "127.0.0.1"
RubyProxy::Config.port = 8889

ATU << File.expand_path(File.dirname(__FILE__))
ATU.require 'hello'

a = ATU::Hello.new

puts a.say
