 # coding: utf-8
require 'rubygems'
require 'capybara' 
require 'capybara/dsl' 


Capybara.current_driver = :selenium
Capybara.app_host = 'http://profile.tut.by/' 
module MyModule

  class Registrator
	def login(login)
      @login = login
    end
    def rulesAgree
      Capybara.visit('/')
	  Capybara.click_on('Я согласен с правилами')
    end
    def formFilling
	  
      Capybara.fill_in('Username', :with => @login)
      Capybara.click_on('Проверить')
      Capybara.fill_in('Password1', :with => '123456qwerty')
      Capybara.fill_in('Password2', :with => '123456qwerty')
      Capybara.fill_in('Answer', :with => '123')
      Capybara.fill_in('FirstName', :with => @login)
      Capybara.fill_in('SecondName', :with => 'Asaq')
      Capybara.fill_in('_3_1', :with => '12')
      Capybara.fill_in('_3_3', :with => '1992')
      
      Capybara.select('Мужчина', :from => '_4')
      capcha = capchaPut
      Capybara.fill_in('ap_word' , :with => capcha )
      Capybara.click_on('reg_btn')
      Capybara.visit('http://profile.tut.by/change.html')
      
    end
    def nickGenerate
      Capybara.visit('http://nick-name.ru/generate/')
      Capybara.click_on('Генерировать')
      return Capybara.find_field('resname').value
    end
    def capchaPut
     puts 'enter the captcha'
      capcha = gets.chomp
     return capcha
    end  
    def getCapcha 
      Capybara.page_save_screenshot('screen.gpg')

    end

  end
end
t = MyModule::Registrator.new
logins = []

puts 'Enter a number of registration users'
numberOfUsers = gets.chomp

i=0
while i < numberOfUsers.to_i
  login =t.nickGenerate + 'unique'
  t.login(login)
  t.rulesAgree
  t.formFilling  
  logins = logins + [login + ' ' + '123456qwerty']
  i+=1
end
puts logins
