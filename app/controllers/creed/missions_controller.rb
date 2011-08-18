require 'subdomain_guards'
class Creed::MissionsController < ActionController::Base
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  
  def index
  end
  
  def new
  end
  
end