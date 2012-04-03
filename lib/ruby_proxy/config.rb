require 'yaml'
module RubyProxy
  class Config
    def initialize(file=nil)
      file = file || File.join(File.dirname(__FILE__), 'config.yml')
      @config = YAML.load_file(file)
    end
    
    def ip
      @config['ip'] || '127.0.0.1'
    end
    
    def port
      @config['port'] || 8000
    end
    
    def command
      @config['command'] || 'ruby'
    end
  end
end
