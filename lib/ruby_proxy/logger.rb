require 'logger'

module RubyProxy
	class Logger
		@@logger = ::Logger.new(STDOUT)
		@@logger.level = ::Logger::INFO

		def self.level=(level)
			@@logger.level = level
		end

		def self.level
			@@logger.level
		end

		def self.log(arg)
			@@logger.info arg
		end

		def self.info(arg)
			@@logger.info arg
		end

		def self.debug(arg)
			@@logger.debug arg
		end

		def self.warn(arg)
			@@logger.warn arg
		end
		def self.error(arg)
			@@logger.error arh
		end
	end
end
