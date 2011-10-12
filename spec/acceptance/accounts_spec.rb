require File.dirname(__FILE__) + '/acceptance_helper'
include Warden::Test::Helpers

feature "Handling of accounts in Performa" do
  
  before(:each) do    
    @host = "http://lvh.me"
    Capybara.app_host = @host
  end
  
  describe "Registration" do
    
    before(:each) do
      visit @host + new_user_registration_path
      Factory(:position, :name => Position.owner)
    end
    
    it "should let me register given I provide valid values" do
      page.should have_content "Performa"
      
      page.should have_content I18n.t('views.registrations.title')
      page.should have_content I18n.t('views.help.title')
      page.should have_content ignoring_new_lines(I18n.t('views.registrations.help_description'))      
      page.should have_content I18n.t('views.registrations.disclaimer')
      page.should have_content I18n.t('views.registrations.service_terms')
      
      fill_in("user_name", :with => 'Silvano')
      fill_in("user_last_name", :with => 'Barba' )
      fill_in("user_company_name", :with => 'iEvolutioned' )
      fill_in("user_email", :with => 'silvano@ievolutioned.com' )
      fill_in("user_password", :with => 'performa' )
      fill_in("user_password_confirmation", :with => 'performa' )
      
      click_on I18n.t('views.registrations.controls.register')
      
      #check domain by URL
      n_host = @host.gsub('lvh.me', 'ievolutioned.lvh.me')
      current_url.should == n_host + panorama_path
      
      current_path.should == panorama_path
    end
    
    it "should not let me register if any required field is missing it's value" do
      fill_in("user_name", :with => 'Silvano')
      fill_in("user_last_name", :with => 'Barba' )
      
      click_on I18n.t('views.registrations.controls.register')
            
      #check domain by URL
      current_url.should == @host + user_registration_path
      
      current_path.should == user_registration_path
      
      page.should have_content "#{User.human_attribute_name(:email)} #{I18n.t(:blank, :scope => [:activerecord, :errors, :messages])}"
      page.should have_content "#{User.human_attribute_name(:password)} #{I18n.t(:blank, :scope => [:activerecord, :errors, :messages])}"
      page.should have_content "#{User.human_attribute_name(:company)} #{I18n.t(:blank, :scope => [:activerecord, :errors, :messages])}"
      
    end
    
    it "should not let me register given I provided a bad formatted company name" do
      page.should have_content "Performa"
      
      fill_in("user_name", :with => 'Silvano')
      fill_in("user_last_name", :with => 'Barba' )
      fill_in("user_company_name", :with => 'I-evolutioned' )
      fill_in("user_email", :with => 'silvano@ievolutioned.com' )
      fill_in("user_password", :with => 'performa' )
      fill_in("user_password_confirmation", :with => 'performa' )
      
      click_on I18n.t('views.registrations.controls.register')
      
      #check domain by URL
      current_url.should == @host + user_registration_path
      
      current_path.should == user_registration_path
      
      page.should have_content "#{User.human_attribute_name(:company)} #{I18n.t('errors.messages.invalid_due_chars')}"
    end
    
  end
  
  describe "Login" do
    
    before(:each) do
      url = @host + new_user_session_path
      visit url
    end
    
    describe "given I am registered" do
      
      before(:each) do
        @user = Factory(:user)
      end
      
      it "should let me enter" do
        fill_in(User.human_attribute_name(:email), :with => 'silvanito@ievolutioned.com')
        fill_in(User.human_attribute_name(:password), :with => 'performa')
        click_on I18n.t('views.login.controls.login')
        
        #check domain by URL
        n_host = @host.gsub('lvh.me', 'ievolutioned.lvh.me')
        current_url.should == n_host + panorama_path
        
        current_path.should == panorama_path
        
      end
    end
    
    it "should not let me enter if I am not registered" do
      fill_in(User.human_attribute_name(:email), :with => 'someone_not_registered@nowhere.com')
      fill_in(User.human_attribute_name(:password), :with => 'nopass')
      click_on I18n.t('views.login.controls.login')
      
      #check domain by URL
      current_url.should == @host + user_session_path
      
      current_path.should == user_session_path
    end
  end
  
  describe "Reviewing of account information when not logged in" do
    
    it "should redirect me to the sign in page when trying to visit accounts root index" do
      visit @host + accounts_path
      
      #check domain by URL
      current_url.should == @host + new_user_session_path
      current_path.should == new_user_session_path
    end
    
    it "should redirect me to the sign in page when trying to visit 'my account' section" do
      visit @host + account_info_path
      
      #check domain by URL
      current_url.should == @host + new_user_session_path
      current_path.should == new_user_session_path
    end
    
    it "should redirect me to the sign in page when trying to visit 'my info' section" do
      visit @host + user_info_path
      
      #check domain by URL
      current_url.should == @host + new_user_session_path
      current_path.should == new_user_session_path
    end
    
    it "should redirect me to the sign in page when trying to visit 'my tasks' section" do
      visit @host + user_tasks_path
      
      #check domain by URL
      current_url.should == @host + new_user_session_path
      current_path.should == new_user_session_path
    end
  end
  
  describe "Reviewing of account information when logged in" do
    
    before(:each) do
      @host = "http://lvh.me:#{Capybara.server_port}"
      @user = Factory(:user, :position => Factory(:position, :name => Position.owner))

      @host = @host.gsub('lvh.me', "#{@user.subdomain}.lvh.me")

      Capybara.app_host = @host
      Capybara.default_host = @host
      login_as(@user)
    end
    
    describe "given I go to my account section" do
      
      before(:each) do
        visit @host + accounts_path
      end
      
      it "should show me the 'my info' section" do
        
        #check domain by URL
        current_url.should == @host + accounts_path
        current_path.should == accounts_path
        
        within(".menu") do
          find_link I18n.t('views.menu.panorama')
          find_link I18n.t('views.menu.creed')
          find_link I18n.t('views.menu.swot')
          find_link I18n.t('views.menu.strategic_lines')
          find_link I18n.t('views.menu.objectives')
          find_link I18n.t('views.menu.programmes')
          find_link I18n.t('views.menu.people')
        end
        
        page.should have_content I18n.t('views.accounts.title')
        
        within(".account_menu") do
          find_link I18n.t('views.accounts.sections.my_info.title')
          find_link I18n.t('views.accounts.sections.my_account.title')
          find_link I18n.t('views.accounts.sections.my_tasks.title')
        end
                
        page.should have_content I18n.t('views.accounts.sections.my_info.title')           
                
        within(".photo-placeholder") do
          find_link I18n.t('views.accounts.sections.my_info.controls.change_photo')
        end
        
        find_field("user_name").value.should == @user.name
        find_field("user_last_name").value.should == @user.last_name
        find_field("user_email").value.should == @user.email

        find_field("user_company_name").value.should == @user.company_name
        
        find_field("user_area")
        find_field("user_position")
        
        # ATTENTION
        #find_field("user_role")
        
        find_link I18n.t('views.accounts.sections.my_info.controls.cancel')
        find_button I18n.t('views.accounts.sections.my_info.controls.save')
        
        within(".help") do
          page.should have_content I18n.t('views.help.title')
        end
        
      end
      
      it "should let me change the info in 'my info' section" do
        
        current_url.should == @host + accounts_path
        current_path.should == accounts_path
        
        find_field("user_company_name").value.should == @user.company_name
        find_field("user_area").value.should == @user.area.name
        find_field("user_position").value.should == @user.position.name
        
        fill_in 'user_email', :with => 'myemail@example.com'
        fill_in 'user_name', :with => 'My Example Name'
        fill_in 'user_last_name', :with => 'With Last Name Examples'

        click_on I18n.t('views.accounts.sections.my_info.controls.save')
    
        current_url.should == @host + accounts_path
        current_path.should == accounts_path
    
        page.should have_content I18n.t('views.common.messages.update.successful', :model => "Cuenta", :genre => "a")
    
        find_field("user_email").value.should == "myemail@example.com"
        find_field("user_name").value.should == "My Example Name"
        find_field("user_last_name").value.should == "With Last Name Examples"
    
        within(".help") do
          page.should have_content I18n.t('views.help.title')  
        end
      end
      
      it "should let me visit the 'my account info' section" do
        within(".account_menu") do
          click_link I18n.t('views.accounts.sections.my_account.title')
        end
            
        within(".menu") do
          find_link I18n.t('views.menu.panorama')
          find_link I18n.t('views.menu.creed')
          find_link I18n.t('views.menu.swot')
          find_link I18n.t('views.menu.strategic_lines')
          find_link I18n.t('views.menu.objectives')
          find_link I18n.t('views.menu.programmes')
          find_link I18n.t('views.menu.people')
        end  
          
        #check domain by URL
        current_url.should == @host + account_info_path
        current_path.should == account_info_path
      
        page.should have_content I18n.t('views.accounts.title')
        
        within(".account_menu") do
          find_link I18n.t('views.accounts.sections.my_info.title')
          find_link I18n.t('views.accounts.sections.my_account.title')
          find_link I18n.t('views.accounts.sections.my_tasks.title')
        end
                
        page.should have_content I18n.t('views.accounts.sections.my_account.title')
      
        find_field("user_login")
        find_field("user_password")
        find_field("user_password_confirmation")
        
        find_link I18n.t('views.accounts.sections.my_account.controls.cancel')
        find_button I18n.t('views.accounts.sections.my_account.controls.edit')
        
        find_field("user_position")
        
        find_link I18n.t('views.accounts.sections.my_account.controls.finish_account')
        
        within(".help") do
          page.should have_content I18n.t('views.help.title')  
        end
      end
      
      it "should let me change the info in 'my account info' section" do
        within(".account_menu") do
          click_link I18n.t('views.accounts.sections.my_account.title')
        end
        
        fill_in 'user_login', :with => 'mylogin.example'
        fill_in 'user_password', :with => 'mypassword'
        fill_in 'user_password_confirmation', :with => 'mypassword'

        click_on I18n.t('views.accounts.sections.my_account.controls.edit')
    
        page.should have_content I18n.t('views.common.messages.update.successful', :model => "Cuenta", :genre => "a")
    
        User.last.login.should == "mylogin.example"
    
        within(".help") do
          page.should have_content I18n.t('views.help.title')  
        end
      end
      
      describe "given I a recently got registered", :js => true do
      
        before(:each) do
          @no_owner_user = Factory(:user_no_company_name, :company => @user.company, :area => @user.area)
          login_as(@no_owner_user)
        end
      
        it "should let me close my account" do
          visit @host + accounts_path
          
          within(".account_menu") do
            click_link I18n.t('views.accounts.sections.my_account.title')
          end
        
          click_on I18n.t('views.accounts.sections.my_account.controls.finish_account')
        
          page.driver.browser.switch_to.alert.accept
        
          current_url.should == @host + root_path
          current_path.should == root_path
        
          page.should have_content I18n.t('devise.registrations.destroyed')
          
          Company.first.should == @no_owner_user.company
          Area.first.should == @no_owner_user.area
          User.count.should be(1)
          User.last.should == @user
        end
        
      end
      
      it "should let me close my account and thus should also close my company data given I am the owner", :js => true do
        within(".account_menu") do
          click_link I18n.t('views.accounts.sections.my_account.title')
        end
      
        click_on I18n.t('views.accounts.sections.my_account.controls.finish_account')
      
        page.driver.browser.switch_to.alert.accept
      
        current_url.should == @host + root_path
        current_path.should == root_path
        
        page.should have_content I18n.t('devise.registrations.destroyed')
        
        Company.first.should be_nil
        Area.first.should be_nil
        User.count.should be(0)
        User.last.should be_nil
      end
      
      describe "given there is a task assigned to me" do
      
        before(:each) do
          @task = Factory(:task, :description => "Some complex task", :priority => Task.high_priority, :user_id => @user.id)
        end
      
        it "should let me visit the 'my tasks' section and see that task listed" do
          click_link I18n.t('views.accounts.sections.my_tasks.title')
              
          #check domain by URL
          current_url.should == @host + user_tasks_path
          current_path.should == user_tasks_path
      
          page.should have_content I18n.t('views.accounts.title')
        
          within(".menu") do
            find_link I18n.t('views.menu.panorama')
            find_link I18n.t('views.menu.creed')
            find_link I18n.t('views.menu.swot')
            find_link I18n.t('views.menu.strategic_lines')
            find_link I18n.t('views.menu.objectives')
            find_link I18n.t('views.menu.programmes')
            find_link I18n.t('views.menu.people')
          end
          
          within(".account_menu") do
            find_link I18n.t('views.accounts.sections.my_info.title')
            find_link I18n.t('views.accounts.sections.my_account.title')
            find_link I18n.t('views.accounts.sections.my_tasks.title')
          end
          
          within(".tasks") do      
            page.should have_content I18n.t('views.accounts.sections.my_tasks.table.task_column_name')
            page.should have_content Task.human_attribute_name(:priority)   
            
            page.should have_content @task.description
            page.should have_content I18n.t("views.accounts.sections.my_tasks.priority.#{@task.priority}")   
          end
          
          within(".help") do
            page.should have_content I18n.t('views.help.title')   
          end
          
        end
        
      end
      
      it "should let me return to the 'my info' section from another one" do
        click_link I18n.t('views.accounts.sections.my_tasks.title')
        click_link I18n.t('views.accounts.sections.my_info.title')
        
        #check domain by URL
        current_url.should == @host + user_info_path
        current_path.should == user_info_path
      end
      
    end
    
  end
  
end