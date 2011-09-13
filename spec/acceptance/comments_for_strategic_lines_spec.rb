#encoding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'
require "#{File.dirname(__FILE__)}/support/strategic_lines_helpers.rb"
include Warden::Test::Helpers

feature "Comments for strategic lines ", :js => true do
  before(:each) do        
    @host = "http://lvh.me:#{Capybara.server_port}"
    @user = Factory(:user)
    
    @sub_host = @host.gsub('lvh.me', "#{@user.subdomain}.lvh.me")
    
    Capybara.app_host = @sub_host
    Capybara.default_host = @sub_host

    login_as(@user)
  end

  
  describe "having one strategic line registered when visiting the strategic lines listing" do
    before(:each) do
      @strategic_line = Factory(:strategic_line, :company => @user.company, :user => @user)      
    end
    
    describe "having no comments" do
    
      before(:each) do
        visit @sub_host + strategic_lines_path
      end
    
      it "should show me the new comment form and allow me to not commit it" do
        page.evaluate_script("$('div#new-comment-for-commentable').hasClass('hidden');").should be_true

        within('.links') do
          click_link I18n.t('views.comments.controls.make_a_comment')
        end

        fill_in 'comment_content', :with => 'A comment about vision with an attachment'

        click_link I18n.t('views.comments.controls.add_a_file')

        attach_file('uploads_0', File.join(Rails.root,"spec", "helper_assets","example.html"))
        attach_file('uploads_1', File.join(Rails.root,"spec", "helper_assets","example_.html"))

        click_link I18n.t('views.comments.controls.cancel')

        page.evaluate_script("$('div#new-comment-for-commentable').hasClass('hidden');").should be_true

        within('.links') do
          click_link I18n.t('views.comments.controls.make_a_comment')
        end

        find_field('comment_content').value.should be_blank
        sleep 5
        click_link I18n.t('views.comments.controls.add_a_file')
        page.evaluate_script("$('div#new-comment-for-commentable #upload-area').children(':input').length;").should == 1

        page.evaluate_script("$('div#new-comment-for-commentable').hasClass('hidden');").should be_false
      end
    
    end
  
    describe "having one comment" do
      
      before(:each) do
        Factory(:comment, :content => 'My comment', :commentable => @strategic_line, :user => @user)
        visit @sub_host + strategic_lines_path
      end
      
      it "should show me the new comment form and allow me to not commit it" do
        page.evaluate_script("$('div#new-comment-for-commentable').hasClass('hidden');").should be_true

        within('.links') do
          find_link I18n.t('views.comments.controls.see')
          click_link I18n.t('views.comments.controls.comment')
        end

        fill_in 'comment_content', :with => 'A comment about vision with an attachment'

        click_link I18n.t('views.comments.controls.add_a_file')

        attach_file('uploads_0', File.join(Rails.root,"spec", "helper_assets","example.html"))
        attach_file('uploads_1', File.join(Rails.root,"spec", "helper_assets","example_.html"))

        click_link I18n.t('views.comments.controls.cancel')

        page.evaluate_script("$('div#new-comment-for-commentable').hasClass('hidden');").should be_true

        within('.links') do
          find_link I18n.t('views.comments.controls.see')
          click_link I18n.t('views.comments.controls.comment')
        end

        find_field('comment_content').value.should be_blank
        sleep 5
        click_link I18n.t('views.comments.controls.add_a_file')
        page.evaluate_script("$('div#new-comment-for-commentable #upload-area').children(':input').length;").should == 1

        page.evaluate_script("$('div#new-comment-for-commentable').hasClass('hidden');").should be_false
      end
      
    end    
  end
  
  it "should behave accordingly to the specs defined on comments for visions"
  
end