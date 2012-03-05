#encoding: utf-8
require 'subdomain_guards'
class Swot::AnalysesController < ApplicationController
  include AnalysisControllerHelper
  
  layout 'application'
  
  before_filter :verify_subdomain
  before_filter :get_internals, :only => [:index, :internals]
  
  def index
    render_main_analyses_template && return unless (@weaknesses.empty? && @strengths.empty?)
    render(:template => 'swot/index', :layout => 'application_index_page')
  end
  
  def externals
    externals = Swot.get_externals_for(current_company)
    @risks, @opportunities = (externals[:risks] || []), (externals[:opportunities] || [])

    render :template => 'swot/external_analyses'
  end
  
  def internals
    render_main_analyses_template
  end
  
  def create
    @analysis=Analysis.new_with_user(params[:analysis], current_user)
    
    if @analysis.save      
      redirect_to(url_for_analysis(@analysis), :notice => flash_notice_for(@analysis, :on_save)) 
    else       
      redirect_to(url_for_analysis(@analysis), :alert => flash_alert_for(@analysis, :on_save))
    end
  end
  
  def update
    @analysis = Analysis.find(params[:id])
    @analysis.update_attributes(params[:analysis])
    
    respond_to do |format|
      format.js { render :text => @analysis.content }
    end
  end
  
  def destroy
    @analysis = Analysis.find(params[:id])
    analysis_was_internal = @analysis.is_internal?
    @analysis.destroy
    
    
    analysis_was_internal ?  redirect_to(internal_swot_analyses_path) : redirect_to(external_swot_analyses_path)
  end
  
  private
  def render_main_analyses_template
    render :template => 'swot/internal_analyses'
  end
  
  def get_internals
    internals = Swot.get_internals_for(current_company)
    @weaknesses = internals[:weaknesses] || []
    @strengths = internals[:strengths] || []
  end
end