#encoding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'
require "#{File.dirname(__FILE__)}/support/swot_helpers.rb"
require "#{File.dirname(__FILE__)}/support/people_helpers.rb"

include Warden::Test::Helpers

feature "PEOPLE AND AREAS features:" do
  before(:each) do    
    @host = "http://lvh.me:#{Capybara.server_port}"
    Capybara.app_host = @host
    @user = Factory(:user, :position => Factory(:position, :name => "Director"))
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
  
  describe "Given there is an area registered" do
    
    before(:each) do
      @area=Factory(:area, :name => "Direction", :company_id => @user.company.id)
    end
    
    it "should show a page with the registered areas and it's users" do
      visit @sub_host + people_path
      
      page.should have_content I18n.t('views.people.non_empty.title', :company => @area.company.name)
      
      find_link I18n.t('views.people.non_empty.controls.add_area')

      within("#area-#{@user.area.id}") do
        page.should have_content @user.area.name
        find(:xpath, "//a[contains(@class, 'modify')]")

        within("#person-#{@user.id}") do
          should_have_person_view_with(:name => @user.name, :email => @user.email, :position => @user.position.name)
        end
        find(:xpath, "//a[contains(@class, 'add')]")
      end
      
      find(:css, "#area-#{@area.id}")
      
      within(".help") do
        page.should have_content I18n.t('views.help.title')
      end
      
    end
    
    it "should NOT allow to register a new area if I provided invalid attributes", :js => true do
      visit @sub_host + people_path
      
      click_link I18n.t('views.people.non_empty.controls.add_area')
      page.should have_content I18n.t('views.people.non_empty.title', :company => @area.company.name)
      
      page.should have_content I18n.t('views.people.new.title')
      
      page.should have_content I18n.t('views.people.new.functions')
      
      click_link I18n.t('views.people.new.controls.add_function')
      
      within(:xpath, '(.//div[@class="fields"])[1]') do
        fill_in('function-content', :with => 'Una muy buena función')
      end
      
      click_on I18n.t('views.people.new.controls.save')
      
      page.evaluate_script("$('.errors').is(':empty');").should be_false
      page.should_not have_content I18n.t('views.common.messages.save.successful', :model => "Área", :genre => "a")
      
    end
    
    it "should allow to register a new area if I provided valid attributes", :js => true do
      visit @sub_host + people_path
      
      click_link I18n.t('views.people.non_empty.controls.add_area')
      page.should have_content I18n.t('views.people.non_empty.title', :company => @area.company.name)
      
      page.should have_content I18n.t('views.people.new.title')
      fill_in("area_name", :with => "An area name")
      
      page.should have_content I18n.t('views.people.new.functions')
      
      click_link I18n.t('views.people.new.controls.add_function')
      
      within(:xpath, '(.//div[@class="fields"])[1]') do
        fill_in('function-content', :with => 'Una muy buena función')
      end
      
      click_on I18n.t('views.people.new.controls.save')
      
      page.should have_content I18n.t('views.common.messages.save.successful', :model => "Área", :genre => "a")
      
      current_url.should == @sub_host + people_path
      current_path.should == people_path
      
      within("#area-#{Area.last.id}") do
        page.should have_content Area.last.name
        find(:xpath, "//a[contains(@class, 'modify')]")

        find(:xpath, "//a[contains(@class, 'add')]")
      end
    end
    
  end
  
end
