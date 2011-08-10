require 'drb'
require 'timeout'
require 'socket'
require 'logger'

module ATU
  #entry
  def self.const_missing(name)
    name = self.name.to_s + "::" + name.to_s
    type = RubyProxy::DRbClient.client.proxy_type(name.to_s)
    make_kclass(name,type)
  end

  def self.make_kclass(name,type)
    puts "make_kclass: #{name}, #{type}"
    case type
    when "Class"
      RubyProxy::KlassFactory.make_class(name) do |klass|
        klass.class_eval do
          def initialize(*arg)
            #puts self.class.to_s
            @proxy = RubyProxy::DRbClient.client.proxy(self.class.to_s,"new",*arg)
          end
          def method_missing(name,*arg)
            #return if @proxy.nil?
            #puts "#{@proxy.methods(false)}"
            #puts "proxy = #{@proxy} method=#{name} arg=#{arg.join(',')}"
            @proxy.__send__(name.to_s,*arg)
          end
          def self.const_missing(name)
            name = self.name.to_s + "::" + name.to_s
            type = RubyProxy::DRbClient.client.proxy_type(name.to_s)
            ret = ATU::make_kclass(name,type)
            case type
              when "Module","Class"
                return ret
            end
            RubyProxy::DRbClient.client.proxy(name.to_s)
          end
          
          # block not support now
          def self.method_missing(name,*arg)
            RubyProxy::DRbClient.client.proxy(self.name.to_s,name.to_s,*arg)
          end

        end
      end
    when "Module"
      RubyProxy::KlassFactory.make_module(name) do |mod|
        mod.class_eval do
          def self.method_missing(name,*arg)
            RubyProxy::DRbClient.client.proxy(self.name.to_s,name.to_s,*arg)
          end

          def self.const_missing(name)
            name = self.name.to_s + "::" + name.to_s
            #puts "in module const_missing : #{name}"
            type = RubyProxy::DRbClient.client.proxy_type(name.to_s)
            ret = ATU::make_kclass(name,type)
            case type
              when "Module","Class"
                return ret
            end
            RubyProxy::DRbClient.client.proxy(name.to_s)
          end
        end
      end
    else

    end

  end
  
end



module RubyProxy
  class KlassFactory
    def self.make_klass(klass_name,type)
      case type
      when "Class"
        make_class(klass_name)
      when "Module"
        make_module(klass_name)
      else
        raise TypeError,"wrong make_klass type: #{type}"
      end
    end
  
  #生成类,返回类常量
    def self.make_class(klass_name)
      klass_name = klass_name.to_s
      name_ok?(klass_name)
      eval <<-EOF
        class #{klass_name}
        end
      EOF
      klass = eval(klass_name)
      yield klass
      klass
    end
    
    def self.make_module(klass_name)
      klass_name = klass_name.to_s
      name_ok?(klass_name)
      eval <<-EOF
        module #{klass_name}
        end
      EOF
      klass = eval(klass_name)
      yield klass
      klass
    end
    
    def self.name_ok?(name)
      raise TypeError," name #{name} can't be class or module name." unless name =~ /^[A-Z][a-zA-Z_0-9]*/
    end
  end
  class DRbClient
    @client = nil
    @port = 9000
    @ip = "127.0.0.1"
    @@logger =  Logger.new(STDOUT)
    @@logger.level= Logger::DEBUG
    class <<self
      def client
        begin
          stop_service if @client.nil?
          @client ||= DRbObject.new(nil,"druby://#{@ip}:#{@port}")
          alive?
          @client
        rescue Exception
          start_service
          @client ||= DRbObject.new(nil,"druby://#{@ip}:#{@port}")
          @client
        end
      end

      def alive?
        @client.respond_to?("any_thing")
        @client
      rescue DRb::DRbConnError
        raise
      end

      attr_accessor :ip,:port
      
      def proxy_load(dir_or_file)
        client.proxy_load(dir_or_file)
      end

      def start_service(t=5)
        message = nil
        @start_service_log_path = File.join(File.dirname(__FILE__),'start_service.log')
        
        server_thread =  Thread.new do
            @@logger.info "start jruby proxy server..."
            org_path = Dir.pwd
            Dir.chdir(File.join(File.dirname(__FILE__),'..')) do
            system("start /I /B jruby ruby_proxy/server.rb #{@ip} #{@port} #{org_path} ")#> #{@start_service_log_path} 2>&1")
            end
        end
        wait_until_server_start_time(t)
      end
      
      def stop_service(t=5)
        TCPSocket.new(@ip,@port)
        @client ||= DRbObject.new(nil,"druby://#{@ip}:#{@port}")
        @client.stop_proxy
        sleep 1
      rescue
        @@logger.debug "service not start,stop fail!"
        @@logger.debug "#{$!}"
      ensure
        @client = nil
      end

      def wait_until_server_start_time(t)
        t.times do |tt|
          begin
            TCPSocket.new(@ip,@port)
            @@logger.info "server is starting"
            return true
          rescue Exception
            sleep 1
          end
        end
        raise RuntimeError,"start drbserver fail, reason: #{File.read(@start_service_log_path) rescue nil}"
      end

    end
  end
end

if $0 == __FILE__
  a = ATU::Hello.new
  puts a.return_1
end