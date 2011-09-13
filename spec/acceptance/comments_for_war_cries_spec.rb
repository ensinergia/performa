#encoding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'
include Warden::Test::Helpers

feature "Comments for war cries:", :js => true do
  before(:each) do        
    @host = "http://lvh.me:#{Capybara.server_port}"
    @user = Factory(:user)
    
    @sub_host = @host.gsub('lvh.me', "#{@user.subdomain}.lvh.me")
    
    Capybara.app_host = @sub_host
    Capybara.default_host = @sub_host

    login_as(@user)
  end

  
  describe "Given there exists a war cry for a given company" do
     
    before(:each) do
      @war_cry = Factory(:war_cry_with_assoc, :company => @user.company)
      visit @sub_host + creed_war_cries_path
    end
    
    describe "and no comments" do
    
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
    
    describe "and one comment" do
      before(:each) do
        @comment = Factory(:comment, :content => 'My comment', :commentable => @war_cry, :user => @user)
        visit @sub_host + creed_war_cries_path
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
    
    it "should behave accordingly to the specs defined on comments for visions"
    
  end

end