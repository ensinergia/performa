require 'subdomain_guards'
class CommentsController < ActionController::Base
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  
  def create
    @comment = Comment.new(params[:comment].merge(:user_id => current_user.id))
    @comment.set_attachments(params[:uploads]) unless params[:uploads].blank?
    @comment.save
    
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    
    respond_to do |format|
      format.js
    end
  end
  
end