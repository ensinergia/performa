require File.dirname(__FILE__) + '/acceptance_helper'
include Warden::Test::Helpers

feature "Header:" do
  before(:each) do    
    @host = "http://lvh.me"
    Capybara.app_host = @host
  end
  
  describe "Given I am logged in" do
    before(:each) do
      @user = Factory(:user, :tasks => [Factory(:task)])
      
      login_as(@user)
      @host_sub = @host.gsub('lvh.me', 'ievolutioned.lvh.me')
      visit @host_sub + panorama_path
    end
    
    it "should allow me to see the header and it's contents" do
      within(".header-contents") do
        page.should have_content(I18n.t('views.header.app_name'))
        page.should have_content(@user.full_name)
        find_link(I18n.t('views.header.controls.my_account'))
        find_link(I18n.t('views.header.controls.logout'))
        find_field("area_selector").text.should == I18n.t('views.areas.default')
        page.should have_content(I18n.t('views.header.pending_tasks', :count => @user.tasks.count))
      end
    end
    
    it "should log me out when I click logout click" do
      within(".header-contents") do
        click_link(I18n.t('views.header.controls.logout'))
      end
      current_path.should == root_path
      current_url.should == @host + root_path
    end
    
    it "should let me visit my account settings" do
      within(".header-contents") do
        click_link(I18n.t('views.header.controls.my_account'))
      end
      current_path.should == accounts_path
      current_url.should == @host_sub + accounts_path     
    end
    
  end
  
  describe "Given I am NOT logged in" do
    
    before(:each) do
      visit @host.gsub('lvh.me', 'ievolutioned.lvh.me') + panorama_path
    end
    
    it "the header should not be shown" do
      page.should_not have_css('.header-contents')
    end
    
  end
end