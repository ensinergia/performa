#encoding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'
include Warden::Test::Helpers

feature "Operating cicles specs" do
  before(:each) do    
    @host = "http://lvh.me:#{Capybara.server_port}"
    Capybara.app_host = @host
    @user = Factory(:user)
    @sub_host = @host.gsub('lvh.me', "#{@user.subdomain}.lvh.me")
    login_as(@user)    
  end
end #end feature 