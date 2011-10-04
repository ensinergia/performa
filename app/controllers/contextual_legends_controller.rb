#encoding: utf-8
require 'subdomain_guards'

class ContextualLegendsController < ActionController::Base
  include UserAssociationsHelper
  include SubdomainGuards
  
  layout 'application'
  
  def show
    @contextual_legend = ContextualLegend.find(:first, :conditions => {:url => params[:route]})
    session[:last_route] = params[:route]
    
    respond_to do |format|
      format.js
    end
  end
end