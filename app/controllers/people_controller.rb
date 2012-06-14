require 'subdomain_guards'
class PeopleController < ApplicationController
  include UserAssociationsHelper
  include PeopleHelper
  include SubdomainGuards
  layout 'application'

  before_filter :verify_subdomain
  before_filter :check_permissions, :only=>[:edit,:create,:update,:destroy]
  
  
  
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

  def destroy
    user=User.find(params[:id])
    if user.is_owner?  and user.company.has_only_one_owner?
      redirect_to people_path, :alert => I18n.t('views.people.edit.cannot_destroy')
    else  
      if current_user==user
        sign_out(current_user)
        user.destroy
        redirect_to home_path, :notice => I18n.t('views.people.edit.destroy_himself')
      else
          user.destroy
          redirect_to people_path, :notice => I18n.t('views.people.edit.destroy_user')
      end  
      
      
    end
  end    


  def index
    @company = current_user.company
    @root_area = Area.get_all_for(@company).where(:is_root_area=>true)
    @areas = Area.get_all_for(@company).where(:alevel=>1)
    resource
    render('index')
  end

  
  
  def bulk_update_admin
    User.change_role_for(params[:users])
    redirect_to(areas_admin_path, :notice => I18n.t('views.people.admin.messages.successful_update'))
  end
  
  private 
  
  def check_permissions
    (!current_user.is_admin? && !current_user.is_owner?) ? redirect_to(people_path, :notice => I18n.t('views.people.access_denied')) : true
  end
    
  
end
