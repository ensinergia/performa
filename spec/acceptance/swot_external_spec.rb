#encoding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'
require "#{File.dirname(__FILE__)}/support/swot_helpers.rb"

include Warden::Test::Helpers

feature "SWOT external features" do
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
    
    describe "and one opportunity is registered" do
      
      before(:each) do
        @opportunity = Factory(:opportunity, 
                            :swot => Factory(:swot, :company => @user.company), 
                            :user => @user)
      end
      
      it "should show me to SWOT page with one opportunity and no risks" do
        click_link I18n.t('views.menu.swot')

        current_url.should == @sub_host + swot_analyses_path
        current_path.should == swot_analyses_path
        
        find_link I18n.t('views.swot.internals.title')
        click_link I18n.t('views.swot.externals.title')
        
        current_url.should == @sub_host + external_swot_analyses_path
        current_path.should == external_swot_analyses_path
        
        within(".opportunities") do
          page.should have_content I18n.t('views.swot.shared_views.opportunities')
          should_have_analysis_record_for(@opportunity)
          find_link I18n.t('views.swot.shared_views.controls.add_opportunity')
        end
        
        within(".risks") do
          page.should have_content I18n.t('views.swot.shared_views.risks')
          find_link I18n.t('views.swot.shared_views.controls.add_risk')
        end
        
        within(".help") do
          page.should have_content I18n.t('views.help.title')
          page.should have_content I18n.t('views.swot.internal_view.help.subtitle_one')   
          page.should have_content I18n.t('views.swot.internal_view.help.description_one')      
          page.should have_content I18n.t('views.swot.internal_view.help.subtitle_two')   
          page.should have_content I18n.t('views.swot.internal_view.help.description_two')
        end
      end
      
      it "should allow me to delete the opportunity", :js => true do
        
        visit @sub_host + external_swot_analyses_path
        
        within("#analysis-#{@opportunity.id}") do
          find(:xpath, "//input[contains(@class, 'delete')]").click
        end
        
        page.driver.browser.switch_to.alert.accept
        
        current_url.should == @sub_host + external_swot_analyses_path
        current_path.should == external_swot_analyses_path
        
        page.should_not have_css("#analysis-#{@opportunity.id}")
      end
      
      it "should allow me to modify the opportunity", :js => true do
        visit @sub_host + external_swot_analyses_path
        
        within("#analysis-#{@opportunity.id}") do
          find(:xpath, "//span[contains(@class, 'inline-analysis-value')]").click
          
          click_on('Cancelar')
          page.should have_content(@opportunity.content)
          
          find(:xpath, "//span[contains(@class, 'inline-analysis-value')]").click
          fill_in('analysis[content]', :with => 'Burocracy')
          click_on('Guardar')
          page.should have_content('Burocracy')
          page.should_not have_content(@opportunity.content)
        end
      end
      
    end
    
    describe "and one risk is registered" do
      before(:each) do
        @risk = Factory(:risk, 
                        :swot => Factory(:swot, :company => @user.company), 
                        :user => @user)
      end
      
      it "should show me the SWOT page with one risk and no opportunities" do
        
        click_link I18n.t('views.menu.swot')
        
        current_url.should == @sub_host + swot_analyses_path
        current_path.should == swot_analyses_path
        
        find_link I18n.t('views.swot.internals.title')
        click_link I18n.t('views.swot.externals.title')
        
        within(".risks") do
          page.should have_content I18n.t('views.swot.shared_views.risks')
          should_have_analysis_record_for(@risk)
          find_link I18n.t('views.swot.shared_views.controls.add_risk')
        end
        
        within(".opportunities") do
          page.should have_content I18n.t('views.swot.shared_views.opportunities')
          find_link I18n.t('views.swot.shared_views.controls.add_opportunity')
        end
        
        within(".help") do
          page.should have_content I18n.t('views.help.title')
          page.should have_content I18n.t('views.swot.internal_view.help.subtitle_one')   
          page.should have_content I18n.t('views.swot.internal_view.help.description_one')      
          page.should have_content I18n.t('views.swot.internal_view.help.subtitle_two')   
          page.should have_content I18n.t('views.swot.internal_view.help.description_two')
        end
        
      end
      
      it "should allow me to delete the risk", :js => true do
        
        visit @sub_host + external_swot_analyses_path
        
        within("#analysis-#{@risk.id}") do
          find(:xpath, "//input[contains(@class, 'delete')]").click
        end
        
        page.driver.browser.switch_to.alert.accept
        
        current_url.should == @sub_host + external_swot_analyses_path
        current_path.should == external_swot_analyses_path
        
        page.should_not have_css("#analysis-#{@risk.id}")
      end
      
      it "should allow me to modify the risk", :js => true do
        visit @sub_host + external_swot_analyses_path
        
        within("#analysis-#{@risk.id}") do
          find(:xpath, "//span[contains(@class, 'inline-analysis-value')]").click
          
          click_on('Cancelar')
          page.should have_content(@risk.content)
          
          find(:xpath, "//span[contains(@class, 'inline-analysis-value')]").click
          fill_in('analysis[content]', :with => 'New competitors')
          click_on('Guardar')
          page.should have_content('New competitors')
          page.should_not have_content(@risk.content)
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
      
        it "should allow me to add an opportunity to the SWOT" do
        
          find_link I18n.t('views.swot.internals.title')
          click_link I18n.t('views.swot.externals.title')
        
          within(".opportunities") do
            page.evaluate_script("$('div#new-opportunity').hasClass('hidden');").should be_true
            click_link I18n.t('views.swot.shared_views.controls.add_opportunity')
            page.evaluate_script("$('div#new-opportunity').hasClass('hidden');").should be_false
          end
          
          notifications_area_with(@user, {:notified => [@user_in_area], :unnotified => [@user_not_in_area]})
          
          fill_in 'analysis_content', :with => 'Young market'
          
          find_link I18n.t('views.swot.shared_views.controls.cancel')
          click_button I18n.t('views.swot.shared_views.controls.save')
          
          current_url.should == @sub_host + external_swot_analyses_path
          current_path.should == external_swot_analyses_path

          page.should have_content I18n.t('views.common.messages.save.successful', :model => "Oportunidad", :genre => "a")
          page.should have_content 'Young market'
          page.should have_content @risk.content
        end
        
        it "should show the form for adding a new opportunity but also should allow me to hide it" do
          click_link I18n.t('views.swot.externals.title')
          
          within(".opportunities") do
            page.evaluate_script("$('div#new-opportunity').hasClass('hidden');").should be_true
            click_link I18n.t('views.swot.shared_views.controls.add_opportunity')
            page.evaluate_script("$('div#new-opportunity').hasClass('hidden');").should be_false
          end
          
          within("#new-opportunity form") do
            click_link I18n.t('views.swot.shared_views.controls.cancel')
          end
          
          within(".opportunities") do
            page.evaluate_script("$('div#new-opportunity').hasClass('hidden');").should be_true
          end
        end
        
        it "should allow me to add a risk to the SWOT" do
        
          find_link I18n.t('views.swot.internals.title')
          click_link I18n.t('views.swot.externals.title')
        
          within(".risks") do
            page.evaluate_script("$('div#new-risk').hasClass('hidden');").should be_true
            click_link I18n.t('views.swot.shared_views.controls.add_risk')
            page.evaluate_script("$('div#new-risk').hasClass('hidden');").should be_false
          end
          
          notifications_area_with(@user, {:notified => [@user_in_area], :unnotified => [@user_not_in_area]})
          
          fill_in 'analysis_content', :with => 'Technology not ready yet'
          
          find_link I18n.t('views.swot.shared_views.controls.cancel')
          click_button I18n.t('views.swot.shared_views.controls.save')
          
          current_url.should == @sub_host + external_swot_analyses_path
          current_path.should == external_swot_analyses_path

          page.should have_content I18n.t('views.common.messages.save.successful', :model => "Riesgo", :genre => "o")
          page.should have_content 'Technology not ready yet'
          page.should have_content @risk.content
        end
        
        it "should show the form for adding a new risk but also should allow me to hide it" do
          click_link I18n.t('views.swot.externals.title')
          
          within(".risks") do
            page.evaluate_script("$('div#new-risk').hasClass('hidden');").should be_true
            click_link I18n.t('views.swot.shared_views.controls.add_risk')
            page.evaluate_script("$('div#new-risk').hasClass('hidden');").should be_false
          end
          
          within("#new-risk form") do
            click_link I18n.t('views.swot.shared_views.controls.cancel')
          end
          
          within(".risks") do
            page.evaluate_script("$('div#new-risk').hasClass('hidden');").should be_true
          end
        end
        
        
        
      end
    end
    
  end
  
end