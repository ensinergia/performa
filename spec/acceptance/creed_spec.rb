require File.dirname(__FILE__) + '/acceptance_helper'
include Warden::Test::Helpers

feature "Creed section:" do
  before(:each) do    
    @host = "http://lvh.me"
    Capybara.app_host = @host
    
    @user = Factory(:user)
    @sub_host = @host.gsub('lvh.me', "#{@user.subdomain}.lvh.me")
    login_as(@user)
  end
  
  describe "Given I am on the landing page" do
    before(:each) do
      visit @host + panorama_path
    end
    
    it "should take me to the mission section when I click the mission link menu item" do
      click_link I18n.t('views.menu.creed')
      current_url.should == @sub_host + missions_path
      current_path.should == missions_path
      
      find_link I18n.t('views.creed.vision')
      find_link I18n.t('views.creed.mission')
      find_link I18n.t('views.creed.battle_cry')
      
      page.should have_content I18n.t('views.creed.first_view.title')
      page.should have_content I18n.t('views.creed.first_view.description')
      
      find_button I18n.t('views.creed.first_view.controls.add_vision')
    end
  end
  
end