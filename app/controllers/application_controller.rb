class ApplicationController < ActionController::Base
  protect_from_forgery
  include UrlHelper
  
  def after_sign_in_path_for(resource)
    panorama_url(:subdomain => current_user.domain)
  end
  
  def after_sign_out_path_for(resource)
    root_url(:subdomain => false)
  end

end
