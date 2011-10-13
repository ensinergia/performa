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
    
    it "should make the user with user permissions"
    
    it "should set a user position to other than 'owner' when company is existant" do
      @user =  Factory.build(:user_no_company_name, :company_name => @company.name)
      @user.save
      @user.is_owner?.should be_false
    end
    
    describe ": Given two users: one admin and the other not" do

      before(:each) do
        @u_p = Factory(:user_position)
        @o_p = Factory(:owner_position)
        @admin = Factory(:user_no_company_name_other_area, :name => "Felix", :company => @company, :position => @o_p)
        @not_admin = Factory(:user_no_company_name_other_area, :name => "San", :company => @company, :position => @u_p)
      end

      it "should let me change it's permissions" do
        User.change_role_for({@admin.id => @u_p.id, @not_admin.id => @o_p.id})
        User.find(@admin.id).role?(Role.user).should be_true
        User.find(@not_admin.id).role?(Role.super_admin).should be_true
      end

    end
    
  end
  
  it "should set a user position to 'owner' when company is new" do
    @user =  Factory.build(:user)
    @user.save
    @user.is_owner?.should be_true
  end
  
  describe ": Given it doesn't exists a company called 'iEvolutioned'" do
    
    before(:each) do
      @user = Factory.create(:user, :company_name => "iEvolutioned")
    end
    
    it "should make the user with owner permissions"
    
    it "should create a company and associate it with a user with the same company_name" do
      @user.company.name.should == 'iEvolutioned'
    end
    
    it "should add the user to the default area in the recently created company" do
      @user.area.should_not be_nil
      @user.area.name.should == I18n.t('views.areas.default')
    end
  end

  it "should set a user role to xxx on create"

end
