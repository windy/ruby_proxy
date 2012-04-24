
$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'..','lib') unless $LOADED
$LOADED = true

require 'test/unit'

require 'ruby_proxy'

#RubyProxy::Config.autostart = false

$all_tests = Dir['test_*.rb']
