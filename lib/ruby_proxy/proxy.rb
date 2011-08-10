require 'logger'
require 'drb'
require 'ruby_proxy/proxy_load'

module RubyProxy
  class Proxy
    # loading proxy class, default folder: atu
    # you can use Proxy.load_path << "" to add load path
    ProxyLoad.load
    @@logger = Logger.new(STDOUT)
    @@logger.level = Logger::DEBUG
    def self.proxy(klass_name,method=nil,*arg,&block)
      @@logger.debug "klass_name= #{klass_name}"
      @@logger.debug "method = #{method}"
      @@logger.debug "arg = #{arg.join(',')}"
      if method.nil?
        return proxy_module(klass_name)
      else
        return proxy_module(klass_name).send(method,*arg,&block)
      end
    end
    
    def self.proxy_type(klass_name)
      #@@logger.debug "proxy_type: #{proxy_const_get(klass_name).name} type is #{proxy_const_get(klass_name).class.to_s}"
      return proxy_const_get(klass_name).class.to_s
    end
    
    def self.proxy_module(klass_name)
      m = proxy_const_get(klass_name)
      m.class_eval { include DRb::DRbUndumped } if ( m.class.to_s == "Class" or m.class.to_s == "Module" ) and ! m.include?(DRb::DRbUndumped)
      return m
    end
    
    def self.proxy_const_get(klass_name)
      #@@logger.debug "const_get klass_name = #{klass_name}"
      atu = nil
      klass_name_array = klass_name.split('::')
      klass_name_array.shift if klass_name_array[0] == "ATU"
      klass_name_array.each do |m|
        if atu.nil?
          atu = ATU.const_get(m)
        else
          atu = atu.const_get(m)
        end
      end
      atu
    end
    
    def self.stop_proxy
      DRb.stop_service
    end
    
  end
end
