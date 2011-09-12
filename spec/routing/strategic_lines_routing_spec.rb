require "spec_helper"

describe StrategicLinesController do
  
  describe "routing" do
    
    it "should not match /strategic_lines with #index action when subdomain is not given" do
      { :get => "http://example.com/strategic_lines" }.should_not be_routable
    end
    
    it "should match /strategic_lines with #index action when subdomain is provided" do
      { :get => "http://foo.example.com/strategic_lines" }.should route_to(:controller => "strategic_lines", :action => "index")      
    end
    
  end
end