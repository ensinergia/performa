require 'subdomain_guards'
class Swot::CommentsController < ActionController::Base
  include SubdomainGuards
  
  layout 'application'
  
  before_filter :verify_subdomain
  
  def index
    @analysis = Analysis.find(params[:analysis_id], :include => [:comments])
  end
  
end