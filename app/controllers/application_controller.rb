class ApplicationController < ActionController::Base
  protect_from_forgery
  include UrlHelper

  before_filter :default_area_selected
  before_filter :get_area_access

  def after_sign_in_path_for(resource)
    panorama_url(:subdomain => current_user.subdomain)
  end

  def after_sign_out_path_for(resource)
    root_url(:subdomain => false)
  end

  def default_area_selected

    unless current_user.nil?

      if session[:area_id].nil?
        session[:area_id]=current_user.area_id
      end   


      if session[:main_area_id].nil?
        mainarea=Area.where(:company_id=>current_user.company_id, :is_root_area=>true).order('id ASC').first
        session[:main_area_id]=mainarea.id
      end 

    end

  end   
  
  
  def get_area_access
    unless current_user.nil?
      if @areas_allowed.nil?
        @children=[]
        area=current_user.area
        @children<<area.id
        deep_children(area)
        @areas_allowed=Area.where("id IN (?)",@children) || []
      end
       @root_area = Area.get_all_for(current_user.company).where(:is_root_area=>true).first
       @selected_area = Area.find(session[:area_id])
    end
   
  end 


  def deep_children(tarea)
    supports=@children.count==1 ? AreaSupport.where("supported_id=(?)", tarea.id)  : AreaSupport.where("supported_id=(?) and  supported_id NOT IN (?)", tarea.id.to_s, @children) 
    supports.each do |supp|
      narea=supp.area
      @children<<narea.id
      deep_children(narea)
    end  
  end   


end
