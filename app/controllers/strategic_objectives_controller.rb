#encoding: utf-8
require 'subdomain_guards'
class StrategicObjectivesController < ActionController::Base
  include SubdomainGuards
  include UserAssociationsHelper
  layout 'application'
  
  before_filter :verify_subdomain
  
  def index
    @strategic_objectives = current_company.strategic_objectives

    @strategic_objectives.blank? ? render('index_welcome') : render('index')
  end

  def new
    @strategic_objective = StrategicObjective.new
  end

  # GET /strategic_objectives/1/edit
  def edit
    @strategic_objective = StrategicObjective.find(params[:id])
  end

  def create
    @strategic_objective = StrategicObjective.new_with_user(params[:strategic_objective], current_user)
    
    if @strategic_objective.save
      @strategic_objective.notify_to(params[:users])
      redirect_to strategic_objectives_path, :notice => I18n.t('views.common.messages.save.successful', :model => "Objectivos Estratégicos", :genre => "o")
    else
      render :action => 'new'
    end
  end

  def update
    @strategic_objective = StrategicObjective.find(params[:id])
    
    if @strategic_objective.update_attributes(params[:strategic_objective])
      @strategic_objective.notify_to(params[:users])
      
      redirect_to strategic_objectives_path, :notice => I18n.t('views.common.messages.update.successful', :model => "Objetivos Estratégicos", :genre => "o")
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
