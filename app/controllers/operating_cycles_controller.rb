#encoding: utf-8
require 'subdomain_guards'

class OperatingCyclesController < ApplicationController
  include StrategicLinesControllerHelper
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  before_filter :strategic_lines, :only => :new
  before_filter :find_operating_cycle, :except =>  [:new, :create, :index]
  
  def new
    @operating_cycle = OperatingCycle.new
  end
  
  def create
    @operating_cycle = OperatingCycle.new_with_user(params[:operating_cycle], current_user)
    if @operating_cycle.save
      @operating_cycle.notify_to(params[:users])
      redirect_to operating_cycles_path, :notice => I18n.t('views.common.messages.save.successful', :model => "Ciclos Operativos", :genre => "as")
    else
      strategic_lines
      render :action => 'new'
    end
  end
  
  def update
    
  end
  
  def show
  end
  
  private
  def strategic_lines
    @strategic_lines = current_company.strategic_lines
  end
  
  def find_operating_cycle
    @operating_cycle = OperatingCycle.find(params[:id])
  end
end #End Controller 
