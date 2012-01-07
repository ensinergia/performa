class ProjectsController < ApplicationController
  
  def index
    ##@cicles = OperatingCycle.get_all_for(current_company)
    ##@cicles.empty? ? render('welcome', :layout => 'application_index_page') : render('index')
    render('welcome', :layout => 'application_index_page')
  
  end
    
end
