require 'subdomain_guards'
class StrategicLinesController < ActionController::Base
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  
  def index
  end
  
end