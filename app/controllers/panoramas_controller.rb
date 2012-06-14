require 'subdomain_guards'
class PanoramasController < ApplicationController
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  
  def index
    if session['area_id']=='' || session[:area_id].to_s==session[:main_area_id].to_s  
          render( :layout => 'application_index_page') 
    else      
       if @selected_area.alevel==1
         render('index_inter',:layout => 'application_index_page')
        else
          render('index_area',:layout => 'application_index_page')
        end   
   end
  end
  
end