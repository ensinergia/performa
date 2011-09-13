require "spec_helper"

describe Creed::MissionsController do
  
  describe "routing" do
    
    it "should not match /creed/missions with #index action when subdomain is not given" do
      { :get => "http://example.com/creed/missions" }.should_not be_routable
    end
    
    it "should match /creed/missions with #index action when subdomain is provided" do
      { :get => "http://foo.example.com/creed/missions" }.should route_to(:controller => "creed/missions", :action => "index")      
    end
    
    it "should not match /creed/missions/new with #new action when subdomain is not given" do
      { :get => "http://example.com/creed/missions/new" }.should_not be_routable
    end
    
    it "should match /creed/missions/new with #new action when subdomain is provided" do
      { :get => "http://foo.example.com/creed/missions/new" }.should route_to(:controller => "creed/missions", :action => "new")
    end
    
    it "should not match /creed/missions with #create action when subdomain is not given" do
      { :post => "http://example.com/creed/missions" }.should_not be_routable
    end
    
    it "should match /creed/missions with #create action when subdomain is provided" do
      { :post => "http://foo.example.com/creed/missions" }.should route_to(:controller => "creed/missions", :action => "create")      
    end
    
    it "should not match /creed/missions/1 with #show action when subdomain is not given" do
      { :get => "http://example.com/creed/missions/1" }.should_not be_routable
    end
    
    it "should match /creed/missions/1 with #show action when subdomain is provided" do
      { :get => "http://foo.example.com/creed/missions/1" }.should route_to(:controller => "creed/missions", :action => "show", :id => "1")      
    end
    
    it "should not match /creed/missions/1/edit with #edit action when subdomain is not given" do
      { :get => "http://example.com/creed/missions/1/edit" }.should_not be_routable
    end

    it "should match /creed/missions/1/edit with #edit action when subdomain is provided" do
      { :get => "http://foo.example.com/creed/missions/1/edit" }.should route_to(:controller => "creed/missions", :action => "edit", :id => "1")      
    end
    
    it "should not match /creed/missions/ with #update action when subdomain is not given" do
      { :put => "http://example.com/creed/missions/1" }.should_not be_routable
    end

    it "should match /creed/missions/ with #update action when subdomain is provided" do
      { :put => "http://foo.example.com/creed/missions/1" }.should route_to(:controller => "creed/missions", :action => "update", :id => "1")      
    end
  end
end