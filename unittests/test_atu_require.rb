require 'setup'

RubyProxy::Config.command = "/home/windy/.rvm/rubies/jruby-1.6.7/bin/ruby"

class TestAtuLoad < Test::Unit::TestCase
	def test_load_ok
		assert_nothing_raised {
			ATU.require 'support/atu/hello.rb'
		}
	end

	def test_load_noexist
		assert_raise(LoadError) { ATU.require 'noexist' }
	end
end
