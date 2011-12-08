require 'subdomain_guards'
class PeopleController < ApplicationController
  include UserAssociationsHelper
  include PeopleHelper
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  
  def edit
    @user=User.find(params[:id])
  end
  
  def create
    resource!(params[:user])
    if @resource.save
      @text=nil
    else
      @text= devise_error_messages!
    end  
    
    respond_to do |format|
      format.js
    end  
    
  end
  
  def update
     user=User.find(params[:id])
     user.area_id=params[:user][:area_id]
     user.position_id=params[:user][:position_id]
     if user.update_attributes(params[:user])
       redirect_to :back, :notice => I18n.t('views.common.messages.update.successful', :model => "Cuenta", :genre => "a")
     else
       render :action => :edit
     end
   end
    
  
  def index
    @company = current_company
    @areas = Area.get_all_for(current_company)
    resource
    if @areas.empty?
      render('index_welcome')
    else
      render('index')
    end
  end

  def bulk_update_admin
    User.change_role_for(params[:users])
    redirect_to(areas_admin_path, :notice => I18n.t('views.people.admin.messages.successful_update'))
  end
end
