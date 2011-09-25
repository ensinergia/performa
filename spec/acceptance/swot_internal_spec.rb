#encoding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'
require "#{File.dirname(__FILE__)}/support/swot_helpers.rb"

include Warden::Test::Helpers

feature "SWOT internal features" do
  before(:each) do    
    @host = "http://lvh.me:#{Capybara.server_port}"
    Capybara.app_host = @host
    @user = Factory(:user)
    @sub_host = @host.gsub('lvh.me', "#{@user.subdomain}.lvh.me")
    login_as(@user)    
  end
  
  
  describe "Given I am on the landing page" do
    
    before(:each) do
      visit @sub_host + panorama_path
    end
    
    describe "and no SWOT record is registered" do
    
      before(:each) do
        click_link I18n.t('views.menu.swot')
      end
    
      it "should show me the welcome SWOT page" do
      
        current_url.should == @sub_host + swot_analyses_path
        current_path.should == swot_analyses_path
      
        find_link I18n.t('views.swot.internals.title')
        find_link I18n.t('views.swot.externals.title')
      
        page.should have_content I18n.t('views.swot.first_view.title')
        page.should have_content I18n.t('views.swot.first_view.description')
      
        find_link I18n.t('views.swot.first_view.controls.start')
      end
      
      it "should send me to the internal analyses page when I click the start button" do
        click_on I18n.t('views.swot.first_view.controls.start')
        
        current_url.should == @sub_host + internal_swot_analyses_path
        current_path.should == internal_swot_analyses_path
      end
      
    end
    
    describe "and one weakness is registered" do
      
      before(:each) do
        @weakness = Factory(:weakness, 
                            :swot => Factory(:swot, :company => @user.company), 
                            :user => @user)
      end
      
      it "should show me to SWOT page with one weakness and no strengths" do
        click_link I18n.t('views.menu.swot')
        
        current_url.should == @sub_host + swot_analyses_path
        current_path.should == swot_analyses_path
        
        find_link I18n.t('views.swot.internals.title')
        find_link I18n.t('views.swot.externals.title')
        
        within(".weaknesses") do
          page.should have_content I18n.t('views.swot.shared_views.weaknesses')
          should_have_analysis_record_for(@weakness)
          find_link I18n.t('views.swot.shared_views.controls.add_weakness')
        end
        
        within(".strengths") do
          page.should have_content I18n.t('views.swot.shared_views.strengths')
          find_link I18n.t('views.swot.shared_views.controls.add_strength')
        end
        
        within(".help") do
          page.should have_content I18n.t('views.common.help.title')
          page.should have_content I18n.t('views.swot.internal_view.help.subtitle_one')   
          page.should have_content I18n.t('views.swot.internal_view.help.description_one')      
          page.should have_content I18n.t('views.swot.internal_view.help.subtitle_two')   
          page.should have_content I18n.t('views.swot.internal_view.help.description_two')
        end
      end
      
      it "should allow me to delete the weakness", :js => true do
        
        visit @sub_host + swot_analyses_path
        
        within("#analysis-#{@weakness.id}") do
          find(:xpath, "//input[contains(@class, 'delete')]").click
        end
        
        page.driver.browser.switch_to.alert.accept
        
        current_url.should == @sub_host + internal_swot_analyses_path
        current_path.should == internal_swot_analyses_path
        
        page.should_not have_css("#analysis-#{@weakness.id}")
      end
      
      it "should allow me to modify the weakness", :js => true do
        visit @sub_host + swot_analyses_path
        
        within("#analysis-#{@weakness.id}") do
          find(:xpath, "//span[contains(@class, 'inline-analysis-value')]").click
          fill_in('analysis[content]', :with => 'Burocracy')
          click_on('Guardar')
          page.should have_content('Burocracy')
          page.should_not have_content(@weakness.content)
        end
      end

      it "should allow me to modify the weakness (cancel)", :js => true do
        visit @sub_host + swot_analyses_path

        within("#analysis-#{@weakness.id}") do
          find(:xpath, "//span[contains(@class, 'inline-analysis-value')]").click

          click_on('Cancelar')
          page.should have_content(@weakness.content)
        end
      end

    end
    
    describe "and one strength is registered" do
      before(:each) do
        @strength = Factory(:strength, 
                            :swot => Factory(:swot, :company => @user.company), 
                            :user => @user)
      end
      
      it "should show me the SWOT page with one strength and no weaknesses" do
        
        click_link I18n.t('views.menu.swot')
        
        current_url.should == @sub_host + swot_analyses_path
        current_path.should == swot_analyses_path
        
        find_link I18n.t('views.swot.internals.title')
        find_link I18n.t('views.swot.externals.title')
        
        within(".strengths") do
          page.should have_content I18n.t('views.swot.shared_views.strengths')
          should_have_analysis_record_for(@strength)
          find_link I18n.t('views.swot.shared_views.controls.add_strength')
        end
        
        within(".weaknesses") do
          page.should have_content I18n.t('views.swot.shared_views.weaknesses')
          find_link I18n.t('views.swot.shared_views.controls.add_weakness')
        end
        
        within(".help") do
          page.should have_content I18n.t('views.common.help.title')
          page.should have_content I18n.t('views.swot.internal_view.help.subtitle_one')   
          page.should have_content I18n.t('views.swot.internal_view.help.description_one')      
          page.should have_content I18n.t('views.swot.internal_view.help.subtitle_two')   
          page.should have_content I18n.t('views.swot.internal_view.help.description_two')
        end
        
      end
      
      it "should allow me to delete the strength", :js => true do
        
        visit @sub_host + swot_analyses_path
        
        within("#analysis-#{@strength.id}") do
          find(:xpath, "//input[contains(@class, 'delete')]").click
        end
        
        page.driver.browser.switch_to.alert.accept
        
        current_url.should == @sub_host + internal_swot_analyses_path
        current_path.should == internal_swot_analyses_path
        
        page.should_not have_css("#analysis-#{@strength.id}")
      end
      
      it "should allow me to modify the strength", :js => true do
        visit @sub_host + swot_analyses_path
        
        within("#analysis-#{@strength.id}") do
          find(:xpath, "//span[contains(@class, 'inline-analysis-value')]").click
          fill_in('analysis[content]', :with => 'Eficiency')
          click_on('Guardar')
          page.should have_content('Eficiency')
          page.should_not have_content(@strength.content)
        end
      end

      it "sho$uld allow me to modify the strength (cancel)", :js => true do
        visit @sub_host + swot_analyses_path

        within("#analysis-#{@strength.id}") do
          find(:xpath, "//span[contains(@class, 'inline-analysis-value')]").click
          click_on('Cancelar')
          page.should have_content(@strength.content)
        end
      end
      
      describe "with some people to notify", :js => true do
        
        before(:each) do
          @user_in_area=Factory.create(:user_no_company_name, :area => @user.area, :company => @user.company)
          @user_not_in_area = Factory.create(:user_no_company_name_other_area, :name => 'Fulano aquel', :company => @user.company)
          click_link I18n.t('views.menu.swot')
        
          current_url.should == @sub_host + swot_analyses_path
          current_path.should == swot_analyses_path
        end
      
        it "should allow me to add a weakness to the SWOT" do
        
          find_link I18n.t('views.swot.internals.title')
          find_link I18n.t('views.swot.externals.title')
        
          within(".weaknesses") do
            page.evaluate_script("$('div#new-weakness').hasClass('hidden');").should be_true
            click_link I18n.t('views.swot.shared_views.controls.add_weakness')
            page.evaluate_script("$('div#new-weakness').hasClass('hidden');").should be_false
          end
          
          notifications_area_with(@user, {:notified => [@user_in_area], :unnotified => [@user_not_in_area]})
          
          fill_in 'analysis_content', :with => 'Burocracia'
          
          find_link I18n.t('views.swot.shared_views.controls.cancel')
          click_button I18n.t('views.swot.shared_views.controls.save')
          
          current_url.should == @sub_host + internal_swot_analyses_path
          current_path.should == internal_swot_analyses_path

          page.should have_content I18n.t('views.common.messages.save.successful', :model => "Debilidad", :genre => "a")
          page.should have_content 'Burocracia'
          page.should have_content @strength.content
        end
        
        it "should show the form for adding a new weakness but also should allow me to hide it" do
          
          within(".weaknesses") do
            page.evaluate_script("$('div#new-weakness').hasClass('hidden');").should be_true
            click_link I18n.t('views.swot.shared_views.controls.add_weakness')
            page.evaluate_script("$('div#new-weakness').hasClass('hidden');").should be_false
          end
          
          within("#new-weakness form") do
            click_link I18n.t('views.swot.shared_views.controls.cancel')
          end
          
          within(".weaknesses") do
            page.evaluate_script("$('div#new-weakness').hasClass('hidden');").should be_true
          end
        end
        
        it "should allow me to add a strength to the SWOT" do
        
          find_link I18n.t('views.swot.internals.title')
          find_link I18n.t('views.swot.externals.title')
        
          within(".strengths") do
            page.evaluate_script("$('div#new-strength').hasClass('hidden');").should be_true
            click_link I18n.t('views.swot.shared_views.controls.add_strength')
            page.evaluate_script("$('div#new-strength').hasClass('hidden');").should be_false
          end
          
          notifications_area_with(@user, {:notified => [@user_in_area], :unnotified => [@user_not_in_area]})
          
          fill_in 'analysis_content', :with => 'Tecnología'
          
          find_link I18n.t('views.swot.shared_views.controls.cancel')
          click_button I18n.t('views.swot.shared_views.controls.save')
          
          current_url.should == @sub_host + internal_swot_analyses_path
          current_path.should == internal_swot_analyses_path

          page.should have_content I18n.t('views.common.messages.save.successful', :model => "Fortaleza", :genre => "a")
          page.should have_content 'Tecnología'
          page.should have_content @strength.content
        end
        
        it "should show the form for adding a new strength but also should allow me to hide it" do
          
          within(".strengths") do
            page.evaluate_script("$('div#new-strength').hasClass('hidden');").should be_true
            click_link I18n.t('views.swot.shared_views.controls.add_strength')
            page.evaluate_script("$('div#new-strength').hasClass('hidden');").should be_false
          end
          
          within("#new-strength form") do
            click_link I18n.t('views.swot.shared_views.controls.cancel')
          end
          
          within(".strengths") do
            page.evaluate_script("$('div#new-strength').hasClass('hidden');").should be_true
          end
        end
        
        
        
      end
    end
    
  end
  
end
