#encoding: utf-8
require 'subdomain_guards'
class StrategicLinesController < ApplicationController
  include StrategicLinesControllerHelper
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  before_filter :strategic_objectives, :only => [:new, :edit]
  
  
  def index
    
    @strategic_lines = @selected_area==@root_area ? StrategicLine.get_all_for(current_company).where(:area_id=>nil,:area_id=>@root_area.id ) : StrategicLine.get_all_for(current_company).where(:area_id=>session[:area_id])
    
    @strategic_lines.blank? ? render('index_welcome', :layout => 'application_index_page') : render('index')
  end
  
  def new
    @strategic_line = StrategicLine.new
  end
  
  def edit
    @strategic_line = StrategicLine.find(params[:id])
  end
  
  def create
    @strategic_line = StrategicLine.new_with_user(params[:strategic_line], current_user)
    
    if @strategic_line.save
      @strategic_line.notify_to(params[:users])
      redirect_to strategic_lines_path, :notice => I18n.t('views.common.messages.save.successful', :model => "Líneas Estratégicas", :genre => "as")
    else
      strategic_objectives
      render :action => 'new'
    end
  end
  
  def update
    @strategic_line = StrategicLine.find(params[:id])
    
    if @strategic_line.update_attributes(params[:strategic_line])
      @strategic_line.notify_to(params[:users])
      
      redirect_to strategic_lines_path, :notice => I18n.t('views.common.messages.update.successful', :model => "Líneas Estratégicas", :genre => "as")
    else
      strategic_objectives
      render :action => 'edit'
    end
  end
  
  def destroy
    @strategic_line = StrategicLine.find(params[:id])
    @strategic_line.destroy

    respond_to do |format|
      format.html { redirect_to(strategic_lines_url) }
    end
  end
  
  
  def strategic_objectives
      @strategic_objectives = @selected_area.alevel==1 ? StrategicObjective.get_all_for(current_company).where(:area_id=>session[:area_id]) : StrategicObjective.get_all_for(current_company).where(:area_id=>nil,:area_id=>@root_area.id )
  end
  
end