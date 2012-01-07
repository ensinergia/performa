require 'subdomain_guards'
class PanoramasController < ActionController::Base
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  
  def index
    session['area_id']=='' || session[:area_id].to_s==session[:main_area_id].to_s  ? render( :layout => 'application_index_page') : render('index_area',:layout => 'application_index_page')
  end
  
end