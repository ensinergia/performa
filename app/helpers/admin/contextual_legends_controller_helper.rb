#encoding: utf-8
require 'subdomain_guards'

module Admin::ContextualLegendsControllerHelper
  include UserAssociationsHelper
  include SubdomainGuards
  
  def last_route
    route = { :url => session[:last_route] }
    session[:last_route] = nil
    route
  end
end
