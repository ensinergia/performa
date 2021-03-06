#encoding: utf-8
require 'subdomain_guards'

class ProjectsController < ApplicationController
  include StrategicLinesControllerHelper
  include SubdomainGuards
  layout 'application'

  before_filter :verify_subdomain
  before_filter :users, :only => [:new, :edit]
  before_filter :objectives, :only => [:new, :edit, :update, :create]
  before_filter :find_project, :except =>  [:new, :create, :index, :childs]


  def index
    @projects = Project.get_all_for(session[:area_id])
    @projects.empty? ? render('welcome', :layout => 'application_index_page') : render('index',:layout => 'twocolumns')

  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(params[:project])
   
    if @project.save
      @project.notify_to(params[:users])
      redirect_to(area_projects_url(session[:area_id]))
    else
      strategic_lines
      render :action => 'new'
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      @project.notify_to(params[:users])

      redirect_to(area_projects_url(session[:area_id]))
    else
      render :action => 'edit'
    end

  end

  def show
  end

  def destroy
    @project.destroy
    redirect_to(area_projects_url(session[:area_id]))

  end

  def childs
    render :partial => "projects/children/child_#{params[:ptype]}", :layout=>false
  end  

  private
  def users
    area=Area.find(session[:area_id])
    @users = area.users
  end
  
  def objectives
    area=Area.find(session[:area_id])
    @objectives = area.operative_objectives
    @sibling_areas = Area.where(:parent_id=>@selected_area.parent_id)
  end

  def find_project
    @project = Project.find(params[:id])
  end
end #End Controller 
