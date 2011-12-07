require 'subdomain_guards'
class PeopleController < ApplicationController
  include UserAssociationsHelper
  include PeopleHelper
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  
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
