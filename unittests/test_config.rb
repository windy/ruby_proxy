$LOAD_PATH.unshift File.dirname(__FILE__)
require 'setup'

class TestConfig < Test::Unit::TestCase
  def setup
    @config = RubyProxy::Config.new
  end
  
  def test_config_default
    assert_equal(8000, @config.port)
    assert_equal('127.0.0.1', @config.ip)
    assert_equal('C:\Ruby\bin\ruby', @config.command)
  end
  
  def test_config_personal
    config = RubyProxy::Config.new(File.join(File.dirname(__FILE__),'support','config.yml'))
    assert_equal(1111, config.port)
    assert_equal('1.1.1.1', config.ip)
    assert_equal('ruby', config.command)
  end
  
end
