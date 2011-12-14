#encoding: utf-8
require 'subdomain_guards'

class OperatingCyclesController < ApplicationController
  include StrategicLinesControllerHelper
  include SubdomainGuards
  layout 'application'
  
  before_filter :verify_subdomain
  before_filter :strategic_lines, :only => :new
  
  def new
    @operating_cycle = OperatingCycle.new
  end
  
  private
  def strategic_lines
    @strategic_lines = current_company.strategic_lines
  end
end
