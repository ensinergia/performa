require 'spec_helper'

describe Company do
  
  before(:each) do
    @company = Factory(:company)
  end
  
  it "should save a default area after create" do
    @company.areas.first.name.should_not be_nil
  end
  
  it "should not save a default area after update" do
    lambda {
      @company.update_attribute(:name, "Example")
    }.should change(@company.areas, :count).by(0)
  end
  
end
