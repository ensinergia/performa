# encoding: utf-8
require 'subdomain_guards'
class AreasController < ApplicationController
  include UserAssociationsHelper
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  before_filter :get_company_users, :only => [:new, :edit]
  
  def new
    @area = Area.new
  end
  
  def create
    @area = Area.new_with_company(params[:area], current_company)
    
    if @area.save
      @area.notify_to(params[:users])
      redirect_to people_path, :notice => I18n.t('views.common.messages.save.successful', :model => "Área", :genre => "a")
    else
      @users = current_company.users
      render :action => :new
    end
  end
  
  def edit
    @area = Area.find(params[:id])
  end
  
  def update
    @area = Area.find(params[:id])
    
    if @area.update_attributes(params[:area])
      @area.notify_to(params[:users])
      redirect_to people_path, :notice => I18n.t('views.common.messages.update.successful', :model => "Área", :genre => "a")
    else
      @users = current_company.users
      render :action => :edit
    end
  end
  
  def admin
    @area = Area.first(:conditions => { :company_id => current_company.id, :is_root_area => true})
    @people = User.all(:conditions => { :company_id => current_company.id })
  end
  
  private
  def get_company_users
    @users = current_company.users
  end
end