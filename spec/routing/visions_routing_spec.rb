require "spec_helper"

describe Creed::VisionsController do
  
  describe "routing" do
    
    it "should not match /creed/visions with #index action when subdomain is not given" do
      { :get => "http://example.com/creed/visions" }.should_not be_routable
    end
    
    it "should match /creed/visions with #index action when subdomain is provided" do
      { :get => "http://foo.example.com/creed/visions" }.should route_to(:controller => "creed/visions", :action => "index")      
    end
    
    it "should not match /creed/visions/new with #new action when subdomain is not given" do
      { :get => "http://example.com/creed/visions/new" }.should_not be_routable
    end
    
    it "should match /creed/visions/new with #new action when subdomain is provided" do
      { :get => "http://foo.example.com/creed/visions/new" }.should route_to(:controller => "creed/visions", :action => "new")
    end
    
    it "should not match /creed/visions with #create action when subdomain is not given" do
      { :post => "http://example.com/creed/visions" }.should_not be_routable
    end
    
    it "should match /creed/visions with #create action when subdomain is provided" do
      { :post => "http://foo.example.com/creed/visions" }.should route_to(:controller => "creed/visions", :action => "create")      
    end
    
    it "should not match /creed/visions/1 with #show action when subdomain is not given" do
      { :get => "http://example.com/creed/visions/1" }.should_not be_routable
    end
    
    it "should match /creed/visions/1 with #show action when subdomain is provided" do
      { :get => "http://foo.example.com/creed/visions/1" }.should route_to(:controller => "creed/visions", :action => "show", :id => "1")      
    end
    
    it "should not match /creed/visions/1/edit with #edit action when subdomain is not given" do
      { :get => "http://example.com/creed/visions/1/edit" }.should_not be_routable
    end

    it "should match /creed/visions/1/edit with #edit action when subdomain is provided" do
      { :get => "http://foo.example.com/creed/visions/1/edit" }.should route_to(:controller => "creed/visions", :action => "edit", :id => "1")      
    end
    
    it "should not match /creed/visions/ with #update action when subdomain is not given" do
      { :put => "http://example.com/creed/visions/1" }.should_not be_routable
    end

    it "should match /creed/visions/ with #update action when subdomain is provided" do
      { :put => "http://foo.example.com/creed/visions/1" }.should route_to(:controller => "creed/visions", :action => "update", :id => "1")      
    end
  end
end