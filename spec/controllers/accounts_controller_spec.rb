# encoding: utf-8
require 'spec_helper'

describe AccountsController do
  
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end
  
  describe "all GET actions" do
    
    before(:each) do
      @user = Factory(:user)
      sign_in :user, @user
      @request.host = "#{@user.subdomain}.test.host"
    end
    
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
  
end