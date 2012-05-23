#encoding: utf-8
class Admin::ContextualLegendsController < ApplicationController
  include Admin::ContextualLegendsControllerHelper
  layout 'admin'
  
  before_filter :verify_subdomain
  
  def index
  end
  
  def new
    rootpth=root_url.chop
    route=ActionController::Routing::Routes.recognize_path rootpth+params[:route]
    @contextual_legend = ContextualLegend.new(:url=>route[:action]=="index" ? "/"+route[:controller] : "/"+route[:controller]+"/"+route[:action])
  end
  
  def edit
    @contextual_legend = ContextualLegend.find(params[:id])
  end
  
  def create
    @contextual_legend = ContextualLegend.new(params[:contextual_legend])
    if @contextual_legend.save

      redirect_to params[:origin_route], :notice => I18n.t('views.common.messages.save.successful', 
                                          :model => t("activerecord.models.contextual_legend"), :genre => "a")
    else
      render :action => 'new'
    end
  end
  
  def update
    @contextual_legend = ContextualLegend.find(params[:id])
    
    if @contextual_legend.update_attributes(params[:contextual_legend])
      redirect_to params[:origin_route], :notice => I18n.t('views.common.messages.update.successful', 
                                          :model => t("activerecord.models.contextual_legend"), :genre => "a")
    else
      render :action => 'edit'
    end
  end

end