module RubyProxy
  class Error < RuntimeError; end
  # can not connect to proxy server
  class NotConError < Error; end
  #config command config error
  class CommandNotFoundError < Error; end
  # start server fail error
  class CannotStartServer < Error; end
	# format wrong with global variable
	class GlobalVarFormatError < Error; end
end
