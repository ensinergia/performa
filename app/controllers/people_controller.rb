require 'subdomain_guards'
class PeopleController < ApplicationController
  include UserAssociationsHelper
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  
  def index
    @company = current_company
    @areas = Area.get_all_for(current_company)
    
    if @areas.empty?
      render('index_welcome')
    else
      render('index')
    end
  end
  
end
