#encoding: utf-8
require 'subdomain_guards'

class ContextualLegendsController < ActionController::Base
  include UserAssociationsHelper
  include SubdomainGuards
  
  layout 'application'
  
  def show
    rootpth=root_url.chop
    route= params[:route].split("#")[0]
    route=ActionController::Routing::Routes.recognize_path rootpth+route
    
    ##@contextual_legend = ContextualLegend.new(:url=>route[:action]=="index" ? "/"+route[:controller] : "/"+route[:controller]+"/"+route[:action])
			unless params[:id].nil?
				@origin_route=params[:route]
				@route=@origin_route.gsub(params[:id]+"/", "")
			else
				@origin_route=params[:route]
				@route=@origin_route
			end		
		@contextual_legend = ContextualLegend.find(:first, :conditions => {:url => route[:action]=="index" ? "/"+route[:controller] : "/"+route[:controller]+"/"+route[:action]})
		
			
    respond_to do |format|
      format.js
    end
  end
end