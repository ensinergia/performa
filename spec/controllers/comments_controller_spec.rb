# encoding: utf-8
require 'spec_helper'

describe CommentsController do
  
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    @user = Factory(:user)
    @comment = Factory(:comment, :user => @user, :commentable => Factory(:vision_with_assoc))
    sign_in :user, @user
    @request.host = "#{@user.subdomain}.test.host"
  end
  
  describe "POST create" do
    
    it "should assign the comment to @comment" do
      Comment.should_receive(:new) { @comment }
      post :create, :comment => {:user_id => '1', :commentable_id => '1', :content => 'a comment content'}
      assigns(:comment).should == @comment
    end
    
  end
  
  describe "DELETE destroy" do
    
    it "should assign the remaining comments to @comments" do
      Comment.should_receive(:find).with('1') { @comment }
      delete :destroy, :id => '1'
      assigns(:comment).should == @comment
    end 
    
  end
  
end