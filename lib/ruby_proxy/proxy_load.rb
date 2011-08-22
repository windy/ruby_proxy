require 'logger'
module RubyProxy
  class ProxyLoad
    @@logger = Logger.new(STDOUT)
    @@logger.level = Logger::INFO
    @load_path = ['atu']
    class <<self
      attr_accessor :load_path
      def load
        load_path.uniq.each do |p|
          if File.directory?(p)
            Dir[p.chomp("/") + "/*.rb"].each do |file|
              load_file(file)
            end
          elsif File.file?(p)
            load_file(p)
          else
            @@logger.warn("path: #{p} not exist ,ignore")
          end
        
        end
      end
      
      def load_file(file)
        @@logger.debug "require file : #{file}"
        Kernel.require file
      rescue LoadError
        @@logger.warn "require file : #{file} fail,exception:"
        @@logger.warn "#{$!}"
      end
    end
  end
end
