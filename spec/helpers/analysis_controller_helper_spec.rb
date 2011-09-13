require 'spec_helper'

describe AnalysisControllerHelper do
  
  before(:each) do
    @s=Factory(:strength)
    @w=Factory(:weakness, :swot => @s.swot)
    @o=Factory(:opportunity, :swot => @s.swot)
    @r=Factory(:risk, :swot => @s.swot)
  end
  
  it "should print the correct message for each given analysis" do
    flash_message_for(@w).should == I18n.t('views.swot.internal_view.weaknesses.add.successful_save')
    flash_message_for(@s).should == I18n.t('views.swot.internal_view.strengths.add.successful_save')
    flash_message_for(@o).should == I18n.t('views.swot.external_view.opportunities.add.successful_save')
    flash_message_for(@r).should == I18n.t('views.swot.external_view.risks.add.successful_save')
  end
end
