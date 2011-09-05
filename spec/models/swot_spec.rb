require 'spec_helper'

describe Swot do
  
  describe "for an existing company and a SWOT" do
  
    describe "given there exists a record for strength, a weakness and an opportunity" do
    
      before(:each) do
        @s=Factory(:strength)
        @w=Factory(:weakness, :swot => @s.swot)
        @o=Factory(:opportunity, :swot => @s.swot)
        @r=Factory(:risk, :swot => @s.swot)
      end
      
      it "should find only weaknesses and strengths" do
        internals = Swot.get_internals_for(@s.swot.company)
        internals[:strengths].should include(@s)
        internals[:weaknesses].should include(@w)
        
        internals[:strengths].should_not include(@o)
        internals[:weaknesses].should_not include(@o)
      end
  
      it "should find only risks and opportunities" do
        externals = Swot.get_externals_for(@s.swot.company)
        externals[:opportunities].should include(@o)
        externals[:risks].should include(@r)
        
        externals[:opportunities].should_not include(@s)
        externals[:risks].should_not include(@w)
      end
  
      it "should clone this record before updating it"
  
    end
  end
  
end
