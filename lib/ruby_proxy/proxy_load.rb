require 'logger'
module RubyProxy
  class ProxyLoad
    @load_path = []
    class <<self
      attr_accessor :load_path
      def load
        load_path.uniq.each do |p|
          if File.directory?(p)
            Dir[p.chomp("/") + "/*.rb"].each do |file|
              load_file(file)
            end
          else
            load_file(p)
          end
        end
      end
      
      def load_file(file)
        Logger.debug "require file : #{file}"
        require file
      rescue LoadError=>e
        Logger.warn "require file : #{file} fail,exception:\n#{e}"
        raise 
      end
    end
  end
end
