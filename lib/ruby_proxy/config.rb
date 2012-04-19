module RubyProxy
  class Config
		@config = {
			:ip => '127.0.0.1',
			:port=> 8000,
			:command => 'ruby'
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
    end
  end
end
