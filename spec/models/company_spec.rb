require 'spec_helper'

describe Company do
  
  before(:each) do
    @company = Factory(:company)
  end
  
  it "should save a default area after create" do
    @company.areas.first.name.should_not be_nil
    @company.areas.first.is_root_area.should be_true
  end
  
  it "should not save a default area after update" do
    lambda {
      @company.update_attribute(:name, "Example")
    }.should change(@company.areas, :count).by(0)
  end
  
  describe "given the company has one owner" do
    before(:each) do
      @owner_one= Factory(:user_no_company_name, :company => @company,
                          :position => Factory(:position, :name => Position.owner))
    end
    
    it "it should report it has only one" do
      @company.has_only_one_owner?.should be_true
    end
    
    describe "after I add another owner" do
    
      before(:each) do
        Factory(:user_no_company_name, :position => @owner_one.position, :company => @company)
      end
    
      it "should report it doesn't have only one" do
        @company.has_only_one_owner?.should be_false
      end
    end
  end
  
  it "should destroy all it's associated records"
  
end
