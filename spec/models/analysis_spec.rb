require 'spec_helper'

describe Analysis do
  
  it "should tell if it's a weakness" do
    analysis=Factory(:weakness)
    analysis.should be_weakness
  end
  
  it "should tell if it's a strength" do
    analysis=Factory(:strength)
    analysis.should be_strength
  end
  
  it "should tell if it's an opportunity" do
    analysis=Factory(:opportunity)
    analysis.should be_opportunity
  end
  
  it "should tell if it's a risk" do
    analysis=Factory(:risk)
    analysis.should be_risk
  end
  
  it "should instantiate a new Analysis with all fields set" do
    user = Factory(:user)
    analysis=Analysis.new_with_user({:content => 'a content', :kind => Analysis.weakness}, user)
    analysis.swot.should_not be_nil
    analysis.swot.company.should == user.company
    analysis.user.should == user
  end
  
end
