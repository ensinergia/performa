#encoding: utf-8
require 'subdomain_guards'
class PointersController < ApplicationController

  include SubdomainGuards
  include UserAssociationsHelper
  layout 'application'

  before_filter :verify_subdomain
  before_filter :load_var, :only=>[:new, :edit,:updategrid] 

  def new
    @pointer = Pointer.new
  end

  # GET /operative_objectives/1/edit
  def edit
    @pointer = Pointer.find(params[:id])
  end

  def create
    @pointer = Pointer.new(params[:pointer])
    @pointer.thresholds="#{params[:umb2]},#{params[:umb4]}"
    if @pointer.save
      @pointer.notify_to(params[:users])
      redirect_to(operative_objectives_url)
    else
      render :action => 'new'
    end
  end

  def update
    @pointer = Pointer.find(params[:id])
    @pointer.thresholds="#{params[:umb2]},#{params[:umb4]}"
    if @pointer.update_attributes(params[:pointer])
        @pointer.goals=serialize(params[:pointer][:goals])
        @pointer.results=serialize(params[:pointer][:results])
        @pointer.save
      @pointer.notify_to(params[:users])
      redirect_to(operative_objectives_url)
    else
      render :action => 'edit'
    end
  end

  def destroy

    @pointer = Pointer.find(params[:id])
    @pointer.destroy

    respond_to do |format|
      format.html { redirect_to(operative_objectives_url) }
    end
  end


  def updategrid
    render :partial=>"goal", :locals=>{:init_month=>params[:init_date].to_time.month, :period=>params[:period].to_i, :months=>@months, :advance_type=>params[:advance_type], :results=>[],:goals=>[], :year=>params[:init_date].to_time.year} 
  end  

  def load_var
    @months=[]
    @months[1]="jan"
    @months[2]="feb"
    @months[3]="mar"
    @months[4]="apr"
    @months[5]="may"
    @months[6]="jun"
    @months[7]="jul"
    @months[8]="aug"
    @months[9]="sep"
    @months[10]="oct"
    @months[11]="nov"
    @months[12]="dic"
  end  


  def serialize(obj)
    str=""
    obj.each_with_index do |o,index|
      str+=o[1]
      unless index==obj.count-1
      str+=","  
      end
    end
    str
  end  


end
