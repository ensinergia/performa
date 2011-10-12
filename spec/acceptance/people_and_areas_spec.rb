#encoding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'
require "#{File.dirname(__FILE__)}/support/swot_helpers.rb"
require "#{File.dirname(__FILE__)}/support/people_helpers.rb"

include Warden::Test::Helpers

feature "PEOPLE AND AREAS features:" do
  before(:each) do    
    @host = "http://lvh.me:#{Capybara.server_port}"
    Capybara.app_host = @host
    @user = Factory(:user, :role => Factory(:role_admin))
    @sub_host = @host.gsub('lvh.me', "#{@user.subdomain}.lvh.me")
    login_as(@user)    
  end
  
  it "should be possible to visit the people area from the main page" do
    visit @sub_host + panorama_path
    
    click_link I18n.t('views.menu.people')
    
    current_url.should == @sub_host + people_path
    current_path.should == people_path
  end
  
  describe "Given there are no registered areas" do
  
    it "should show the welcome page" do
      #visit @sub_host + people_path
      
      #page.should have_content I18n.t('views.people.empty.title')
      
      #find_link I18n.t('views.people.empty.controls.add')
    end
    
  end
      
  it "should allow to visit the people administration area" do
    visit @sub_host + people_path
    
    click_link I18n.t('views.area.index.controls.admin_list')
    
    current_url.should == @sub_host + areas_admin_path
    current_path.should == areas_admin_path
    
    page.should have_content I18n.t('views.people.non_empty.title', :company => @user.area.company.name)
    page.should have_content I18n.t('views.people.admin.title')
    find_link I18n.t('views.people.non_empty.controls.add_area')
    
    find_link I18n.t('views.people.admin.controls.close')
    page.should have_content I18n.t('views.people.admin.title')
    page.should have_content I18n.t('views.people.admin.note')
    
    within(".is-admin") do
      page.should have_content @user.name
    end
    
    find_link I18n.t('views.people.admin.controls.cancel')
    find_button I18n.t('views.people.admin.controls.save')
  end
  
  describe "Given a registered additional user" do
    
    before(:each) do
      role_user=Factory(:role_user)
      @user_one = Factory(:user_no_company_name_other_area, :name => "Felix", :company => @user.company, :role => role_user)
    end
    
    it "should allow me to change it's permissions to admin", :js => true do
      visit @sub_host + areas_admin_path
      
      select('admin', :from => "users_#{@user_one.id}")
      select("user", :from => "users_#{@user.id}")
      click_on I18n.t('views.people.admin.controls.save')
      
      current_url.should == @sub_host + areas_admin_path
      current_path.should == areas_admin_path
      
      page.should have_content I18n.t('views.people.admin.messages.successful_update')
      
      within(".is-not-admin") do
        page.should have_content @user.name
      end
  
      within(".is-admin") do
        page.should have_content @user_one.name
      end

    end
    
    it "should allow me to return from admin page" do
      visit @sub_host + areas_admin_path
      
     click_link I18n.t('views.people.admin.controls.cancel')

     current_url.should == @sub_host + people_path
     current_path.should == people_path

     visit @sub_host + areas_admin_path

     click_link I18n.t('views.people.admin.controls.close')

     current_url.should == @sub_host + people_path
     current_path.should == people_path
    end
  
    it "should NOT allow to register a new area if I provided invalid attributes", :js => true do
      visit @sub_host + people_path
    
      click_link I18n.t('views.people.non_empty.controls.add_area')
      page.should have_content I18n.t('views.people.non_empty.title', :company => @user.area.company.name)
    
      page.should have_content I18n.t('views.area.new.title')
    
      page.should have_content I18n.t('views.area.shared.functions')
    
      click_link I18n.t('views.area.new.controls.add_function')
    
      within(:xpath, '(.//div[@class="fields"])[1]') do
        fill_in('function-content', :with => 'Una muy buena función')
      end
    
      click_on I18n.t('views.area.new.controls.save')
    
      page.evaluate_script("$('.errors').is(':empty');").should be_false
      page.should_not have_content I18n.t('views.common.messages.save.successful', :model => "Área", :genre => "a")
    
    end
  
    it "should allow to register a new area if I provided valid attributes", :js => true do
      visit @sub_host + people_path
    
      click_link I18n.t('views.people.non_empty.controls.add_area')
      page.should have_content I18n.t('views.people.non_empty.title', :company => @user.area.company.name)
    
      page.should have_content I18n.t('views.area.new.title')
      fill_in("area_name", :with => "An area name")
    
      select('Felix', :from => 'area_user_id')
  
      page.should have_content I18n.t('views.area.shared.functions')
    
      click_link I18n.t('views.area.new.controls.add_function')
    
      within(:xpath, '(.//div[@class="fields"])[1]') do
        fill_in('function-content', :with => 'Una muy buena función')
      end
    
      click_on I18n.t('views.area.new.controls.save')
    
      page.should have_content I18n.t('views.common.messages.save.successful', :model => "Área", :genre => "a")
    
      current_url.should == @sub_host + people_path
      current_path.should == people_path
    
      within("#area-#{Area.last.id}") do
        page.should have_content Area.last.name
        find(:xpath, "//a[contains(@class, 'modify')]")
        find(:xpath, "//a[contains(@class, 'add')]")
      end
      page.should have_content 'Felix'
    end
  
    it "should allow me to cancel the registration and return to the people and areas listing" do
      visit @sub_host + people_path
    
      click_link I18n.t('views.people.non_empty.controls.add_area')
      page.should have_content I18n.t('views.people.non_empty.title', :company => @user.area.company.name)

      current_url.should == @sub_host + new_area_path
      current_path.should == new_area_path      
    
      click_link I18n.t('views.area.shared.controls.cancel')
    
      visit @sub_host + people_path
    end
  
    describe "together with some other areas" do
    
      before(:each) do        
        @area_one = Factory(:area, :name => "One", :company => @user.area.company, :user => @user)
        @area_two = Factory(:area, :name => "Two", :company => @user.area.company, :user => @user)
      end
    
      it "should show a page with the registered areas and it's users", :js => true do
        visit @sub_host + people_path

        page.should have_content I18n.t('views.people.non_empty.title', :company => @user.area.company.name)

        find_link I18n.t('views.people.non_empty.controls.add_area')
      
        within("#area-#{@user.area.id}") do
          page.should have_content @user.area.name
          find(:xpath, "//a[contains(@class, 'modify')]")
          find_link I18n.t('views.area.index.controls.admin_list')
        
          within("#person-#{@user.id}") do
            should_have_person_view_with(:name => @user.name, :email => @user.email, :position => Position.owner)
          end
          find(:xpath, "//a[contains(@class, 'add')]")
        end
      
      
        within("#area-#{@area_one.id}") do
          page.should have_content @area_one.name
          find(:xpath, "//a[contains(@class, 'modify')]")
          page.should have_no_content I18n.t('views.area.index.controls.admin_list')
        
          page.should have_no_css("#person-#{@user.id}")
          find(:xpath, "//a[contains(@class, 'add')]")
        end
      
        within("#area-#{@area_two.id}") do
          page.should have_content @area_two.name
          find(:xpath, "//a[contains(@class, 'modify')]")
          page.should have_no_content I18n.t('views.area.index.controls.admin_list')
        
          page.should have_no_css("#person-#{@user.id}")
          find(:xpath, "//a[contains(@class, 'add')]")
        end

        within(".help") do
          page.should have_content I18n.t('views.help.title')
        end

      end
    
      describe "given area has a function defined" do
    
        before(:each) do
          @area_one.update_attribute(:functions, [Factory(:function, :content => "A predefined function")])
        end
    
        it "should let me edit an existent area", :js => true do
    
          visit @sub_host + people_path
    
          within("#area-#{@area_one.id}") do
            click_link('modify')
          end
      
          page.should have_content I18n.t('views.area.edit.title', :area => @area_one.name)
      
          select('Felix', :from => 'area_user_id')
      
          fill_in("area_name", :with => "Main Direction")
      
          within(:xpath, '(.//div[@class="fields"])[1]') do
            fill_in('function-content', :with => 'A redefinition of function')
          end

          click_on I18n.t('views.area.edit.controls.save')
      
          current_url.should == @sub_host + people_path
          current_path.should == people_path
      
        end
      end
    end
  end
  
end
