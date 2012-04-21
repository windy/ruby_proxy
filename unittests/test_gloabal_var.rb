require 'setup'

class TestGlobalVar < Test::Unit::TestCase
	def test_global_get_ok
		assert_equal(ATU["$LOAD_PATH"], ATU["LOAD_PATH"])
	end

	def test_global_get_noexist
		assert_equal(nil, ATU["NO"])
	end

	def test_global_get_format_error
		assert_raise(RubyProxy::GlobalVarFormatError) { ATU["12345"] }
	end

	def test_global_set_ok
		ATU["HELLO"] = 10
		assert_equal(10, ATU["HELLO"])
	end
end
