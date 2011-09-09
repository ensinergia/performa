require 'spec_helper'

describe Creed do
  
  before(:each) do
    @company1 = Factory(:company, :name => "A")
  end
  
  describe "given a creed for a company previously exists," do
    
    before(:each) do
      @creed = Factory(:creed, :company => @company1, :user =>  Factory.build(:user_no_company_name, :company => @company1))
    end
    
    describe "attempting to update it with the same description" do
      
      before(:each) do
        @new_creed = Creed.new_or_update_with_user(@creed.id, {:description => @creed.description}, @creed.user)
      end
      
      it "should NOT create a new one" do
        @new_creed.should_not be_new_record
        @new_creed.should == @creed
      end
      
    end
    
    describe "attempting to create a new one with another description" do
      
      before(:each) do
        @new_creed = Creed.new_or_update_with_user(@creed.id, {:description => "Different creed"}, @creed.user)
      end
    
      it "should create a new one" do
        @new_creed.should be_new_record
        @new_creed.should_not == @creed
      end
      
      it "should assign the company and user to it and make it a current candidate" do
        @new_creed.user.should == @creed.user
        @new_creed.company.should == @creed.user.company
      end
      
    end
    
    describe "attempting to create a new one with another user" do
      
      before(:each) do
        @user = Factory.build(:user_no_company_name, :company => @company1)
        @new_creed = Creed.new_or_update_with_user(@creed.id, {:description => @creed.description}, @user)
      end
    
      it "should create a new one" do
        @new_creed.should be_new_record
        @new_creed.should_not == @creed
      end
      
      it "should assign the company and user to it and make it a current candidate" do
        @new_creed.user.should == @user
        @new_creed.company.should == @user.company
      end
      
    end
    
  end
  
  describe "for two given companies (A and B), A having a creed and B not yet" do
  
    before(:each) do
      @company2 = Factory(:company, :name => "B")
      @creed1 = Factory(:creed, :company => @company1, :user => Factory(:user_no_company_name, :company => @company1))
    end
    
    it "should bring the creed of company A when calling 'get_current'" do
      Creed.get_current(@company1).should == @creed1
    end
    
    it "should not bring any creed for company B when calling 'get_current'" do
      Creed.get_current(@company2).should be_nil
    end
    
    describe "given I add a creed to B" do
      
      before(:each) do
        @creed2 = Factory(:creed, :company => @company2, :user => Factory(:user_no_company_name, :company => @company2))
      end
      
      it "should bring the creed of company A when calling 'get_current'" do
        Creed.get_current(@company1).should == @creed1
      end
      
      it "should bring the creed of company B when calling 'get_current'" do
        Creed.get_current(@company2).should == @creed2
      end
      
    end
  end
  
end
