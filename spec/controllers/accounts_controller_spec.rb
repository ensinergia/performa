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
    
    before(:each) do
      request.env["HTTP_REFERER"] = 'some.url.com'
    end
    
    describe "on successful update" do
     
      before(:each) do
        subject.current_user.stub(:update_attributes).and_return(true)
      end
      
      it "should redirect to account info action" do
        put :update, :id => '1'
        response.should be_redirect
      end
      
      it "should set a flash message" do
        put :update, :id => '1'
        flash[:notice].should == I18n.t('views.common.messages.update.successful', :model => "Cuenta", :genre => "a")
      end
      
    end
    
    describe "on unsuccessful update" do
      
      before(:each) do
        subject.current_user.stub(:update_attributes).and_return(false)
      end
      
      it "should render the edit action" do
        User.stub(:find).and_return { @user }
        put :update, :id => '1'
        response.should render_template('user_info')
      end
      
    end

  end
  
  describe "DELETE #destroy action" do
    
    it "should delete the current logged-in user" do
      subject.current_user.should_receive(:destroy)
      delete :destroy
    end
    
    it "should redirect and set an alert" do
      delete :destroy
      response.should be_redirect
      flash[:alert].should == I18n.t('devise.registrations.destroyed')
    end
    
  end
  
end