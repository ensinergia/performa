class Creed::MissionsController < ActionController::Base
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  
  def index
    @mission = Mission.get_current(current_user.company)

    unless @mission.nil?
      render :action => 'show'
      return
    end
  end
  
  def new
    @mission = Mission.new
  end
  
  def create
    @mission = Mission.new_with_user(params[:mission], current_user)
    
    if @mission.save
      @mission.notify_to(params[:users])
      redirect_to creed_missions_path, :notice => I18n.t('views.creed.create_mission.successful_save')
    else
      render(:action => 'new')
    end
  end
  
  def show
    @mission = Mission.find(params[:id], :include => {:comments => [:attachments]})
  end
  
  def edit
    @mission = Mission.find(params[:id])
  end
  
  def update
    @mission = Mission.find(params[:id])
    
    if @mission.update_attributes(params[:mission])
      @mission.notify_to(params[:users])
      redirect_to creed_missions_path, :notice => I18n.t('views.creed.update_mission.successful_save')
    else
      render(:action => 'edit')
    end
  end
  
end