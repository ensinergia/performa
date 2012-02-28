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
    @objectives = OperativeObjective.get_all_for(session[:area_id])  
    file=Zipped.new
    @xml=file.update(@objectives) 
    buffer=''
    Zip::Archive.open_buffer(buffer, Zip::CREATE) do |archive|
         path="#{Rails.root}/public/docx/template/*"
         base="#{Rails.root}/public/docx/template/"
         follow_dir(path,base,archive)
         
    end 
    file_name = "export.docx"
    send_data buffer, :type => 'application/docx', :disposition => 'attachment', :filename => file_name

  end

  def follow_dir(path,base,archive)
    Dir[path].each_with_index do |fl,i|
      if fl.include?("template/_rels")
        add_buffer(archive,base,base+"_rels/.rels")
      end  
      if File.directory?(fl)
        follow_dir(fl+"/*",base,archive)
      else  
        add_buffer(archive,base,fl)
      end  
      
    end
  end  

  def add_buffer(archive,base,fl)
        txt=""
        file_name=fl.gsub(base,"")
          File.open(fl, "r") do  |f|
            txt+=f.read
          end
          if file_name.include?("word/document.xml")
              txt=@xml
          end    
          archive.add_buffer(file_name,txt)
  end  


  private
  def users
    area=Area.find(session[:area_id])
    @users = area.users
  end

  def strategic_lines
    @strategic_lines = current_company.strategic_lines
  end


end
