require 'drb'
require 'ext/drb_ext'
require 'timeout'
require 'socket'
require 'logger'

module ATU
  
  #require redefine
  class << self
    alias require_old require
    
    def require(arg)
      #TODO: path maybe confict
      #~ path= File.expand_path File.join(Dir.pwd,arg)
      #~ path += '.rb'
      RubyProxy::DRbClient.proxy_load(arg)
    end
  end

  #entry
  def self.const_missing(name)
    name = self.name.to_s + "::" + name.to_s
    type = RubyProxy::DRbClient.client.proxy_type(name)
    make_kclass(name,type)
  end

  def self.make_kclass(name,type)
    #puts "make_kclass: #{name}, #{type}"
    case type
    when "Class"
      RubyProxy::KlassFactory.make_class(name) do |klass|
        klass.class_eval do
          def initialize(*arg)
            @proxy = RubyProxy::DRbClient.client.proxy(self.class.to_s,"new",*arg)
          end
           # I think all methods should be proxyed by remote
          undef :type rescue nil
          undef :to_s
          undef :to_a if respond_to?(:to_a)
          undef :methods
          
          def __proxy
            @proxy
          end
          
          def method_missing(name,*arg,&block)
            #return if @proxy.nil?
            #puts "#{@proxy.methods(false)}"
            #puts "proxy = #{@proxy} method=#{name} arg=#{arg.join(',')}"
            @proxy.__send__(name,*arg,&block)
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
          
          # TODO: block not support now
          def self.method_missing(name,*arg,&block)
            RubyProxy::DRbClient.client.proxy(self.name.to_s,name.to_s,*arg,&block)
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
  
  # generate proxy class
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
  
  # Get DRbClient
  class DRbClient
    @client = nil
    @@logger =  Logger.new(STDOUT)
    @@logger.level= Logger::INFO
    class <<self
      def client
        begin
          stop_service if @client.nil?
          start_service if @client.nil?
          connect_addr = "druby://#{Config.ip}:#{Config.port}"
          @client ||= DRbObject.new(nil,connect_addr)
        rescue DRb::DRbConnError
          raise RubyProxy::NotConnError, "can connect to druby server: #{connect_addr}"
        end
      end

      def alive?
        @client.respond_to?("any_thing")
        true
      rescue DRb::DRbConnError
        false
      end

      attr_accessor :ip,:port
      
      def proxy_load(dir_or_file)
        client.proxy_load(dir_or_file)
      end

      # not use it later
      def start_service(t=10)
        message = nil
        @service_log = nil
        @@logger.info "start ruby proxy server..."
        @@logger.info start_command
        #~ @server_thread =  Thread.new do |t|
            #~ t.abort_on_exception = true
            @service_log = IO.popen(start_command)
        #~ end
        #~ @server_thread.abort_on_exception = true
        wait_until_server_start_time(t)
      end
      
      def start_command
        #raise RubyProxy::CommandNotFoundError, "ruby command can not be found: #{Config.command}" unless File.file?(Config.command)
        server_file = File.expand_path File.join( File.dirname(__FILE__), 'server.rb' )
        Config.command + " " + server_file
      end
      
      def stop_service(t=5)
        TCPSocket.new(Config.ip,Config.port)
        @client ||= DRbObject.new(nil,"druby://#{Config.ip}:#{Config.port}")
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
            #~ raise CannotStartServer, "" unless @server_thread.alive?
            TCPSocket.new(Config.ip,Config.port)
            @@logger.info "server is starting"
            do_at_exit
            return true
          rescue Exception
            sleep 1
          end
        end
        raise RuntimeError,"start drbserver fail"
      end

      def do_at_exit
        at_exit do
          @@logger.info "try to stop service"
          stop_service
        end
      end

    end
  end
end

if $0 == __FILE__
  a = ATU::Hello.new
  puts a.return_1
end
