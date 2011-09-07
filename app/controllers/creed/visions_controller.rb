class Creed::VisionsController < ActionController::Base
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  
  def index
    @vision = Vision.get_current(current_user.company)

    unless @vision.nil?
      render :action => 'show'
      return
    end
  end
  
  def new
    @vision = Vision.new
  end
  
  def create
    @vision = Vision.new_with_user(params[:vision], current_user)
    
    if @vision.save
      @vision.notify_to(params[:users])
      redirect_to creed_visions_path, :notice => I18n.t('views.creed.create_vision.successful_save')
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
      redirect_to creed_visions_path, :notice => I18n.t('views.creed.update_vision.successful_save')
    else
      render(:action => 'edit')
    end
  end
  
end