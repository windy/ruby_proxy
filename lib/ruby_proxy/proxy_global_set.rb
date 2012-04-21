require 'ruby_proxy/logger'
require 'ruby_proxy/exceptions'
module RubyProxy
	class ProxyGlobalSet
		MAGIC_GLOBAL = [ "$:", "$!", "$@", "$_", "$.", "$&", "$~", "$n", "$=", "$/", "$0", "$*", "$$", "$?" ]
		class <<self
			def set(arg,value)
				arg = convert_to_global(arg)
				Logger.info "global set: #{arg} = #{value}"
				eval("#{arg} = #{value}")
			end

			def get(arg)
				arg = convert_to_global(arg)
				Logger.info "global get: #{arg}"
				eval(arg)
			end

			private
			def convert_to_global(arg)
				check_format(arg)
				add_dollar_if_noexist(arg)
			end

			def check_format(arg)
				if !MAGIC_GLOBAL.include?(arg) and ! arg.match(/^\$?[a-zA-Z_]{1}[a-zA-Z_0-9]*$/)
					raise GlobalVarFormatError,"global variable format wrong: #{arg}"
				end
			end

			def add_dollar_if_noexist(arg)
				arg = "$" + arg unless arg.match(/^\$/)
				arg
			end
		end
	end
end
