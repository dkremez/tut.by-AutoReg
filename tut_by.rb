require 'rubygems'
require 'capybara' 
require 'capybara/dsl' 



Capybara.current_driver = :selenium
Capybara.app_host = 'http://profile.tut.by/' 
module MyModule
  class Tut_by_test
    def test 
      Capybara.visit('/')
	  Capybara.click_on('Я согласен с правилами'.encode("UTF-8"))
    end
  end
end
t = MyModule::Tut_by_test.new
t.test

