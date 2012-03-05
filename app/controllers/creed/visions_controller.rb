class Creed::VisionsController < ApplicationController
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  
  def index
    @vision = Vision.get_current(current_user.company)

    unless @vision.nil?
      render :action => 'show'
      return
    end
    render :layout => 'application_index_page'
    
  end
  
  def new
    @vision = Vision.new
  end
  
  def create
    @vision = Vision.new_with_user(params[:vision], current_user)
    
    if @vision.save
      @vision.notify_to(params[:users])
      redirect_to creed_visions_path, :notice => I18n.t('views.common.messages.save.successful', :model => I18n.t('activerecord.models.vision'), :genre => "a")
    else
      render(:action => 'new')
    end
  end
  
  def show
    @vision = Vision.find(params[:id], :include => {:comments => [:attachments]})
  end
  
  def edit
    @vision = Vision.find(params[:id])
  end
  
  def update
    @vision = Vision.find(params[:id])
    
    if @vision.update_attributes(params[:vision])
      @vision.notify_to(params[:users])
      redirect_to creed_visions_path, :notice => I18n.t('views.common.messages.update.successful', :model => I18n.t('activerecord.models.vision'), :genre => "a")
    else
      render(:action => 'edit')
    end
  end
  
end