require File.dirname(__FILE__) + '/acceptance_helper'
include Warden::Test::Helpers

feature "Creed section (War Cries):" do
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
    
    it "should take me to the war cry sub-section when I click the creed link menu item and then the war cry link" do
      click_link I18n.t('views.menu.creed')
      click_link I18n.t('activerecord.models.war_cry')
      
      current_url.should == @sub_host + creed_war_cries_path
      current_path.should == creed_war_cries_path
      
      find_link I18n.t('activerecord.models.vision')
      find_link I18n.t('activerecord.models.war_cry')
      
      page.should have_content I18n.t('views.creed.first_war_cry_description.title')
      page.should have_content ignoring_new_lines(I18n.t('views.creed.first_war_cry_description.description'))
      
      find_button I18n.t('views.creed.first_war_cry_description.controls.add_war_cry_description')
    end
  end
  
  describe "Given I have not yet registered a war cry" do
    before(:each) do
      visit @host + panorama_path
      @user_in_area=Factory.create(:user_no_company_name, :area => @user.area, :company => @user.company)
      @user_not_in_area = Factory.create(:user_no_company_name_other_area, :name => 'Fulano aquel', :company => @user.company)
    end
    
    it "should take me to the new war cry form when I click the add war cry button" do
      visit @sub_host + creed_war_cries_path
      click_button I18n.t('views.creed.first_war_cry_description.controls.add_war_cry_description')
      
      current_url.should == @sub_host + new_creed_war_cry_path
      current_path.should == new_creed_war_cry_path
   
      find_link I18n.t('views.creed.vision')
      find_link I18n.t('activerecord.models.war_cry')
      
      page.should have_content I18n.t('views.creed.new_war_cry_description.title')
      page.should have_content I18n.t('views.creed.most_views.notify_to')
      
      find_field 'war_cry_description'
      
      notifications_area_with(@user, {:notified => [@user_in_area], :unnotified => [@user_not_in_area]})
      
      find_link I18n.t('views.creed.most_views.controls.cancel')
      find_button I18n.t('views.creed.new_war_cry_description.controls.save')
      
      within(".help") do
        page.should have_content I18n.t('views.help.title')
        page.should have_content I18n.t('activerecord.models.war_cry')      
        page.should have_content I18n.t('views.creed.help.war_cry_description.description')    
        page.should have_content I18n.t('views.creed.help.notifications.title')      
        page.should have_content I18n.t('views.creed.help.notifications.description')      
      end
      
      click_link I18n.t('views.creed.most_views.controls.cancel')
      
      current_url.should == @sub_host + creed_war_cries_path
      current_path.should == creed_war_cries_path
    end
        
    it "should allow me to register a new war cry from the new war cry form" do
      visit @sub_host + new_creed_war_cry_path
      
      fill_in 'war_cry_description', :with => 'A simple and not so large large description'
      
      click_button I18n.t('views.creed.new_war_cry_description.controls.save')
      
      page.should have_content I18n.t('views.common.messages.save.successful', :model => I18n.t('activerecord.models.war_cry'), :genre => "o")
      
      registered_war_cry = WarCry.first
      
      current_url.should == @sub_host + creed_war_cries_path
      current_path.should == creed_war_cries_path
    
      within('.title-bar p') do
        page.should have_content I18n.t('activerecord.models.war_cry') 
        page.should have_content registered_war_cry.user.name
        page.should have_content I18n.l(registered_war_cry.updated_at, :format => :short)
      end
      
      page.should have_content registered_war_cry.description 
      
      find_link I18n.t('views.comments.controls.make_a_comment')
      
      find_button I18n.t('views.creed.show_war_cry_description.controls.edit')
      
      within(".help") do
        page.should have_content I18n.t('views.help.title')
        page.should have_content I18n.t('activerecord.models.war_cry')      
        page.should have_content I18n.t('views.creed.help.war_cry_description.description')    
        page.should have_content I18n.t('views.creed.help.notifications.title')      
        page.should have_content I18n.t('views.creed.help.notifications.description')      
        page.should have_content I18n.t('views.creed.help.notifications.description_extra')      
      end
    end
    
    it "should NOT allow me to register a new war cry given I left the description field empty" do
      visit @sub_host + new_creed_war_cry_path
            
      click_button I18n.t('views.creed.new_war_cry_description.controls.save')
      
      current_url.should == @sub_host + creed_war_cries_path
      current_path.should == creed_war_cries_path
      
      page.should have_content I18n.t('views.creed.most_views.form_errors')
            
    end
    
  end
  
  describe "Given I have already registered a war cry" do
    before(:each) do
      visit @sub_host + panorama_path
      @war_cry_description = Factory(:war_cry, :company => @user.company, :user => @user)
    end
    
    it "should show it to me instead of the index view shown when no war cry is registered" do
      visit @sub_host + creed_war_cries_path
      
      find_link I18n.t('activerecord.models.war_cry')
      
      within('.title-bar p') do
        page.should have_content "#{I18n.t('activerecord.models.war_cry')}" 
        page.should have_content @war_cry_description.user.name
        page.should have_content I18n.l(@war_cry_description.updated_at, :format => :short)
      end
      
      page.should have_content @war_cry_description.description 
      
      find_link I18n.t('views.comments.controls.make_a_comment')
      
      find_button I18n.t('views.creed.show_war_cry_description.controls.edit')
    end
  
    it "should let me change it" do
      visit @sub_host + creed_war_cries_path

      click_button I18n.t('views.creed.show_war_cry_description.controls.edit')

      current_url.should == @sub_host + edit_creed_war_cry_path(@war_cry_description)
      current_path.should == edit_creed_war_cry_path(@war_cry_description)

      page.should have_content I18n.t('views.creed.edit_war_cry_description.title')
      page.should have_content I18n.t('views.creed.most_views.notify_to')

      find_field 'war_cry_description'
      page.should have_content I18n.t('views.creed.most_views.controls.all_selector') + @user.area.name
      find_field 'select_everyone'

      fill_in 'war_cry_description', :with => 'A simple yet not so large large description'
      
      # should show this user as him belongs to the same area
      #page.should have_content @user_in_area.name      
      #page.should have_selector(:xpath, "//input[@type='checkbox' and @name='users[#{@user_in_area.id}]']")
      
      click_button I18n.t('views.creed.edit_war_cry_description.controls.save')
      
      page.should have_content I18n.t('views.common.messages.update.successful', :model => I18n.t('activerecord.models.war_cry'), :genre => "o")
      
      current_url.should == @sub_host + creed_war_cries_path
      current_path.should == creed_war_cries_path
      
      page.should have_content 'A simple yet not so large large description'
      
    end
    
    it "should NOT let me change it if I leave the description field empty" do
      visit @sub_host + creed_war_cries_path
      
      click_button I18n.t('views.creed.show_war_cry_description.controls.edit')
      
      fill_in 'war_cry_description', :with => ''
      
      click_button I18n.t('views.creed.edit_war_cry_description.controls.save')
      
      current_url.should == @sub_host + creed_war_cry_path(WarCry.first)
      current_path.should == creed_war_cry_path(WarCry.first)
      
      page.should have_content I18n.t('views.creed.most_views.form_errors')
      
      page.should have_content I18n.t('views.creed.edit_war_cry_description.title')
      
    end
  
  end
  
  
end