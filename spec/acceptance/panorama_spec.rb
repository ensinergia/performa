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
      @sub_host = @host.gsub('lvh.me', "#{@user.subdomain}.lvh.me")
      visit @host + panorama_path
    end
    
    describe "and I have yet company related info tasks to do" do
      it "should allow me to visit" do
        current_url.should == @sub_host + panorama_path
        current_path.should == panorama_path

        within(".menu") do
          find_link I18n.t('views.menu.panorama')
          find_link I18n.t('views.menu.creed')
          find_link I18n.t('views.menu.foda')
          find_link I18n.t('views.menu.expectations')
          find_link I18n.t('views.menu.objectives')
          find_link I18n.t('views.menu.programmes')
          find_link I18n.t('views.menu.people')
        end
      
        page.should have_content I18n.t('views.panorama.title')
        page.should have_content I18n.t('views.panorama.description')
      
        find_link I18n.t('views.panorama.actions.add_creed')
        find_link I18n.t('views.panorama.actions.add_foda')
        find_link I18n.t('views.panorama.actions.add_expectations')
        find_link I18n.t('views.panorama.actions.add_objectives')
        find_link I18n.t('views.panorama.actions.add_programmes')
        find_link I18n.t('views.panorama.actions.add_areas_and_people')
        
        click_link I18n.t('views.menu.panorama')
        
        current_url.should == @sub_host + panorama_path
        current_path.should == panorama_path
      end
    end
  end
  
  describe "Given I am NOT logged in" do
    
    before(:each) do
      visit @host + panorama_path
    end
    
    it "should not allow me to visit" do
      current_url.should == @host + new_user_session_path
      current_path.should == new_user_session_path
    end
  end
end