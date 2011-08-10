require 'setup'

class TestSikuliApi < Test::Unit::TestCase
	@@image_path = nil
	def setup
		@@image_path ||= File.join(__FILE__,'..','support','image')
	end
	def test_sikuli_module
		screen = ATU::Sikuli::Screen.new
		assert_equal(0,screen.x)
		assert_equal(0,screen.y)
		assert_equal(true,screen.w > 0)
		assert_equal(true,screen.h > 0)
	end
	
	def test_screen_click
		#region = ATU::Sikuli::Region.new(0,0,1440,900)
		region = ATU::Sikuli::Screen.new
		assert_equal(0,region.x)
		assert_equal(0,region.y)
		assert_equal(true,File.exist?(File.join(@@image_path,"start.png")))
		region.click(File.expand_path(File.join(@@image_path, "start.png")),0)
		assert_nothing_raised do 
			region.wait(File.expand_path(File.join(@@image_path,"search.png")),10)
		end
		#~ region.type(ATU::Key.ESC)
		#~ assert_nothing_raised do
			#~ region.waitVanish(File.expand_path(File.join(@@image_path,"search.png")),10)
		#~ end
	end
	
	
end
