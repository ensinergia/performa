#encoding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'
include Warden::Test::Helpers

feature "Strategic Lines:", :js => true do
  before(:each) do        
    @host = "http://lvh.me:#{Capybara.server_port}"
    @user = Factory(:user)
    
    @sub_host = @host.gsub('lvh.me', "#{@user.subdomain}.lvh.me")
    
    Capybara.app_host = @sub_host
    Capybara.default_host = @sub_host

    login_as(@user)
  end

  
  describe "Given there are no strategic lines registered" do
    
    describe "and considering I am on the landing page" do
      
      it "should take me to the strategic lines sub-section when I click the strategic lines link menu item" do
        visit @sub_host + panorama_path
      
        click_link I18n.t('views.menu.strategic_lines')
      
        current_url.should == @sub_host + strategic_lines_path
        current_path.should == strategic_lines_path
      
        page.should have_content I18n.t('views.strategic_lines.first_view.title')
        page.should have_content I18n.t('views.strategic_lines.first_view.description')
      
        find_button I18n.t('views.strategic_lines.first_view.controls.start')
      end
      
    end
    
  end

end