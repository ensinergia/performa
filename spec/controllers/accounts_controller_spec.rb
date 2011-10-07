require 'spec_helper'

describe AccountsController do
  
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    @user = Factory(:user)
    sign_in :user, @user
    @request.host = "#{@user.subdomain}.test.host"
  end
  
  describe "all GET actions" do
    
    it "should assign a user on #account_info method" do

      get :account_info
      assigns(:user).should == @user
    end
    
    it "should assign a user on #user_info method" do
      
      get :user_info
      assigns(:user).should == @user
    end
    
    it "should assign a user on #user_tasks method" do
      
      get :user_tasks
      assigns(:user).should == @user
    end
    
  end
  
  describe "PUT #update action" do
    
    describe "on successful update" do
     
      before(:each) do
        @user.stub(:update_attributes).and_return(true)
        request.env["HTTP_REFERER"] = 'some.url.com'
      end
     
      it "should save an strategic line, assign it to @strategic_line and send notifications" do
        User.stub(:find).and_return { @user }
        put :update, :id => '1', :user => { 'some' => 'atrrs' }
        assigns(:user).should == @user
      end 
      
      it "should redirect to account info action" do
        User.stub(:find).and_return { @user }
        put :update, :id => '1'
        response.should be_redirect
      end
      
      it "should set a flash message" do
        User.stub(:find).and_return { @user }
        put :update, :id => '1'
        flash[:notice].should == I18n.t('views.common.messages.update.successful', :model => "Cuenta", :genre => "a")
      end
      
    end
    
    describe "on unsuccessful update" do
      
      before(:each) do
        @user.stub(:update_attributes).and_return(false)
      end
      
      it "should render the edit action" do
        User.stub(:find).and_return { @user }
        put :update, :id => '1'
        response.should_not be_redirect
      end
      
    end

  end
  
end