require "spec_helper"

describe Creed::WarCriesController do
  
  describe "routing" do
    
    it "should not match /creed/war_cries with #index action when subdomain is not given" do
      { :get => "http://example.com/creed/war_cries" }.should_not be_routable
    end
    
    it "should match /creed/war_cries with #index action when subdomain is provided" do
      { :get => "http://foo.example.com/creed/war_cries" }.should route_to(:controller => "creed/war_cries", :action => "index")      
    end
    
    it "should not match /creed/war_cries/new with #new action when subdomain is not given" do
      { :get => "http://example.com/creed/war_cries/new" }.should_not be_routable
    end
    
    it "should match /creed/war_cries/new with #new action when subdomain is provided" do
      { :get => "http://foo.example.com/creed/war_cries/new" }.should route_to(:controller => "creed/war_cries", :action => "new")
    end
    
    it "should not match /creed/war_cries with #create action when subdomain is not given" do
      { :post => "http://example.com/creed/war_cries" }.should_not be_routable
    end
    
    it "should match /creed/war_cries with #create action when subdomain is provided" do
      { :post => "http://foo.example.com/creed/war_cries" }.should route_to(:controller => "creed/war_cries", :action => "create")      
    end
    
    it "should not match /creed/war_cries/1 with #show action when subdomain is not given" do
      { :get => "http://example.com/creed/war_cries/1" }.should_not be_routable
    end
    
    it "should match /creed/war_cries/1 with #show action when subdomain is provided" do
      { :get => "http://foo.example.com/creed/war_cries/1" }.should route_to(:controller => "creed/war_cries", :action => "show", :id => "1")      
    end
    
    it "should not match /creed/war_cries/1/edit with #edit action when subdomain is not given" do
      { :get => "http://example.com/creed/war_cries/1/edit" }.should_not be_routable
    end

    it "should match /creed/war_cries/1/edit with #edit action when subdomain is provided" do
      { :get => "http://foo.example.com/creed/war_cries/1/edit" }.should route_to(:controller => "creed/war_cries", :action => "edit", :id => "1")      
    end
    
    it "should not match /creed/war_cries/ with #update action when subdomain is not given" do
      { :put => "http://example.com/creed/war_cries/1" }.should_not be_routable
    end

    it "should match /creed/war_cries/ with #update action when subdomain is provided" do
      { :put => "http://foo.example.com/creed/war_cries/1" }.should route_to(:controller => "creed/war_cries", :action => "update", :id => "1")      
    end
  end
end