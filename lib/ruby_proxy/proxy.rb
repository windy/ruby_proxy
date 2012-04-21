require 'ruby_proxy/logger'
require 'drb'
require 'ruby_proxy/proxy_load'
require 'ruby_proxy/proxy_global_set'

module RubyProxy
  class Proxy

    def self.proxy(klass_name,method=nil,*arg)
      Logger.debug "klass_name= #{klass_name}"
      Logger.debug "method = #{method}"
      Logger.debug "arg = #{arg.join(',')}"
      if method.nil?
        return proxy_module(klass_name)
      else
        return proxy_module(klass_name).send(method,*arg)
      end
    end
    
    def self.proxy_load(file_or_gem)
      ProxyLoad.load_file(file_or_gem)
    end

    def self.proxy_global_set(arg,var)
      ProxyGlobalSet.set(arg,var)
    end

    def self.proxy_global_get(arg)
      ProxyGlobalSet.get(arg)
    end
    
    def self.proxy_type(klass_name)
      return proxy_const_get(klass_name).class.to_s
    end
    
    def self.proxy_module(klass_name)
      m = proxy_const_get(klass_name)
      m.class_eval { include DRb::DRbUndumped } if ( m.class.to_s == "Class" or m.class.to_s == "Module" ) and ! m.include?(DRb::DRbUndumped)
      return m
    end
    
    def self.proxy_const_get(klass_name)
      atu = nil
      klass_name_array = klass_name.split('::')
      klass_name_array.shift if klass_name_array[0] == "ATU"
      klass_name_array.each do |m|
        if atu.nil?
          atu = Kernel.const_get(m)
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
