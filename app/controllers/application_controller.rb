class ApplicationController < ActionController::Base
  protect_from_forgery
  include UrlHelper

  before_filter :default_area_selected


  def after_sign_in_path_for(resource)
    panorama_url(:subdomain => current_user.subdomain)
  end

  def after_sign_out_path_for(resource)
    root_url(:subdomain => false)
  end

  def default_area_selected

    unless current_user.nil?

      if session[:area_id].nil?
        session[:area_id]=''
      end   


      if session[:main_area_id].nil?
        mainarea=Area.where(:company_id=>current_user.company_id).order('id ASC').first
        session[:main_area_id]=mainarea.id
      end 

    end

  end   

end
