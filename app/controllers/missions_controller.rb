require 'subdomain_guards'
class MissionsController < ActionController::Base
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  
  def index
  end
  
end