require 'spec_helper'

describe User do

  describe "given it exists the company 'iEvolutioned'" do

    before(:each) do
      @company = Factory(:company)
    end

    it "should not be possible to save a user with company_name set to 'iEvolutioned'" do
      @user = Factory.build(:user, :company_name => "iEvolutioned")
      @user.valid?.should be_false
    end
    
  end
  
  describe "given it doesn't exists a company called 'iEvolutioned'" do
    
    it "should then create it and associate it with the user whose company_name is set to 'iEvolutioned'" do
      @user = Factory.create(:user, :company_name => "iEvolutioned")
      @user.company.name.should == 'iEvolutioned'
    end
    
  end

end
