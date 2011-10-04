# encoding: utf-8
require 'subdomain_guards'
class AreasController < ApplicationController
  include UserAssociationsHelper
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  
  def new
    @area = Area.new
  end
  
  def create
    @area = Area.new_with_company(params[:area], current_company)
    
    if @area.save
      @area.notify_to(params[:users])
      redirect_to people_path, :notice => I18n.t('views.common.messages.save.successful', :model => "Área", :genre => "a")
    else
      render :action => :new
    end
  end
end
