require File.dirname(__FILE__) + '/acceptance_helper'
include Warden::Test::Helpers

feature "Panorama landing page:" do
  before(:each) do    
    @host = "http://lvh.me"
    Capybara.app_host = @host
  end
  
  describe "Given I am logged in" do
    before(:each) do
      @user = Factory(:user)
      login_as(@user)
    end
    
    it "should allow me to visit"
    
  end
  
  describe "Given I am NOT logged in" do
    it "should not allow me to visit"
  end
end