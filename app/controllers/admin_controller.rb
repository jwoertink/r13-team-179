class AdminController < ApplicationController
  layout 'admin'
  before_filter :authenticate
  
  USERNAME = ENV['ADMIN_LOGIN']
  PASSWORD = ENV['ADMIN_PASSWORD']
    
  protected
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      puts "username is #{username}\n\n"
      puts "USERNAME is #{USERNAME}\n\n"
      puts "password is #{password}\n\n"
      puts "PASSWOD is #{PASSWORD}\n\n"
      username == USERNAME && password == PASSWORD
    end
  end
  
end