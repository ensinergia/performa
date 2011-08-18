require 'spec_helper'

describe Vision do
  
  before(:each) do
    @company1 = Factory(:company, :name => "A")
  end
  
  describe "given a vision for a company previously exists," do
    
    before(:each) do
      @vision = Factory(:vision, :company => @company1, :user =>  Factory.build(:user_no_company_name, :company => @company1))
    end
    
    describe "attempting to update it with the same description" do
      
      before(:each) do
        @new_vision = Vision.new_or_update_with_user(@vision.id, {:description => @vision.description}, @vision.user)
      end
      
      it "should NOT create a new one" do
        @new_vision.should_not be_new_record
        @new_vision.should == @vision
      end
      
    end
    
    describe "attempting to create a new one with another description" do
      
      before(:each) do
        @new_vision = Vision.new_or_update_with_user(@vision.id, {:description => "Different vision"}, @vision.user)
      end
    
      it "should create a new one" do
        @new_vision.should be_new_record
        @new_vision.should_not == @vision
      end
      
      it "should assign the company and user to it and make it a current candidate" do
        @new_vision.user.should == @vision.user
        @new_vision.company.should == @vision.user.company
        @new_vision.current.should be_true
      end
      
    end
    
    describe "attempting to create a new one with another user" do
      
      before(:each) do
        @user = Factory.build(:user_no_company_name, :company => @company1)
        @new_vision = Vision.new_or_update_with_user(@vision.id, {:description => @vision.description}, @user)
      end
    
      it "should create a new one" do
        @new_vision.should be_new_record
        @new_vision.should_not == @vision
      end
      
      it "should assign the company and user to it and make it a current candidate" do
        @new_vision.user.should == @user
        @new_vision.company.should == @user.company
        @new_vision.current.should be_true
      end
      
    end
    
  end
  
  describe "for two given companies (A and B), A having a vision and B not yet" do
  
    before(:each) do
      @company2 = Factory(:company, :name => "B")
      @vision1 = Factory(:vision, :company => @company1, :user => Factory(:user_no_company_name, :company => @company1))
    end
    
    it "should bring the vision of company A when calling 'get_current'" do
      Vision.get_current(@company1).should == @vision1
    end
    
    it "should not bring any vision for company B when calling 'get_current'" do
      Vision.get_current(@company2).should be_nil
    end
    
    describe "given I add a vision to B" do
      
      before(:each) do
        @vision2 = Factory(:vision, :company => @company2, :user => Factory(:user_no_company_name, :company => @company2))
      end
      
      it "should bring the vision of company A when calling 'get_current'" do
        Vision.get_current(@company1).should == @vision1
      end
      
      it "should bring the vision of company B when calling 'get_current'" do
        Vision.get_current(@company2).should == @vision2
      end
      
    end
  end
  
end
