require 'subdomain_guards'
class CommentsController < ApplicationController
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  
  def show
    @obj=params[:model].constantize.find(params[:id])
    @comments=@obj.comments
    @title=" -" 
    @title=@obj.results+" "+I18n.t('views.operative_objective.new.through')+" "+@obj.actions unless !@obj.attribute_present?("results")
    @title=@obj.description unless !@obj.attribute_present?("description")
    @title=@obj.content unless !@obj.attribute_present?("content")
    @title=@obj.name unless !@obj.attribute_present?("name")
    @controller_st= (params[:model]=="Mission" || params[:model]=="Vision" || params[:model]=="WarCry") ?  "creed/"+params[:model].tableize : @controller_st=params[:model].tableize
    @controller_st=params[:model]=="Analysis" ?  "swot/"+params[:model].tableize : @controller_st
  end  
  
  
  def create
    @comment = Comment.new(params[:comment].merge(:user_id => current_user.id))
    @comment.set_attachments(params[:uploads]) unless params[:uploads].blank?
    @comment.save
    respond_to do |format|
      format.js
      format.html{
        redirect_to show_comments_path(:model=>params[:comment][:commentable_type],:id=>params[:comment][:commentable_id])
        }
    end
  end
  
  def destroy
    @comment = Comment.find_and_destroy(params[:id])
    
    respond_to do |format|
      format.js
      format.html{redirect_to :back }
    end
  end
  
end