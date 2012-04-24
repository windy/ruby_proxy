module RubyProxy
  class Config
		@config = {
			:ip => '127.0.0.1',
			:port=> 8889,
			:command => 'ruby',
      :autostart => true,
		}
    class <<self
			def ip
				@config[:ip]
			end

			def ip=(ip)
				@config[:ip] = ip
			end
			
			def port=(port)
				@config[:port] = port
			end

			def port
				@config[:port]
			end

			def command
				@config[:command]
			end
			
			def command=(command)
				@config[:command] = command
			end

      def autostart
        @config[:autostart]
      end
      def autostart=(bool)
        @config[:autostart] = bool
      end
    end
  end
end
