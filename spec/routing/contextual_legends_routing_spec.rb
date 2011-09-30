require "spec_helper"

describe ContextualLegendsController do
  
  describe "routing" do
    
    it "should not match /contextual_legends with #show test action when subdomain is not given" do
      { :post => "http://example.com/contextual_legends/show" }.should_not be_routable
    end
    
    it "should match /contextual_legends with #show test action when subdomain is provided" do
      { :post => "http://foo.example.com/contextual_legends/show" }.should route_to(:controller => "contextual_legends", :action => "show")      
    end
    
  end
end