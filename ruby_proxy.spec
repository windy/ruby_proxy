# -*- encoding: utf-8 -*-
require "#{File.expand_path('..',__FILE__)}/lib/ruby_proxy/version"
Gem::Specification.new do |s|
  s.name = %q{ruby-proxy}
  s.version = RubyProxy::VERSION
  
  s.authors = ["yafei Lee"]

  s.description = %q{Ruby Proxy for two or more ruby processes.}
  s.email = %q{lyfi2003@gmail.com}

  s.files = Dir.glob("lib/**/*")
  s.test_files += Dir.glob("unittests/**/*")
  s.homepage = %q{https://github.com/windy/ruby_proxy}
  s.require_paths = ["lib"]
  s.executables = [ "ruby_proxy_server" ]
  s.summary = %q{Ruby Proxy for two or more ruby processes.}

end
