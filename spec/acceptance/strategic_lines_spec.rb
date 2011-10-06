#encoding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'
require "#{File.dirname(__FILE__)}/support/strategic_lines_helpers.rb"

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

  describe "Given I am on the landing page" do
    
    before(:each) do
      visit @sub_host + panorama_path
    end
    
    describe "and there is no strategic line registered" do
      
      it "should show me the first section welcome page when clicking 'Strategic Lines' on main menu" do
        
        click_link I18n.t('views.menu.strategic_lines')
        should_have_initial_welcome_page_contents
        
      end
      
      it "should send me to the new strategic line form after clicking the add new button" do
        click_link I18n.t('views.menu.strategic_lines')
        
        click_on I18n.t('views.strategic_lines.index.empty.controls.start')
        
        current_url.should == @sub_host + new_strategic_line_path
        current_path.should == new_strategic_line_path
      end
      
    end
    
    describe "and there is one strategic line registered" do
      
      before(:each) do
        @sl = Factory(:strategic_line, :company => @user.company, :user => @user)
        click_link I18n.t('views.menu.strategic_lines')
      end
      
      it "should show me the first section page with one strategic line when clicking 'Strategic Lines' on main menu" do
        
        within(".title-bar") do
          page.should have_content I18n.t('views.menu.strategic_lines')
        end

        within(".inside-box") do
          within("#sl-#{@sl.id}") do
            page.should have_content @sl.content
            should_contain_record_info_for(@sl)
            should_contain_record_links_with editability_set_to(true), and_no_comments
          end
          
          find_link I18n.t('views.strategic_lines.index.not_empty.controls.add')
          
        end
        

        within(".help") do
          page.should have_content I18n.t('views.help.title')
        end
        
      end
      
      it "should let me destroy the registered strategic line" do
        
        within("#sl-#{@sl.id}") do
          find(:xpath, "//input[contains(@class, 'delete')]").click
        end
        
        page.driver.browser.switch_to.alert.accept
        should_have_initial_welcome_page_contents
        
      end
      
      it "should let me edit the registered strategic line" do
        
        within("#sl-#{@sl.id}") do
          find(:xpath, "//a[contains(@class, 'modify')]").click
        end
        
        current_url.should == @sub_host + edit_strategic_line_path(@sl)
        current_path.should == edit_strategic_line_path(@sl)
        
        page.should have_content I18n.t('views.strategic_lines.edit.title')
        
        fill_in 'strategic_line_content', :with => 'Optimizar el uso de los recursos'
        page.should have_content I18n.t('views.strategic_lines.edit.last_updated')
        
        should_contain_record_info_for(@sl)
        click_on I18n.t('views.strategic_lines.edit.controls.save')
        
        current_url.should == @sub_host + strategic_lines_path
        current_path.should == strategic_lines_path
        
        page.should have_content I18n.t('views.common.messages.update.successful', :model => "Líneas Estratégicas", :genre => "as")
        updated_strategic_line = StrategicLine.first
        
        within("#sl-#{updated_strategic_line.id}") do
          page.should have_content 'Optimizar el uso de los recursos'
          should_contain_record_info_for(updated_strategic_line)
            
          should_contain_record_links_with editability_set_to(true), and_no_comments
        end
        
      end
      
      it "should NOT let me edit the registered strategic line if invalid data is provided" do
        
        within("#sl-#{@sl.id}") do
          find(:xpath, "//a[contains(@class, 'modify')]").click
        end
        
        current_url.should == @sub_host + edit_strategic_line_path(@sl)
        current_path.should == edit_strategic_line_path(@sl)
        
        page.should have_content I18n.t('views.strategic_lines.edit.title')
        
        fill_in 'strategic_line_content', :with => ''
        page.should have_content I18n.t('views.strategic_lines.edit.last_updated')
        
        should_contain_record_info_for(@sl)
        click_on I18n.t('views.strategic_lines.edit.controls.save')
        
        page.should_not have_content I18n.t('views.common.messages.update.successful', :model => "Líneas Estratégicas", :genre => "as")
        
        page.evaluate_script("$('.errors').is(':empty');").should be_false
        
      end
      
      describe "with people to be notified" do
      
        before(:each) do
          @user_in_area=Factory.create(:user_no_company_name, :area => @user.area, :company => @user.company)
          @user_not_in_area = Factory.create(:user_no_company_name_other_area, :name => 'Fulano aquel', :company => @user.company)
        end
      
        it "should show me the add new strategic line form and let me go back" do
          
          click_link I18n.t('views.strategic_lines.index.not_empty.controls.add')
          
          current_url.should == @sub_host + new_strategic_line_path
          current_path.should == new_strategic_line_path
          
          page.should have_content I18n.t('views.strategic_lines.new.title')
          
          notifications_area_with(@user, {:notified => [@user_in_area], :unnotified => [@user_not_in_area]})
          
          click_link I18n.t('views.strategic_lines.new.controls.cancel')
          
          current_url.should == @sub_host + strategic_lines_path
          current_path.should == strategic_lines_path
          
        end
      
        it "should let me add a new strategic line after clicking the add button and having provided valid data" do
      
          click_link I18n.t('views.strategic_lines.index.not_empty.controls.add')
          page.should have_content I18n.t('views.strategic_lines.new.title')
          
          notifications_area_with(@user, {:notified => [@user_in_area], :unnotified => [@user_not_in_area]})
          
          fill_in 'strategic_line_content', :with => 'Optimizar el uso de los recursos (humanos, financieros y materiales)'
          
          find_link I18n.t('views.strategic_lines.new.controls.cancel')
          click_on I18n.t('views.strategic_lines.new.controls.save')
          
          current_url.should == @sub_host + strategic_lines_path
          current_path.should == strategic_lines_path
          
          page.should have_content I18n.t('views.common.messages.save.successful', :model => "Líneas Estratégicas", :genre => "as")
          new_strategic_line = StrategicLine.last
          
          within("#sl-#{new_strategic_line.id}") do
            page.should have_content new_strategic_line.content
            should_contain_record_info_for(new_strategic_line)  
            should_contain_record_links_with editability_set_to(true), and_no_comments
          end
          
        end
        
        it "should NOT let me add a new strategic line after clicking the save button and having provided non-valid data" do
      
          click_link I18n.t('views.strategic_lines.index.not_empty.controls.add')
          page.should have_content I18n.t('views.strategic_lines.new.title')
          
          notifications_area_with(@user, {:notified => [@user_in_area], :unnotified => [@user_not_in_area]})
          
          fill_in 'strategic_line_content', :with => ''
          
          find_link I18n.t('views.strategic_lines.new.controls.cancel')
          click_on I18n.t('views.strategic_lines.new.controls.save')
          
          current_url.should == @sub_host + strategic_lines_path
          current_path.should == strategic_lines_path

          page.should_not have_content I18n.t('views.common.messages.save.successful', :model => "Líneas Estratégicas", :genre => "as")

          page.evaluate_script("$('.errors').is(':empty');").should be_false
          
        end
      end
    end
    
  end

end
