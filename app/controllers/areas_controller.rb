# encoding: utf-8
require 'subdomain_guards'
class AreasController < ApplicationController
  include UserAssociationsHelper
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  before_filter :get_company_users, :only => [:new, :edit]
  before_filter :get_areas, :only => [:new, :edit, :create, :update]
  before_filter :check_permissions , :only=>[:new,:edit,:create,:uptade,:admin]
  
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
  
  def select
    session['area_id']=params['area_id'] || current_user.area_id
    redirect_to panorama_path
  end
  
  
  private
  def get_company_users
    @users = current_company.users
  end
  
  def get_areas
    @main=current_company.areas.first
    if params[:id]
      @areas = current_company.areas.where("id!=?",params[:id])
    else
      @areas = current_company.areas
    end  
  end
  
  def check_permissions
    (!current_user.is_admin? && !current_user.is_owner?) ? redirect_to(people_path, :notice => I18n.t('views.people.access_denied')) : true
  end
  
end
