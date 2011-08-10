Ruby Proxy
===========

Ruby Proxy allows you to run your ruby codes in more than one ruby or jruby processes.
Now it is designed for using sikuli in ruby through druby lib from jruby.

Requirements
------------
* Ruby
* JRuby `rvm install jruby`
* [Sikuli X 1.0rc2](http://sikuli.org/)
* Windows 7( or Other OS ,that not tested,but in theory not matter )

Compatibility
-------------
I test it passed in ruby1.8.6p111 and jruby1.6.3( ruby-1.8.7-p330 )
Sikuli use 1.0rc2

```

Installation
------------
    First, install ruby,jruby, for windows you can use one-click installation. ( To use ruby and jruby , you may need set path enviroment yourself )
    Second, install sikuli X 1.0rc2.
    At last, gem install ruby_proxy ( not jgem )

Usage
-----
    require 'rubygems'
    require 'ruby_proxy'
    # use ATU module as identification, this code is called by ruby proxy.
    screen = ATU::Sikuli::Screen.new
    screen.click('/home/windy/image/start.png',0)
    screen.type("abc")
    
    #also you can add more ruby proxy api
    #because ruby proxy process env is diff from your now process, you should pass argv absobute path.
    my_file = File.expand_path(File.join(__FILE__,'..','hello.rb'))
    RubyProxy::DRbClient.proxy_load(my_file)
    #now hello object is returned from ruby proxy by another process ( default is jruby ).
    hello = ATU::Hello.new
    # method a() is passed to another process ,then return .
    puts hello.a()
    
    you can see testunits for more usages.
Running the test suite
----------------------

1. prepare your ruby and jruby . if you want use sikuli , install it.
2. run all_tests.rb

Examples
--------

* now ruby proxy is very new,more expamples depend on you.