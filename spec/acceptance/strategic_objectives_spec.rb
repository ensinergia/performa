#encoding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'
require "#{File.dirname(__FILE__)}/support/strategic_objectives_helpers.rb"

include Warden::Test::Helpers

feature "Strategic Objectives:", :js => true do
  before(:each) do        
    @host = "http://lvh.me:#{Capybara.server_port}"
    @user = Factory(:user)
    
    @sub_host = @host.gsub('lvh.me', "#{@user.subdomain}.lvh.me")
    
    Capybara.app_host = @sub_host
    Capybara.default_host = @sub_host

    login_as(@user)
  end

  describe "Given I am on the landing page" do
    
    before(:each) do
      visit @sub_host + panorama_path
    end
    
    describe "and there is no strategic objective registered" do
      
      it "should show me the first section welcome page when clicking 'Strategic Objectives' on main menu" do
        
        click_link I18n.t('views.menu.objectives')
        should_have_initial_welcome_page_contents
        
      end
      
      it "should send me to the new strategic objective form after clicking the add new button" do
        click_link I18n.t('views.menu.objectives')
        
        click_on I18n.t('views.strategic_objectives.index.empty.controls.start')
        
        current_url.should == @sub_host + new_strategic_objective_path
        current_path.should == new_strategic_objective_path
      end
      
    end
    
    describe "and there is one strategic objective registered" do
      
      before(:each) do
        @sl = Factory(:strategic_objective, :company => @user.company, :user => @user)
        click_link I18n.t('views.menu.objectives')
      end
      
      it "should show me the first section page with one strategic objective when clicking 'Strategic objectives' on main menu" do
        
        within(".inside-box") do
          page.should have_content I18n.t('views.menu.objectives')
        
          within("#sl-#{@sl.id}") do
            page.should have_content @sl.content
            should_contain_record_info_for(@sl)
            should_contain_record_links_with editability_set_to(true), and_no_comments
          end
          
          find_link I18n.t('views.strategic_objectives.index.not_empty.controls.add')
          
        end
        

        within(".help") do
          page.should have_content I18n.t('views.common.help.title')
          page.should have_content I18n.t('views.menu.objectives')
        end
        
      end
      
      it "should let me destroy the registered strategic objective" do
        
        within("#sl-#{@sl.id}") do
          find(:xpath, "//input[contains(@class, 'delete')]").click
        end
        
        page.driver.browser.switch_to.alert.accept
        should_have_initial_welcome_page_contents
        
      end
      
      it "should let me edit the registered strategic objective" do
        
        within("#sl-#{@sl.id}") do
          find(:xpath, "//a[contains(@class, 'modify')]").click
        end
        
        current_url.should == @sub_host + edit_strategic_objective_path(@sl)
        current_path.should == edit_strategic_objective_path(@sl)
        
        page.should have_content I18n.t('views.strategic_objectives.edit.title')
        
        fill_in 'strategic_objective_content', :with => 'Optimizar el uso de los recursos'
        page.should have_content I18n.t('views.strategic_objectives.edit.last_updated')
        
        should_contain_record_info_for(@sl)
        click_on I18n.t('views.strategic_objectives.edit.controls.save')
        
        current_url.should == @sub_host + strategic_objectives_path
        current_path.should == strategic_objectives_path
        
        page.should have_content I18n.t('views.common.messages.update.successful', :model => "Objetivos Estratégicos", :genre => "o")
        updated_strategic_objective = StrategicObjective.first
        
        within("#sl-#{updated_strategic_objective.id}") do
          page.should have_content 'Optimizar el uso de los recursos'
          should_contain_record_info_for(updated_strategic_objective)
            
          should_contain_record_links_with editability_set_to(true), and_no_comments
        end
        
      end
      
      it "should NOT let me edit the registered strategic objective if invalid data is provided" do
        
        within("#sl-#{@sl.id}") do
          find(:xpath, "//a[contains(@class, 'modify')]").click
        end
        
        current_url.should == @sub_host + edit_strategic_objective_path(@sl)
        current_path.should == edit_strategic_objective_path(@sl)
        
        page.should have_content I18n.t('views.strategic_objectives.edit.title')
        
        fill_in 'strategic_objective_content', :with => ''
        page.should have_content I18n.t('views.strategic_objectives.edit.last_updated')
        
        should_contain_record_info_for(@sl)
        click_on I18n.t('views.strategic_objectives.edit.controls.save')
        
        page.should_not have_content I18n.t('views.common.messages.update.successful', :model => "Objetivos Estratégicas", :genre => "o")
        
        page.evaluate_script("$('.errors').is(':empty');").should be_false
        
      end
      
      describe "with people to be notified" do
      
        before(:each) do
          @user_in_area=Factory.create(:user_no_company_name, :area => @user.area, :company => @user.company)
          @user_not_in_area = Factory.create(:user_no_company_name_other_area, :name => 'Fulano aquel', :company => @user.company)
        end
      
        it "should show me the add new strategic objective form and let me go back" do
          
          click_link I18n.t('views.strategic_objectives.index.not_empty.controls.add')
          
          current_url.should == @sub_host + new_strategic_objective_path
          current_path.should == new_strategic_objective_path
          
          page.should have_content I18n.t('views.strategic_objectives.new.title')
          
          notifications_area_with(@user, {:notified => [@user_in_area], :unnotified => [@user_not_in_area]})
          
          click_link I18n.t('views.strategic_objectives.new.controls.cancel')
          
          current_url.should == @sub_host + strategic_objectives_path
          current_path.should == strategic_objectives_path
          
        end
      
        it "should let me add a new strategic objective after clicking the add button and having provided valid data" do
      
          click_link I18n.t('views.strategic_objectives.index.not_empty.controls.add')
          page.should have_content I18n.t('views.strategic_objectives.new.title')
          
          notifications_area_with(@user, {:notified => [@user_in_area], :unnotified => [@user_not_in_area]})
          
          fill_in 'strategic_objective_content', :with => 'Optimizar el uso de los recursos (humanos, financieros y materiales)'
          
          find_link I18n.t('views.strategic_objectives.new.controls.cancel')
          click_on I18n.t('views.strategic_objectives.new.controls.save')
          
          current_url.should == @sub_host + strategic_objectives_path
          current_path.should == strategic_objectives_path
          
          page.should have_content I18n.t('views.common.messages.save.successful', :model => "Objectivos Estratégicos", :genre => "o")
          new_strategic_objective = StrategicObjective.last
          
          within("#sl-#{new_strategic_objective.id}") do
            page.should have_content new_strategic_objective.content
            should_contain_record_info_for(new_strategic_objective)
            should_contain_record_links_with editability_set_to(true), and_no_comments
          end
          
        end
        
        it "should NOT let me add a new strategic objective after clicking the save button and having provided non-valid data" do
      
          click_link I18n.t('views.strategic_objectives.index.not_empty.controls.add')
          page.should have_content I18n.t('views.strategic_objectives.new.title')
          
          notifications_area_with(@user, {:notified => [@user_in_area], :unnotified => [@user_not_in_area]})
          
          fill_in 'strategic_objective_content', :with => ''
          
          find_link I18n.t('views.strategic_objectives.new.controls.cancel')
          click_on I18n.t('views.strategic_objectives.new.controls.save')
          
          current_url.should == @sub_host + strategic_objectives_path
          current_path.should == strategic_objectives_path

          page.should_not have_content I18n.t('views.common.messages.save.successful', :model => "Objetivos Estratégicas", :genre => "o")

          page.evaluate_script("$('.errors').is(':empty');").should be_false
          
        end
      end
    end
    
  end

end
