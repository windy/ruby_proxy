require 'drb'
require 'ruby_proxy/proxy'
module RubyProxy
  class DRbServer
    @ip = "127.0.0.1"
    @port = 9000
    class << self
      attr_writer :ip,:port
    end
    def self.start_service
      DRb.start_service("druby://#{@ip}:#{@port}",Proxy)
      DRb.thread.join
    end
    def self.stop_service
      DRb.stop_service
    end
  end
end

if $0 == __FILE__
  ['INT'].each do |signal|
    trap(signal) {
      RubyProxy::DRbServer.stop_service
    }
  end
  puts "start server ip:#{ARGV[0]}"
  puts "start server port:#{ARGV[1]}"
  RubyProxy::DRbServer.ip = ARGV[0] unless ARGV[0].nil?
  RubyProxy::DRbServer.port = ARGV[1] unless ARGV[1].nil?
  RubyProxy::DRbServer.start_service
end
