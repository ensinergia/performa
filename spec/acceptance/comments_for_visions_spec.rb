#encoding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'
include Warden::Test::Helpers

feature "Comments for visions:", :js => true do
  before(:each) do        
    @host = "http://lvh.me:#{Capybara.server_port}"
    @user = Factory(:user)
    
    @sub_host = @host.gsub('lvh.me', "#{@user.subdomain}.lvh.me")
    
    Capybara.app_host = @sub_host
    Capybara.default_host = @sub_host

    login_as(@user)
  end
  
  describe "Given there exists a vision for a given company" do
     
    before(:each) do
      @vision = Factory(:vision_with_assoc, :company => @user.company)
      visit @sub_host + creed_visions_path
    end
    
    describe "and no comments" do
    
      it "should let me add a new one" do       
        page.evaluate_script("$('div#new-comment-for-commentable').hasClass('hidden');").should be_true
        
        within('.links') do
          click_link I18n.t('views.creed.show_vision.controls.make_a_comment')
        end
        
        page.evaluate_script("$('div#new-comment-for-commentable').hasClass('hidden');").should be_false
        
        page.should have_content(I18n.t('views.creed.comments.leave_a_comment'))
        find_link I18n.t('views.creed.comments.controls.add_a_file')
        fill_in 'comment_content', :with => 'A comment about vision'
        
        find_link I18n.t('views.creed.comments.controls.cancel')
        click_button I18n.t('views.creed.comments.controls.add')
        
        page.should have_content I18n.t('views.creed.comments.add_comment.successful_save')
        
        page.evaluate_script("$('div#new-comment-for-commentable').hasClass('hidden');").should be_true
        
        first_comment = Comment.first
        
        should_have_comment(first_comment, @user)
        
        within('.links') do
          page.should have_content(1)
          find_link I18n.t('views.creed.comments.controls.see')
          find_link I18n.t('views.creed.comments.controls.comment')
        end
      end
      
      it "should NOT let me add a new one" do
        
        within('.links') do
          click_link I18n.t('views.creed.show_vision.controls.make_a_comment')
        end
        
        find_link I18n.t('views.creed.comments.controls.add_a_file')
        fill_in 'comment_content', :with => ''
        
        find_link I18n.t('views.creed.comments.controls.cancel')
        click_button I18n.t('views.creed.comments.controls.add')
        
        page.should have_content I18n.t('views.creed.comments.add_comment.unsuccessful_save')
        
        within('.links') do
          find_link I18n.t('views.creed.show_vision.controls.make_a_comment')
        end
      end
      
      it "should let me add an adjoint file to a new comment and then download it"
      
    end
    
    describe "and one comment" do
      before(:each) do
        @comment = Factory(:comment, :content => 'My comment', :commentable => @vision, :user => @user)
        visit @sub_host + creed_visions_path
      end
      
      it "should change links on delete" do
        click_link I18n.t('views.creed.comments.controls.see')
        
        within("#comment-#{@comment.id}") do
          click_on I18n.t('views.creed.comments.controls.delete')
        end
        
        page.driver.browser.switch_to.alert.accept
        
        within('.links') do
          find_link I18n.t('views.creed.show_vision.controls.make_a_comment')
        end
        
        page.should have_no_css("#comment-##{@comment.id}")
      end
    end
    
    describe "and two comments: 'A' written by me, 'B' not written by me" do
      
      before(:each) do
        @comment_A = Factory(:comment, :content => 'My comment', :commentable => @vision, :user => @user)
        @comment_B = Factory(:comment, :content => 'A comment not mine', 
                             :commentable => @vision, 
                             :user => Factory(:user_no_company_name, :area => @user.area, :company => @user.company))
        visit @sub_host + creed_visions_path
      end
      
      it "should let me see them listed" do
        within('.links .number') do
          page.should have_content("2")
        end
        
        find_link I18n.t('views.creed.comments.controls.comment')
        
        click_link I18n.t('views.creed.comments.controls.see')
        
        should_have_comment(@comment_A, @user)
        should_have_comment(@comment_B, @comment_B.user, false)
      end
      
      it "should let me add a new one" do
        find_link I18n.t('views.creed.comments.controls.see')
        
        click_link I18n.t('views.creed.comments.controls.comment')
        
        fill_in 'comment_content', :with => 'A comment about vision'
        
        should_have_comment(Comment.first, @user)
      end
      
      it "should let me delete comment 'A'" do
        click_link I18n.t('views.creed.comments.controls.see')
        
        within("#comment-#{@comment_A.id}") do
          click_on I18n.t('views.creed.comments.controls.delete')
        end
        
        page.driver.browser.switch_to.alert.accept
        
        within('.links .number') do
          page.should have_content("1")
        end
        
        page.should have_no_css("#comment-##{@comment_A.id}")
      end
      
      it "should NOT have delete button for comment 'B'" do
        click_link I18n.t('views.creed.comments.controls.see')
        
        within("#comment-#{@comment_B.id}") do
          page.should have_no_selector(:xpath, "//button[@value='#{I18n.t('views.creed.comments.controls.delete')}']")          
        end
      end
            
    end
    
  end
  
  
  
  
end