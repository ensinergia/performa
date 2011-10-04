require 'spec_helper'

describe User do

  describe ": Given it exists the company 'iEvolutioned'" do

    before(:each) do
      @company = Factory(:company)
    end

    it "should not be possible to save a user with company_name set to 'iEvolutioned'" do
      @user = Factory.build(:user, :company_name => @company.name)
      @user.save
      @user.errors.should_not be_empty
    end
    
    it "should set a user position to 'User' when company is existant" do
      @user =  Factory.build(:user, :company_name => @company.name)
      @user.save
      @user.position.name.should == I18n.t('views.people.default_position')
    end
    
  end
  
  it "should set a user position to 'Owner' when company is new" do
    @user =  Factory.build(:user)
    @user.save
    @user.position.name.should == I18n.t('views.people.default_position_owner')
  end
  
  describe ": Given it doesn't exists a company called 'iEvolutioned'" do
    
    before(:each) do
      @user = Factory.create(:user, :company_name => "iEvolutioned")
    end
    
    it "should create a company and associate it with a user with the same company_name" do
      @user.company.name.should == 'iEvolutioned'
    end
    
    it "should add the user to the default area in the recently created company" do
      @user.area.should_not be_nil
      @user.area.name.should == I18n.t('views.areas.default')
    end
    
  end

end
