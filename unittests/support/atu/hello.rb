module B
  def b
    return "b"
  end
  class H
  end
end


module ATU
  class Hello
    def initialize
    end
    
    def return_1
      1
    end
    def return_str_1
      "1"
    end
    
    def return_with_2ps(a,b)
      return a,b
    end
    
    def return_vars(*a)
      return a[0],a[1]
    end
    
    
  end
  
  class Hello2
    def return_1
      "hello2"
    end
    
  end
  
  class Hello3
    def initialize(a,b)
    end
    def method_missing(m,*arg)
      return m.to_s
    end
    
  end
  
  module M1
  
    def self.m
      "m"
    end
    
    class Hello4
      def test
        return "test"
      end
      def one(p)
        return "one"
      end
    end
    class Hello5
      def ok
        1
      end
    end
    
    class Hello6
      include B
      C = 1
      def self.a(*arg)
        return arg
      end
      
      def a(*arg)
        var = 1
        yield var
      end
      def b(*arg)
        var = 1
        yield var if block_given?
        arg
      end
      
      def self.file_exist?(path)
        File.exist?(path)
      end
    end
    
    class Hello7
      def to_a
        puts "call to_a"
        [1,2,3]
      end
      def type(a)
        puts "call type"
        "a"
      end
      def to_s
        puts "call to_s"
        return "b"
      end
      def normal
        "normal"
      end
    end
    
  end
  
end

