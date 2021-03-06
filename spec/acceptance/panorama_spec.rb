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
          find_link "panorama-menu"
          find_link "direction-menu"
          find_link "swot-menu"
          find_link "strategic-lines-menu"
          find_link "strategic-objectives-menu"
          #find_link "programs-menu"
          find_link "people-menu"
        end
      
        page.should have_content I18n.t('views.panorama.title')
        
        first_content, last_content = I18n.t('views.panorama.description').split(" ")
        page.should have_content first_content
        page.should have_content last_content
        
        find_link I18n.t('views.panorama.actions.add_creed')
        find_link I18n.t('views.panorama.actions.add_swot')
        find_link I18n.t('views.panorama.actions.add_strategic_lines')
        find_link I18n.t('views.panorama.actions.add_objectives')
        find_link I18n.t('views.panorama.actions.add_programmes')
        find_link I18n.t('views.panorama.actions.add_areas_and_people')
        
        click_link "panorama-menu"
        
        current_url.should == @sub_host + panorama_path
        current_path.should == panorama_path
      end
      
      it "should allow me to visit the creed page" do
        click_link I18n.t('views.panorama.actions.add_creed')
        current_url.should == @sub_host + creed_visions_path
        current_path.should == creed_visions_path
        
      end
      
      it "should allow me to visit the swot page" do
        click_link I18n.t('views.panorama.actions.add_swot')
        current_url.should == @sub_host + swot_analyses_path
        current_path.should == swot_analyses_path
        
      end
      
      it "should allow me to visit the strategic lines page" do
        click_link I18n.t('views.panorama.actions.add_strategic_lines')
        current_url.should == @sub_host + strategic_lines_path
        current_path.should == strategic_lines_path
        
      end
      
      it "should allow me to visit the strategic objectives page" do
        click_link I18n.t('views.panorama.actions.add_objectives')
        current_url.should == @sub_host + strategic_objectives_path
        current_path.should == strategic_objectives_path
        
      end
      
      it "should allow me to visit the people page" do
        click_link I18n.t('views.panorama.actions.add_areas_and_people')
        current_url.should == @sub_host + people_path
        current_path.should == people_path
        
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
  
  it "should show me the terms of service"
end