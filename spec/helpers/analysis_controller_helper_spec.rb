#encoding: utf-8
require 'spec_helper'

describe AnalysisControllerHelper do
  
  before(:each) do
    @s=Factory(:strength)
    @w=Factory(:weakness, :swot => @s.swot)
    @o=Factory(:opportunity, :swot => @s.swot)
    @r=Factory(:risk, :swot => @s.swot)
  end
  
  it "should print the correct message notice for each given analysis" do
    flash_notice_for(@w, :on_save).should == I18n.t('views.common.messages.save.successful', :model => "Debilidad", :genre => "a")
    flash_notice_for(@s, :on_save).should == I18n.t('views.common.messages.save.successful', :model => "Fortaleza", :genre => "a")
    flash_notice_for(@o, :on_save).should == I18n.t('views.common.messages.save.successful', :model => "Oportunidad", :genre => "a")
    flash_notice_for(@r, :on_save).should == I18n.t('views.common.messages.save.successful', :model => "Riesgo", :genre => "o")
  end
  
  it "should print the correct message alert for each given analysis" do
    flash_alert_for(@w, :on_save).should == I18n.t('views.common.messages.save.unsuccessful', :model => "Debilidad", :connector => "ésta")
    flash_alert_for(@s, :on_save).should == I18n.t('views.common.messages.save.unsuccessful', :model => "Fortaleza", :connector => "ésta")
    flash_alert_for(@o, :on_save).should == I18n.t('views.common.messages.save.unsuccessful', :model => "Oportunidad", :connector => "ésta")
    flash_alert_for(@r, :on_save).should == I18n.t('views.common.messages.save.unsuccessful', :model => "Riesgo", :connector => "éste")
  end
end
