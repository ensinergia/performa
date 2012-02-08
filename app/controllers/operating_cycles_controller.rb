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
    @operating_cycles.empty? ? render('welcome', :layout => 'application_index_page') : render('index',:layout => 'twocolumns')

  end

  def new
    @operating_cycle = OperatingCycle.new
  end

  def edit
    code = 'digraph G{subgraph cluster_0 {style=filled;color=lightgrey;node [style=filled,color=white];ya -> me -> sa;label = "Etapa 1 ";}subgraph cluster_1 {node [style=filled]; Ñ -> w -> D ;label = "Etapa 2 ";color=blue}Inicio -> ya;Inicio -> Ñ; me -> D;w -> sa;sa -> ya;sa -> Producto;D -> Producto; [shape=Mdiamond]; [shape=Msquare];}'
    @url_img="http://localhost:9000/graph/dot.svg?data=#{CGI::escape code}"
  end

  def create
    @operating_cycle = OperatingCycle.new_with_user(params[:operating_cycle], current_user)
   
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

      redirect_to edit_operating_cycle_path(@operating_cycle), :notice => I18n.t('views.common.messages.update.successful', :model => "Objetivos Operativos", :genre => "os")
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
