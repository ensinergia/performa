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
    
    it "should take me to the vision sub-section when I click the creed link menu item" do
      click_link I18n.t('views.menu.creed')
      current_url.should == @sub_host + creed_visions_path
      current_path.should == creed_visions_path
      
      find_link I18n.t('views.creed.vision')
      find_link I18n.t('views.creed.mission')
      find_link I18n.t('views.creed.battle_cry')
      
      page.should have_content I18n.t('views.creed.first_view.title')
      page.should have_content I18n.t('views.creed.first_view.description')
      
      find_button I18n.t('views.creed.first_view.controls.add_vision')
    end
  end
  
  describe "Given I have not yet registered a vision" do
    before(:each) do
      visit @host + panorama_path
      @user_in_area=Factory.create(:user_no_company_name, :area => @user.area, :company => @user.company)
      @user_not_in_area = Factory.create(:user_no_company_name_other_area, :name => 'Fulano aquel', :company => @user.company)
    end
    
    it "should take me to the new vision form when I click the add vision button" do
      visit @sub_host + creed_visions_path
      click_button I18n.t('views.creed.first_view.controls.add_vision')
      
      current_url.should == @sub_host + new_creed_vision_path
      current_path.should == new_creed_vision_path
   
      find_link I18n.t('views.creed.vision')
      find_link I18n.t('views.creed.mission')
      find_link I18n.t('views.creed.battle_cry')
      
      page.should have_content I18n.t('views.creed.new_vision.title')
      page.should have_content I18n.t('views.creed.most_views.notify_to')
      
      find_field 'vision_description'
      
      notifications_area_with(@user, {:notified => [@user_in_area], :unnotified => [@user_not_in_area]})
      
      find_link I18n.t('views.creed.most_views.controls.cancel')
      find_button I18n.t('views.creed.new_vision.controls.save')
      
      within(".help") do
        page.should have_content I18n.t('views.common.help.title')
        page.should have_content I18n.t('views.creed.vision')      
        page.should have_content I18n.t('views.creed.help.vision.description')    
        page.should have_content I18n.t('views.creed.help.notifications.title')      
        page.should have_content I18n.t('views.creed.help.notifications.description')      
      end
      
      click_link I18n.t('views.creed.most_views.controls.cancel')
      
      current_url.should == @sub_host + creed_visions_path
      current_path.should == creed_visions_path
    end
        
    it "should allow me to register a new vision from the new vision form" do
      visit @sub_host + new_creed_vision_path
      
      fill_in 'vision_description', :with => 'A simple and not so large large description'
      
      click_button I18n.t('views.creed.new_vision.controls.save')
      
      page.should have_content I18n.t('views.creed.create_vision.successful_save')
      
      registered_vision = Vision.first
      
      current_url.should == @sub_host + creed_visions_path
      current_path.should == creed_visions_path
    
      within('.title-bar p') do
        page.should have_content I18n.t('views.creed.vision') 
        page.should have_content registered_vision.user.name
        page.should have_content I18n.l(registered_vision.updated_at, :format => :short)
      end
      
      page.should have_content registered_vision.description 
      
      find_link I18n.t('views.comments.controls.make_a_comment')
      
      find_button I18n.t('views.creed.show_vision.controls.edit')
      
      within(".help") do
        page.should have_content I18n.t('views.common.help.title')
        page.should have_content I18n.t('views.creed.vision')      
        page.should have_content I18n.t('views.creed.help.vision.description')    
        page.should have_content I18n.t('views.creed.help.notifications.title')      
        page.should have_content I18n.t('views.creed.help.notifications.description')      
        page.should have_content I18n.t('views.creed.help.notifications.description_extra')      
      end
    end
    
    it "should NOT allow me to register a new vision given I left the description field empty" do
      visit @sub_host + new_creed_vision_path
            
      click_button I18n.t('views.creed.new_vision.controls.save')
      
      current_url.should == @sub_host + creed_visions_path
      current_path.should == creed_visions_path
      
      page.should have_content I18n.t('views.creed.most_views.form_errors')
            
    end
    
  end
  
  describe "Given I have already registered a vision" do
    before(:each) do
      visit @sub_host + panorama_path
      @vision = Factory(:vision, :company => @user.company, :user => @user)
    end
    
    it "should show it to me instead of the index view shown when no vision is registered" do
      visit @sub_host + creed_visions_path
      
      find_link I18n.t('views.creed.vision')
      find_link I18n.t('views.creed.mission')
      find_link I18n.t('views.creed.battle_cry')
      
      within('.title-bar p') do
        page.should have_content "#{I18n.t('views.creed.vision')}" 
        page.should have_content @vision.user.name
        page.should have_content I18n.l(@vision.updated_at, :format => :short)
      end
      
      page.should have_content @vision.description 
      
      find_link I18n.t('views.comments.controls.make_a_comment')
      
      find_button I18n.t('views.creed.show_vision.controls.edit')
    end
  
    it "should let me change it" do
      visit @sub_host + creed_visions_path

      click_button I18n.t('views.creed.show_vision.controls.edit')

      current_url.should == @sub_host + edit_creed_vision_path(@vision)
      current_path.should == edit_creed_vision_path(@vision)

      page.should have_content I18n.t('views.creed.edit_vision.title')
      page.should have_content I18n.t('views.creed.most_views.notify_to')

      find_field 'vision_description'
      page.should have_content I18n.t('views.creed.most_views.controls.all_selector') + @user.area.name
      find_field 'select_everyone'

      fill_in 'vision_description', :with => 'A simple yet not so large large description'
      
      # should show this user as him belongs to the same area
      #page.should have_content @user_in_area.name      
      #page.should have_selector(:xpath, "//input[@type='checkbox' and @name='users[#{@user_in_area.id}]']")
      
      click_button I18n.t('views.creed.edit_vision.controls.save')
      
      page.should have_content I18n.t('views.creed.update_vision.successful_save')
      
      current_url.should == @sub_host + creed_visions_path
      current_path.should == creed_visions_path
      
      page.should have_content 'A simple yet not so large large description'
      
    end
    
    it "should NOT let me change it if I leave the description field empty" do
      visit @sub_host + creed_visions_path
      
      click_button I18n.t('views.creed.show_vision.controls.edit')
      
      fill_in 'vision_description', :with => ''
      
      click_button I18n.t('views.creed.edit_vision.controls.save')
      
      current_url.should == @sub_host + creed_vision_path(Vision.first)
      current_path.should == creed_vision_path(Vision.first)
      
      page.should have_content I18n.t('views.creed.most_views.form_errors')
      
      page.should have_content I18n.t('views.creed.edit_vision.title')
      
      page.should have_content I18n.t('views.creed.most_views.form_errors')
    end
  
  end
  
  
end