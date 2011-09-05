require 'subdomain_guards'
class Swot::AnalysesController < ActionController::Base
  include AnalysisControllerHelper
  
  layout 'application'
  
  before_filter :verify_subdomain
  before_filter :get_internals, :only => [:index, :internals]
  
  def index
    render_main_analyses_template && return unless (@weaknesses.empty? && @strengths.empty?)
    render(:template => 'swot/index')
  end
  
  def externals
    externals = Swot.get_externals_for(current_company)
    @risks = externals[:risks] || []
    @opportunities = externals[:opportunities] || []
    render :template => 'swot/external_analyses'
  end
  
  def internals
    render_main_analyses_template
  end
  
  def create
    @analysis=Analysis.new_with_user(params[:analysis], current_user)
    
    if @analysis.save
      notice = flash_message_for(@analysis)
      
      redirect_to(internal_swot_analyses_path, :notice => notice) && return if @analysis.is_internal?
      redirect_to(external_swot_analyses_path, :notice => notice)
    else 
      redirect_to(internal_swot_analyses_path, :alert => I18n.t('views.swot.shared_views.add.unsuccessful_save')) && return if @analysis.is_internal?
      redirect_to(external_swot_analyses_path, :alert => I18n.t('views.swot.shared_views.add.unsuccessful_save'))
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
    @analysis = tmp_analysis =Analysis.find(params[:id])
    @analysis.destroy
    
    
    tmp_analysis.is_internal? ?  redirect_to(internal_swot_analyses_path) : redirect_to(external_swot_analyses_path)
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