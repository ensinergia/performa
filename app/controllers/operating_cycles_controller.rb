#encoding: utf-8
require 'subdomain_guards'

class OperatingCyclesController < ApplicationController
  include StrategicLinesControllerHelper
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  before_filter :strategic_lines, :only => [:new, :edit]
  before_filter :find_operating_cycle, :except =>  [:new, :create, :index]
  
  
  def index
    @operating_cycles = OperatingCycle.get_all_for(session[:area_id])
    @operating_cycles.empty? ? render('welcome', :layout => 'application_index_page') : render('index')
    
  end
  
  def new
    @operating_cycle = OperatingCycle.new
  end
  
  def edit
  end
  
  def create
    @operating_cycle = OperatingCycle.new_with_user(params[:operating_cycle], current_user)
    params[:operating_cycle][:clients_attributes].each  do |client| 
      @operating_cycle.clients.build(:name=>client[1][:name])
    end
    params[:operating_cycle][:stages_attributes].each  do |stage| 
      @operating_cycle.stages.build(:name=>stage[1][:name])
    end
    
    if @operating_cycle.save
      @operating_cycle.notify_to(params[:users])
      redirect_to edit_operating_cycle_path(@operating_cycle.id)
    else
      strategic_lines
      render :action => 'new'
    end
  end
  
  def update
     @operating_cycle = OperatingCycle.find(params[:id])

      if @operating_cycle.update_attributes(params[:operating_cycle])
        @operating_cycle.notify_to(params[:users])

        redirect_to operating_cycles_path, :notice => I18n.t('views.common.messages.update.successful', :model => "Objetivos Operativos", :genre => "os")
      else
        render :action => 'edit'
      end
    
  end
  
  def show
  end
  
  def destroy
    @operating_cycle.destroy
    redirect_to(area_operating_cycles_url(session[:area_id]))
    
  end
  
  private
  def strategic_lines
    @strategic_lines = current_company.strategic_lines
  end
  
  def find_operating_cycle
    @operating_cycle = OperatingCycle.find(params[:id])
  end
end #End Controller 
