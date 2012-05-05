$LOAD_PATH.unshift File.dirname(__FILE__)
require 'setup'

#RubyProxy::Config.command = "/home/windy/.rvm/rubies/jruby-1.6.7/bin/ruby"

class TestAtuLoad < Test::Unit::TestCase
  def setup
    ATU << File.dirname(__FILE__)
  end
	def test_load_ok
		assert_nothing_raised {
			ATU.require 'support/atu/hello.rb'
		}
	end
  
  def test_load_error_file
    assert_raise(SyntaxError) {
      ATU.require 'support/atu/error_file'
    }
    assert_raise(NameError) {
      ATU.require 'support/atu/error_file_2'
    }
  end
  
	def test_load_noexist
		assert_raise(LoadError) { ATU.require 'noexist' }
	end
end
