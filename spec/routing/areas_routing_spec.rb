require "spec_helper"

describe AreasController do
  
  describe "routing" do
    
    it "should not match /area with #new action when subdomain is not given" do
      { :get => "http://example.com/areas/new" }.should_not be_routable
    end
    
    it "should match /area with #new action when subdomain is provided" do
      { :get => "http://foo.example.com/areas/new" }.should route_to(:controller => "areas", :action => "new")      
    end
    
    it "should not match /areas with #index action when subdomain is not given" do
      { :get => "http://example.com/areas" }.should_not be_routable
    end
    
    it "should match /areas with #index action when subdomain is provided" do
      { :get => "http://foo.example.com/areas" }.should route_to(:controller => "areas", :action => "index")      
    end
    
    it "should not match /areas with #create action when subdomain is not given" do
      { :post => "http://example.com/areas" }.should_not be_routable
    end
    
    it "should match /areas with #create action when subdomain is provided" do
      { :post => "http://foo.example.com/areas" }.should route_to(:controller => "areas", :action => "create")      
    end
    
    it "should not match /areas/1/edit with #edit action when subdomain is not given" do
      { :get => "http://example.com/areas/1/edit" }.should_not be_routable
    end
    
    it "should match /areas/1/edit with #edit action when subdomain is provided" do
      { :get => "http://foo.example.com/areas/1/edit" }.should route_to(:controller => "areas", :action => "edit", :id => "1")      
    end
    
    it "should not match /areas/1 with #update action when subdomain is not given" do
      { :put => "http://example.com/areas/1" }.should_not be_routable
    end
    
    it "should match /areas/1 with #update action when subdomain is provided" do
      { :put => "http://foo.example.com/areas/1" }.should route_to(:controller => "areas", :action => "update", :id => "1")      
    end
    
    it "should not match /areas/admin with #admin action when subdomain is not given" do
      { :get => "http://example.com/areas/admin" }.should_not be_routable
    end
    
    it "should match /areas/admin with #admin action when subdomain is provided" do
      { :get => "http://foo.example.com/areas/admin" }.should route_to(:controller => "areas", :action => "admin")      
    end
    
  end
end