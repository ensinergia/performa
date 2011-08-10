require "spec_helper"

describe MissionsController do
  
  describe "routing" do
    
    it "should not match /missions with #new action when subdomain is not given" do
      { :get => "http://example.com/missions" }.should_not be_routable
    end
    
    it "should match /missions with #new action when subdomain is provided" do
      { :get => "http://foo.example.com/missions" }.should route_to(:controller => "missions", :action => "index")      
    end
    
  end
end