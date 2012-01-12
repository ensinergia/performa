#encoding: utf-8
require 'subdomain_guards'
class PointersController < ApplicationController
  
  include SubdomainGuards
  include UserAssociationsHelper
  layout 'application'
  
  before_filter :verify_subdomain
 
  def new
    @pointer = Pointer.new
  end

  # GET /operative_objectives/1/edit
  def edit
    @pointer = Pointer.find(params[:id])
  end

  def create
    @pointer = Pointer.new(params[:pointer])
    if @pointer.save
      @pointer.notify_to(params[:users])
      redirect_to operative_objectives_path, :notice => I18n.t('views.common.messages.save.successful', :model => "Pointer", :genre => "os")
    else
      render :action => 'new'
    end
  end

  def update
    @pointer = Pointer.find(params[:id])

    if @pointer.update_attributes(params[:pointer])
      @pointer.notify_to(params[:users])

      redirect_to operative_objectives_path, :notice => I18n.t('views.common.messages.update.successful', :model => "Pointer", :genre => "os")
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
  
  
 
  
  
end
