$LOAD_PATH.unshift File.dirname(__FILE__)
require 'setup'

class TestConfig < Test::Unit::TestCase
  def setup
    @config = RubyProxy::Config
  end
  
  def test_config_default
    assert_equal(8000, @config.port)
    assert_equal('127.0.0.1', @config.ip)
    assert_equal('ruby', @config.command)
  end
  
  def test_config_personal
		@config.port = 1111
    assert_equal(1111, @config.port)
		@config.ip = '1.1.1.1'
    assert_equal('1.1.1.1', @config.ip)
		@config.command = 'ruby'
    assert_equal('ruby', @config.command)
  end
  
end
