#encoding: utf-8
=begin
require File.dirname(__FILE__) + '/acceptance_helper'
require "#{File.dirname(__FILE__)}/support/swot_helpers.rb"
include Warden::Test::Helpers

feature "Comments for swot analyses ", :js => true do
  before(:each) do        
    @host = "http://lvh.me:#{Capybara.server_port}"
    @user = Factory(:user)
    
    @sub_host = @host.gsub('lvh.me', "#{@user.subdomain}.lvh.me")
    
    Capybara.app_host = @sub_host
    Capybara.default_host = @sub_host

    login_as(@user)
  end

  
  describe "having one strength registered" do
    before(:each) do
      @analysis = Factory(:strength, 
                          :swot => Factory(:swot, :company => @user.company), 
                          :user => @user)
      visit @sub_host + panorama_path
    end
    
    describe "with no comments" do
    
      it "should allow me to visit the add comment page for a registered internal analysis see the add form and hide it" do
        should_have_comment_page_elements_for(@analysis)
        click_link I18n.t('views.comments.controls.make_a_comment')
        
        page.evaluate_script("$('div#new-comment-for-commentable').hasClass('hidden');").should be_false 
        click_link I18n.t('views.comments.controls.cancel')
        page.evaluate_script("$('div#new-comment-for-commentable').hasClass('hidden');").should be_true
      end
    
    end
  
    describe "with one comment" do
      
      before(:each) do
        Factory(:comment, :content => 'My comment', :commentable => @analysis, :user => @user)
      end
      
      it "should allow me to visit the add comment page for a registered internal analysis see the add form and hide it" do
        should_have_comment_page_elements_for(@analysis)
        
        within('.links') do
          page.should have_content(1)
          find_link I18n.t('views.comments.controls.see')
          click_link I18n.t('views.comments.controls.comment')
        end
        
        page.evaluate_script("$('div#new-comment-for-commentable').hasClass('hidden');").should be_false 
        click_link I18n.t('views.comments.controls.cancel')
        page.evaluate_script("$('div#new-comment-for-commentable').hasClass('hidden');").should be_true
        
      end
      
      it "should let me return to the internal analysis page" do
        visit @sub_host + swot_analysis_comments_path(@analysis)
        
        click_link I18n.t('views.common.controls.back')
      	
      	current_url.should == @sub_host + internal_swot_analyses_path
        current_path.should == internal_swot_analyses_path
      end
      
    end    
  end
  
  describe "having one external analysis registered" do
    before(:each) do
      @analysis = Factory(:opportunity, 
                          :swot => Factory(:swot, :company => @user.company), 
                          :user => @user)
      visit @sub_host + panorama_path
    end
  
    it "should let me return to the external analysis page" do
      visit @sub_host + swot_analysis_comments_path(@analysis)
      
      click_link I18n.t('views.common.controls.back')
    	
    	current_url.should == @sub_host + external_swot_analyses_path
      current_path.should == external_swot_analyses_path
    end
  
  end
  
  it "should behave accordingly to the specs defined on comments for visions"
  
end
=end