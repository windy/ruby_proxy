Ruby Proxy
===========

Ruby Proxy allows you to run your ruby codes in more than one ruby or jruby processes.
With it We can use jruby's gems in ruby easily. In other word,  using ruby's gems in jruby is aslo supported.
It build on DRb libariy.

Requirements
------------
* rvm ( with it we can change our ruby version easily )
* Ruby `rvm install ruby`
* JRuby `rvm install jruby`

Compatibility
-------------
I test it passed in ruby1.8.6p111 and jruby1.6.3( ruby-1.8.7-p330 )


Installation
------------
    unlike other gems, ruby-proxy installing is just more complex :) But also can be understood.
    First, change your ruby envorment to default:
    `rvm use x.x.x`
    `gem install ruby-proxy`
    Second, change to other ruby envorment that will be proxyed:
    `rvm use jruby` ( jruby or other version )
    `gem install ruby-proxy`
Usage
-----
    require 'rubygems'
    require 'ruby_proxy'
    
    # configure what version ruby will be proxyed
    # if `RubyProxy::Config.autostart = true`, ruby proxy process will be start automation.
    # you can change it, manual execute ` ruby_proxy_server ` to start ruby proxy.
    RubyProxy::Config.command = '/home/windy/.rvm/rubies/jruby-1.6.7/bin/ruby'
    
    # loading gems
    
    ATU.require 'sikuli'
    
    a = ATU::Sikuli::Screen.new
    a.click(10,10)
    
    
    # loading personal ruby file
    # use `<<` method to add load_path to ruby proxy process
    ATU << File.expand_file(File.dirname(__FILE__))
    
    #ATU is default module name, it's inner code will be proxyed
    ATU.require 'hello'
    a = ATU::Hello.new
    puts a.say # output: hello
    
    you can see simple files for more usages.
Running the test suite
----------------------

1. prepare your ruby and jruby . if you want use sikuli , install it.
2. run all_tests.rb

Notice
-------
Please **DONOT** upgrade to 0.2.x if you are using ruby proxy before.

It's API is changed more and more!

I just want give you the best code. Don't be panic.

Examples
--------

* in Ruby1.8.6 Using jruby's sikuli_ruby<https://github.com/chaslemley/sikuli_ruby>
* in Jruby Using ruby's win32ole
* in Ruby1.8.6 Using ruby1.8.7's watir-webdriver<https://github.com/watir/watir-webdriver>