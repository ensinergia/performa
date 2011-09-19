require File.dirname(__FILE__) + '/acceptance_helper'
include Warden::Test::Helpers

feature "Creed section (Missions):" do
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
    
    it "should take me to the mission sub-section when I click the creed link menu item and then the mission link" do
      click_link I18n.t('views.menu.creed')
      click_link I18n.t('activerecord.models.mission')
      
      current_url.should == @sub_host + creed_missions_path
      current_path.should == creed_missions_path
      
      find_link I18n.t('activerecord.models.vision')
      find_link I18n.t('activerecord.models.war_cry')
      
      page.should have_content I18n.t('views.creed.first_mission.title')
      page.should have_content ignoring_new_lines(I18n.t('views.creed.first_mission.description'))
      
      find_button I18n.t('views.creed.first_mission.controls.add_mission')
    end
  end
  
  describe "Given I have not yet registered a mission" do
    before(:each) do
      visit @host + panorama_path
      @user_in_area=Factory.create(:user_no_company_name, :area => @user.area, :company => @user.company)
      @user_not_in_area = Factory.create(:user_no_company_name_other_area, :name => 'Fulano aquel', :company => @user.company)
    end
    
    it "should take me to the new mission form when I click the add mission button" do
      visit @sub_host + creed_missions_path
      click_button I18n.t('views.creed.first_mission.controls.add_mission')
      
      current_url.should == @sub_host + new_creed_mission_path
      current_path.should == new_creed_mission_path
   
      find_link I18n.t('activerecord.models.vision')
      find_link I18n.t('activerecord.models.mission')
      find_link I18n.t('activerecord.models.war_cry')
      
      page.should have_content I18n.t('views.creed.new_mission.title')
      page.should have_content I18n.t('views.creed.most_views.notify_to')
      
      find_field 'mission_description'
      
      notifications_area_with(@user, {:notified => [@user_in_area], :unnotified => [@user_not_in_area]})
      
      find_link I18n.t('views.creed.most_views.controls.cancel')
      find_button I18n.t('views.creed.new_mission.controls.save')
      
      within(".help") do
        page.should have_content I18n.t('views.common.help.title')
        page.should have_content I18n.t('activerecord.models.mission')      
        page.should have_content I18n.t('views.creed.help.mission.description')    
        page.should have_content I18n.t('views.creed.help.notifications.title')      
        page.should have_content I18n.t('views.creed.help.notifications.description')      
      end
      
      click_link I18n.t('views.creed.most_views.controls.cancel')
      
      current_url.should == @sub_host + creed_missions_path
      current_path.should == creed_missions_path
    end
        
    it "should allow me to register a new mission from the new mission form" do
      visit @sub_host + new_creed_mission_path
      
      fill_in 'mission_description', :with => 'A simple and not so large large description'
      
      click_button I18n.t('views.creed.new_mission.controls.save')
      
      page.should have_content I18n.t('views.common.messages.save.successful', :model => I18n.t('activerecord.models.mission'), :genre => "a")
      
      registered_mission = Mission.first
      
      current_url.should == @sub_host + creed_missions_path
      current_path.should == creed_missions_path
    
      within('.title-bar p') do
        page.should have_content I18n.t('activerecord.models.mission') 
        page.should have_content registered_mission.user.name
        page.should have_content I18n.l(registered_mission.updated_at, :format => :short)
      end
      
      page.should have_content registered_mission.description 
      
      find_link I18n.t('views.comments.controls.make_a_comment')
      
      find_button I18n.t('views.creed.show_mission.controls.edit')
      
      within(".help") do
        page.should have_content I18n.t('views.common.help.title')
        page.should have_content I18n.t('activerecord.models.mission')      
        page.should have_content I18n.t('views.creed.help.mission.description')    
        page.should have_content I18n.t('views.creed.help.notifications.title')      
        page.should have_content I18n.t('views.creed.help.notifications.description')      
        page.should have_content I18n.t('views.creed.help.notifications.description_extra')      
      end
    end
    
    it "should NOT allow me to register a new mission given I left the description field empty" do
      visit @sub_host + new_creed_mission_path
            
      click_button I18n.t('views.creed.new_mission.controls.save')
      
      current_url.should == @sub_host + creed_missions_path
      current_path.should == creed_missions_path
      
      page.should have_content I18n.t('views.creed.most_views.form_errors')
            
    end
    
  end
  
  describe "Given I have already registered a mission" do
    before(:each) do
      visit @sub_host + panorama_path
      @mission = Factory(:mission, :company => @user.company, :user => @user)
    end
    
    it "should show it to me instead of the index view shown when no mission is registered" do
      visit @sub_host + creed_missions_path
      
      find_link I18n.t('activerecord.models.vision')
      find_link I18n.t('activerecord.models.mission')
      find_link I18n.t('activerecord.models.war_cry')
      
      within('.title-bar p') do
        page.should have_content "#{I18n.t('activerecord.models.mission')}" 
        page.should have_content @mission.user.name
        page.should have_content I18n.l(@mission.updated_at, :format => :short)
      end
      
      page.should have_content @mission.description 
      
      find_link I18n.t('views.comments.controls.make_a_comment')
      
      find_button I18n.t('views.creed.show_mission.controls.edit')
    end
  
    it "should let me change it" do
      visit @sub_host + creed_missions_path

      click_button I18n.t('views.creed.show_mission.controls.edit')

      current_url.should == @sub_host + edit_creed_mission_path(@mission)
      current_path.should == edit_creed_mission_path(@mission)

      page.should have_content I18n.t('views.creed.edit_mission.title')
      page.should have_content I18n.t('views.creed.most_views.notify_to')

      find_field 'mission_description'
      page.should have_content I18n.t('views.creed.most_views.controls.all_selector') + @user.area.name
      find_field 'select_everyone'

      fill_in 'mission_description', :with => 'A simple yet not so large large description'
      
      # should show this user as him belongs to the same area
      #page.should have_content @user_in_area.name      
      #page.should have_selector(:xpath, "//input[@type='checkbox' and @name='users[#{@user_in_area.id}]']")
      
      click_button I18n.t('views.creed.edit_mission.controls.save')
      
      page.should have_content I18n.t('views.common.messages.update.successful', :model => I18n.t('activerecord.models.mission'), :genre => "a")
      
      current_url.should == @sub_host + creed_missions_path
      current_path.should == creed_missions_path
      
      page.should have_content 'A simple yet not so large large description'
      
    end
    
    it "should NOT let me change it if I leave the description field empty" do
      visit @sub_host + creed_missions_path
      
      click_button I18n.t('views.creed.show_mission.controls.edit')
      
      fill_in 'mission_description', :with => ''
      
      click_button I18n.t('views.creed.edit_mission.controls.save')
      
      current_url.should == @sub_host + creed_mission_path(Mission.first)
      current_path.should == creed_mission_path(Mission.first)
      
      page.should have_content I18n.t('views.creed.most_views.form_errors')
      
      page.should have_content I18n.t('views.creed.edit_mission.title')
      
    end
  
  end
  
  
end