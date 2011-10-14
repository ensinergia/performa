#encoding: utf-8
class Creed::WarCriesController < ActionController::Base
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  
  def index
    @war_cry = WarCry.get_current(current_user.company)

    unless @war_cry.nil?
      render :action => 'show'
      return
    end
    render :layout => 'application_index_page'
    
  end
  
  def new
    @war_cry = WarCry.new
  end
  
  def create
    @war_cry = WarCry.new_with_user(params[:war_cry], current_user)
    
    if @war_cry.save
      @war_cry.notify_to(params[:users])
      redirect_to creed_war_cries_path, :notice => I18n.t('views.common.messages.save.successful', :model => I18n.t('activerecord.models.war_cry'), :genre => "o")
    else
      render(:action => 'new')
    end
  end
  
  def show
    @war_cry = WarCry.find(params[:id], :include => {:comments => [:attachments]})
  end
  
  def edit
    @war_cry = WarCry.find(params[:id])
  end
  
  def update
    @war_cry = WarCry.find(params[:id])
    
    if @war_cry.update_attributes(params[:war_cry])
      @war_cry.notify_to(params[:users])
      redirect_to creed_war_cries_path, :notice => I18n.t('views.common.messages.update.successful', :model => I18n.t('activerecord.models.war_cry'), :genre => "o")
    else
      render(:action => 'edit')
    end
  end
  
end