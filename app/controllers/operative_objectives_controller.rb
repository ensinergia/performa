#encoding: utf-8
require 'subdomain_guards'
require 'word_update'
class OperativeObjectivesController < ApplicationController

  include SubdomainGuards
  include UserAssociationsHelper
  layout 'application'

  before_filter :strategic_lines, :only => [:new,:edit]
  before_filter :verify_subdomain
  before_filter :users, :only => [:new, :edit]

  def index
    @objectives = OperativeObjective.get_all_for(session[:area_id])
    @objectives.empty? ? render('welcome', :layout => 'application_index_page') : render('index')

  end

  def new
    @operative_objective = OperativeObjective.new
  end

  # GET /operative_objectives/1/edit
  def edit
    @operative_objective = OperativeObjective.find(params[:id])
  end

  def create
    @operative_objective = OperativeObjective.new(params[:operative_objective])
    if @operative_objective.save
      @operative_objective.notify_to(params[:users])
      redirect_to operative_objectives_path, :notice => I18n.t('views.common.messages.save.successful', :model => "Objetivos Operativos", :genre => "os")
    else
      render :action => 'new'
    end
  end

  def update
    @operative_objective = OperativeObjective.find(params[:id])

    if @operative_objective.update_attributes(params[:operative_objective])
      @operative_objective.notify_to(params[:users])

      redirect_to operative_objectives_path, :notice => I18n.t('views.common.messages.update.successful', :model => "Objetivos Operativos", :genre => "os")
    else
      render :action => 'edit'
    end
  end


  def order
    order=params[:or].split(',')
    params[:model].constantize.setorder(order)
    render :nothing => true
  end  


  def destroy

    @operative_objective = OperativeObjective.find(params[:id])
    @operative_objective.destroy

    respond_to do |format|
      format.html { redirect_to(operative_objectives_url) }
    end
  end


  def export
    @objectives =OperativeObjective.get_all_for(session[:area_id])  
    file=Zipped.new
    buffer=''
    Zip::Archive.open_buffer(buffer, Zip::CREATE) do |archive|
         path="#{Rails.root}/public/docx/template/*"
         base="#{Rails.root}/public/docx/template/"
         file.follow_dir(path,base,archive,@objectives)
         
    end 
    file_name = "export.docx"
    send_data buffer, :type => 'application/docx', :disposition => 'attachment', :filename => file_name

  end

  


  private
  def users
    area=Area.find(session[:area_id])
    @users = area.users
  end

  def strategic_lines
    @strategic_lines = StrategicLine.get_all_for(current_company).where(:area_id=>@selected_area.parent_id)
  end


end
