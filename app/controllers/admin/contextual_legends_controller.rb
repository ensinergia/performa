#encoding: utf-8
class Admin::ContextualLegendsController < ApplicationController
  include Admin::ContextualLegendsControllerHelper
  layout 'admin'
  
  before_filter :verify_subdomain
  
  def index
  end
  
  def new
    @contextual_legend = ContextualLegend.new
  end
  
  def edit
    @contextual_legend = ContextualLegend.find(params[:id])
  end
  
  def create
    @contextual_legend = ContextualLegend.new(params[:contextual_legend].merge(last_route))
    
    if @contextual_legend.save
      redirect_to @contextual_legend.url, :notice => I18n.t('views.common.messages.save.successful', 
                                          :model => t("activerecord.models.contextual_legend"), :genre => "a")
    else
      render :action => 'new'
    end
  end
  
  def update
    @contextual_legend = ContextualLegend.find(params[:id])
    
    if @contextual_legend.update_attributes(params[:contextual_legend])
      redirect_to @contextual_legend.url, :notice => I18n.t('views.common.messages.update.successful', 
                                          :model => t("activerecord.models.contextual_legend"), :genre => "a")
    else
      render :action => 'edit'
    end
  end

end