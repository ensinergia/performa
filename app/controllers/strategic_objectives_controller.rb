#encoding: utf-8
require 'subdomain_guards'
class StrategicObjectivesController < ApplicationController
  include SubdomainGuards
  include UserAssociationsHelper
  layout 'application'

  before_filter :verify_subdomain

  def index
    @strategic_objectives = @selected_area==@root_area ? StrategicObjective.get_all_for(current_company).where(:area_id=>nil,:area_id=>@root_area.id ) : StrategicObjective.get_all_for(current_company).where(:area_id=>session[:area_id])

    @strategic_objectives.blank? ? render('index_welcome', :layout => 'application_index_page') : render('index')
  end

  def new
    @strategic_objective = StrategicObjective.new
    if @selected_area.alevel==1
      @strategic_lines=@root_area.strategic_lines
    end  
  end

  # GET /strategic_objectives/1/edit
  def edit
    
    @strategic_objective = StrategicObjective.find(params[:id])
    if @selected_area.alevel==1
      @strategic_lines=@root_area.strategic_lines
    end 
  end

  def create
    @strategic_objective = StrategicObjective.new_with_user(params[:strategic_objective], current_user)

    if @strategic_objective.save
      @strategic_objective.notify_to(params[:users])
      redirect_to strategic_objectives_path, :notice => I18n.t('views.common.messages.save.successful', :model => "Objetivos Estratégicos", :genre => "os")
    else
      render :action => 'new'
    end
  end

  def update
    @strategic_objective = StrategicObjective.find(params[:id])

    if @strategic_objective.update_attributes(params[:strategic_objective])
      @strategic_objective.notify_to(params[:users])

      redirect_to strategic_objectives_path, :notice => I18n.t('views.common.messages.update.successful', :model => "Objetivos Estratégicos", :genre => "os")
    else
      render :action => 'edit'
    end
  end

  def destroy
    @strategic_objective = StrategicObjective.find(params[:id])
    @strategic_objective.destroy

    respond_to do |format|
      format.html { redirect_to(strategic_objectives_url) }
    end
  end

end
