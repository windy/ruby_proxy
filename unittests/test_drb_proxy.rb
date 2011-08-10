$LOAD_PATH.unshift File.join(__FILE__,'..','..','lib')

require 'test/unit'

require 'ruby_proxy'
class Me
	def a
		"a"
	end
	
end


class TestDrbProxy < Test::Unit::TestCase
	def setup
  end

  def test_server_start_auto
    assert_kind_of(DRbObject,RubyProxy::DRbClient.client)
  end
	def test_atu_ok
		a = ATU::Hello.new
		puts "aaa= #{a}"
	  assert_equal(1,a.return_1)
		assert_equal("1",a.return_str_1)
	end
	
	def test_mutli_new
		a = ATU::Hello.new
		assert_equal(1,a.return_1)
		b = ATU::Hello.new
		assert_equal(1,a.return_1)
		a2 = ATU::Hello2.new
		assert_equal("hello2",a2.return_1)
	end
	
	def test_pars
		a = ATU::Hello.new
		assert_equal([1,"1"],a.return_with_2ps(1,"1"))
	end
	
	#可变参测试
	def test_vars
		a = Me.new
		assert_equal("a",a.a)
		a = ATU::Hello.new
		assert_equal([1,"1"],a.return_vars(1,"1",3,4))
		assert_equal([1,"1"],a.return_vars(1,"1",3,4))
		assert_equal([1,"1"],a.return_vars(1,"1",3,4))
		assert_equal([1,"1"],a.return_vars(1,"1",3,4))
		assert_equal([1,"1"],a.return_vars(1,"1",3,4))
		assert_equal([1,"1"],a.return_vars(1,"1",3,4))
	end
	
	def test_support_thread
		a = Me.new
		assert_equal("a",a.a)
		t = Thread.new do
			a = ATU::Hello.new
			for i in 1..100 do
				assert_equal(1,a.return_1)
				assert_equal(1,a.return_1)
				
				#sleep 1
			end
		end
		b = ATU::Hello.new
		assert_equal(1,b.return_1)
    assert_equal("1",b.return_str_1)
		#sleep 20

		assert_equal("1",b.return_str_1)
	  t.join
    c = ATU::Hello.new
    assert_equal(1,c.return_1)
  end
	
	def test_method_missing1
		a = ATU::Hello3.new(1,"2")
		i=1
		1.upto(100) do |i|
			assert_equal("method#{i}",a.send("method#{i}"))
		end
	end
	
	
	
	
	def test_atu_gue
		assert_raise(NameError) do
			ATU::ExistNo.new
		end
	end
	
	def test_atu_sikuli
		screen = ATU::Sikuli::Region.new(0,0,1440,900)
		assert_not_nil(screen)
	end
	#多个模块内的调用
	def test_multi_m
		a = ATU::M1::Hello4.new
    assert_equal("one",a.one("test"))
	end
	
	def test_include_other_module
		a = ATU::M1::Hello6.new
		assert("b",a.b)
	end
	def test_constant_should_ok
		assert(1,ATU::M1::Hello6::C)
  end

  def test_class_module_function_should_ok
    assert([1,"1"],ATU::M1::Hello6.a(1,"1"))
    assert("m",ATU::M1::m)
  end
  # failed
  def test_block_ok
    a = ATU::M1::Hello6.new
    assert_equal(1,a.a() {|i| i})
  end

	
end