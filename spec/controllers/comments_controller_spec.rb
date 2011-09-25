# encoding: utf-8
require 'spec_helper'

describe CommentsController do
  
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    @user = Factory(:user)
    sign_in :user, @user
    @request.host = "#{@user.subdomain}.test.host"
  end
  
  describe "POST create" do
    
    before(:each) do
      @comment = Factory(:comment, :user => @user, :commentable => Factory(:vision_with_assoc))
    end
    
    describe "when uploads parameter present" do
    
      it "should assign the comment to @comment and set it's attachments" do
        Comment.should_receive(:new) { @comment }
        @comment.should_receive(:set_attachments).with({1=> "an attachment"})
        post :create, :comment => {:user_id => '1', :commentable_id => '1', :content => 'a comment content'}, 
                      :uploads => {1 => "an attachment"}
        assigns(:comment).should == @comment
      end
    
    end
    
    describe "when uploads parameter NOT present" do
    
      it "should assign the comment to @comment and NOT gset it's attachments" do
        Comment.should_receive(:new) { @comment }
        @comment.should_not_receive(:set_attachments)
        post :create, :comment => {:user_id => '1', :commentable_id => '1', :content => 'a comment content'}
        assigns(:comment).should == @comment
      end
    
    end
    
  end
  
  describe "DELETE destroy" do
    
    
    before(:each) do
      @comment = Factory(:comment, :user => @user, :commentable => Factory(:vision_with_assoc))
    end
    
    it "should destroy comment" do
      Comment.should_receive(:find_and_destroy).with('1') { @comment }
      delete :destroy, :id => '1'
      assigns(:comment).should == @comment
    end
    
  end
  
end
