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
    
      it "should let me add a new one given content is provided" do       
        page.evaluate_script("$('div#new-comment-for-commentable').hasClass('hidden');").should be_true
        
        within('.links') do
          click_link I18n.t('views.comments.controls.make_a_comment')
        end
      
        page.evaluate_script("$('div#new-comment-for-commentable').hasClass('hidden');").should be_false
        
        page.should have_content(I18n.t('views.comments.leave_a_comment'))
        find_link I18n.t('views.comments.controls.add_a_file')
        fill_in 'comment_content', :with => 'A comment about vision'
        
        find_link I18n.t('views.comments.controls.cancel')
        click_button I18n.t('views.comments.controls.add')
        
        page.should have_content I18n.t('views.common.messages.save.successful', :model => I18n.t('activerecord.models.comment'), :genre => 'o')
        
        page.evaluate_script("$('div#new-comment-for-commentable').hasClass('hidden');").should be_true
        
        first_comment = Comment.first
        
        should_have_comment(first_comment, @user)
        
        within('.links') do
          page.should have_content(1)
        end
      end
      
      it "should NOT let me add a new one given no content is provided" do
        
        within('.links') do
          click_link I18n.t('views.comments.controls.make_a_comment')
        end
        
        find_link I18n.t('views.comments.controls.add_a_file')
        fill_in 'comment_content', :with => ''
        
        find_link I18n.t('views.comments.controls.cancel')
        click_button I18n.t('views.comments.controls.add')
        
        page.should have_content I18n.t('views.common.messages.save.unsuccessful', :model => I18n.t('activerecord.models.comment'), :connector => 'éste')
        
        within('.links') do
          find_link I18n.t('views.comments.controls.make_a_comment')
        end
      end
      
      describe "including" do
      
        before(:each) do
          Fog.mock!
          Fog.credentials_path = Rails.root.join('config/fog_credentials.yml')
          connection = Fog::Storage.new(:provider => 'AWS')
          connection.directories.create(:key => 'ensinergia')
        end
      
        it "one attachment should let me add a new comment" do
        
          within('.links') do
            click_link I18n.t('views.comments.controls.make_a_comment')
          end
        
          fill_in 'comment_content', :with => 'A comment about vision with an attachment'
        
          page.evaluate_script("$('div#upload-area').hasClass('hidden');").should be_true
          click_link I18n.t('views.comments.controls.add_a_file')
          page.evaluate_script("$('div#upload-area').hasClass('hidden');").should be_false
        
          attach_file('uploads_0', File.join(Rails.root,"spec", "helper_assets","example.html"))
          click_button I18n.t('views.comments.controls.add')
          sleep 5
          should_have_comment(Comment.first, @user, with_delete_controls, with_attachments(['example.html']))
        
          page.should have_content I18n.t('views.common.messages.save.successful', :model => I18n.t('activerecord.models.comment'), :genre => 'o')
        
          within('.links') do
            page.should have_content(1)
            find_link I18n.t('views.comments.controls.see')
            find_link I18n.t('views.comments.controls.comment')
          end
        end
        
        it "two attachments should let me add a new comment" do
        
          within('.links') do
            click_link I18n.t('views.comments.controls.make_a_comment')
          end
        
          fill_in 'comment_content', :with => 'A comment about vision with an attachment'
        
          page.evaluate_script("$('div#upload-area').hasClass('hidden');").should be_true
          click_link I18n.t('views.comments.controls.add_a_file')
          page.evaluate_script("$('div#upload-area').hasClass('hidden');").should be_false
        
          attach_file('uploads_0', File.join(Rails.root,"spec", "helper_assets","example.html"))
          attach_file('uploads_1', File.join(Rails.root,"spec", "helper_assets","example_.html"))
          click_button I18n.t('views.comments.controls.add')
          
          sleep 5
          should_have_comment(Comment.first, @user, with_delete_controls, with_attachments(['example.html']))
          should_have_comment(Comment.first, @user, with_delete_controls, with_attachments(['example_.html']))
        
          page.should have_content I18n.t('views.common.messages.save.successful', :model => I18n.t('activerecord.models.comment'), :genre => 'o')
        
          within('.links') do
            page.should have_content(1)
            find_link I18n.t('views.comments.controls.see')
            find_link I18n.t('views.comments.controls.comment')
          end
        end
        
      end
      
    end
    
    describe "and one comment" do
      before(:each) do
        @comment = Factory(:comment, :content => 'My comment', :commentable => @vision, :user => @user)
        visit @sub_host + creed_visions_path
      end
      
      it "should change links on delete" do
        click_link I18n.t('views.comments.controls.see')
        
        within("#comment-#{@comment.id}") do
          click_on I18n.t('views.comments.controls.delete')
        end
        
        page.driver.browser.switch_to.alert.accept
        
        within('.links') do
          find_link I18n.t('views.comments.controls.make_a_comment')
        end
        
        page.should have_no_css("#comment-##{@comment.id}")
      end
    end
    
    describe "and two comments: 'A' written by me, 'B' not written by me" do
      
      before(:each) do
        @comment_A = Factory(:comment, :content => 'My comment', :commentable => @vision, :user => @user, :attachments => [Factory(:attachment)])
        @comment_B = Factory(:comment, :content => 'A comment not mine', 
                             :commentable => @vision, 
                             :user => Factory(:user_no_company_name, :area => @user.area, :company => @user.company))
        visit @sub_host + creed_visions_path
      end
      
      it "should let me see them listed" do
        within('.links .number') do
          page.should have_content("2")
        end
        
        find_link I18n.t('views.comments.controls.comment')
        
        click_link I18n.t('views.comments.controls.see')
        
        should_have_comment(@comment_A, @user)
        should_have_comment(@comment_B, @comment_B.user, without_delete_controls)
      end
      
      it "should let me add a new one" do
        find_link I18n.t('views.comments.controls.see')
        
        click_link I18n.t('views.comments.controls.comment')
        
        fill_in 'comment_content', :with => 'A comment about vision'
        
        should_have_comment(Comment.first, @user)
      end
      
      it "should let me delete comment 'A'" do        
        attachment_file_url = @comment_A.attachments.first.content
        
        click_link I18n.t('views.comments.controls.see')
        
        within("#comment-#{@comment_A.id}") do
          click_on I18n.t('views.comments.controls.delete')
        end
        
        page.driver.browser.switch_to.alert.accept
        
        within('.links .number') do
          page.should have_content("1")
        end
        
        page.should have_no_css("#comment-##{@comment_A.id}")

        visit "#{attachment_file_url}"
        page.should have_content('AccessDenied')
      end
      
      it "should NOT have delete button for comment 'B'" do
        click_link I18n.t('views.comments.controls.see')
        
        within("#comment-#{@comment_B.id}") do
          page.should have_no_selector(:xpath, "//button[@value='#{I18n.t('views.comments.controls.delete')}']")          
        end
      end
            
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

end