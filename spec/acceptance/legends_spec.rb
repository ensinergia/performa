#encoding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'
require "#{File.dirname(__FILE__)}/support/swot_helpers.rb"

include Warden::Test::Helpers

feature "Legend specs" do
  before(:each) do    
    @host = "http://lvh.me:#{Capybara.server_port}"
    Capybara.app_host = @host
    @user = Factory(:user)
    @sub_host = @host.gsub('lvh.me', "#{@user.subdomain}.lvh.me")
    login_as(@user)    
  end
  
  
  describe "Given there is no previously added content and I visit the mock legends page" do
    
    before(:each) do
      visit @sub_host + admin_contextual_legends_path
    end
    
    it "should allow me to add new content", :js => true do
      page.should have_content I18n.t('views.help.title')
      
      page.should have_content I18n.t('views.help.show.empty.legend')
      
      click_on I18n.t('views.help.show.controls.add')
      
      current_url.should == @sub_host + new_admin_contextual_legend_path
      current_path.should == new_admin_contextual_legend_path
      
      page.should have_content I18n.t('views.help.new.title')
      
      page.should have_content I18n.t('views.help.shared.editor.legend')
      page.should have_content I18n.t('views.help.shared.previewer.legend')
      
      fill_in 'contextual_legend_content', :with => "**Test**

       1. Option one
       2. Option two

      "

      page.should have_content I18n.t('views.help.shared.previewer.legend')

      within('#wmd-preview') do
        page.should have_content "Test"
        page.should have_content "1. Option one"
        page.should have_content "2. Option two"
      end      
      
      click_button I18n.t('views.help.shared.controls.save')
      
      current_url.should == @sub_host + admin_contextual_legends_path
      current_path.should == admin_contextual_legends_path
       
      within(".help") do
        page.should have_content I18n.t('views.help.title')
        page.should have_content "Test"
        page.should have_content "1. Option one"
        page.should have_content "2. Option two"
      end
      
    end
  end
  
  describe "Given there is content previously added and I visit the mock legends page" do
    
    before(:each) do
      @contextual_legend=Factory(:contextual_legend, :url => admin_contextual_legends_path, :content => "<p>This is content</p>")
      visit @sub_host + admin_contextual_legends_path
    end
    
    it "should let me modify it", :js => true do
      
      page.should have_content I18n.t('views.help.title')

      page.should have_content "This is content"

      click_on I18n.t('views.help.show.controls.edit')

      current_url.should == @sub_host + edit_admin_contextual_legend_path(@contextual_legend)
      current_path.should == edit_admin_contextual_legend_path(@contextual_legend)

      within('#wmd-preview') do
        page.should have_content "This is content"
      end

      page.should have_content I18n.t('views.help.edit.title')

      page.should have_content I18n.t('views.help.shared.editor.legend')
      page.should have_content I18n.t('views.help.shared.previewer.legend')

      fill_in 'contextual_legend_content', :with => "**Test**

       1. Option one
       2. Option two

      "

      page.should have_content I18n.t('views.help.shared.previewer.legend')

      within('#wmd-preview') do
        page.should have_content "Test"
        page.should have_content "1. Option one"
        page.should have_content "2. Option two"
      end      

      click_button I18n.t('views.help.shared.controls.save')
      current_url.should == @sub_host + admin_contextual_legends_path
      current_path.should == admin_contextual_legends_path

      within(".help") do
        page.should have_content I18n.t('views.help.title')
        page.should have_content "Test"
        page.should have_content "1. Option one"
        page.should have_content "2. Option two"
      end
    end
  end
          
  
end