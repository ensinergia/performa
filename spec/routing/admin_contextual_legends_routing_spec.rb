require "spec_helper"

describe Admin::ContextualLegendsController do
  
  describe "routing" do
    
    it "should not match /admin/contextual_legends with #index test action when subdomain is not given" do
      { :get => "http://example.com/admin/contextual_legends" }.should_not be_routable
    end
    
    it "should match /admin/contextual_legends with #index test action when subdomain is provided" do
      { :get => "http://foo.example.com/admin/contextual_legends" }.should route_to(:controller => "admin/contextual_legends", :action => "index")      
    end
    
    it "should not match /admin/contextual_legends/new with #show_test action when subdomain is not given" do
      { :get => "http://example.com/admin/contextual_legends/new" }.should_not be_routable
    end
    
    it "should match /admin/contextual_legends/new with #new action when subdomain is provided" do
      { :get => "http://foo.example.com/admin/contextual_legends/new" }.should route_to(:controller => "admin/contextual_legends", :action => "new")      
    end
    
    it "should not match /admin/contextual_legends/1/edit with #edit action when subdomain is not given" do
      { :get => "http://example.com/admin/contextual_legends/1/edit" }.should_not be_routable
    end
    
    it "should match /admin/contextual_legends/1/edit with #edit action when subdomain is provided" do
      { :get => "http://foo.example.com/admin/contextual_legends/1/edit" }.should route_to(:controller => "admin/contextual_legends", :action => "edit", :id => "1")      
    end
    
    it "should not match /admin/contextual_legends/create with #create action when subdomain is not given" do
      { :post => "http://example.com/admin/contextual_legends" }.should_not be_routable
    end
    
    it "should match /admin/contextual_legends/create with #create action when subdomain is provided" do
      { :post => "http://foo.example.com/admin/contextual_legends" }.should route_to(:controller => "admin/contextual_legends", :action => "create")      
    end
    
    it "should not match /admin/contextual_legends/1 with #update action when subdomain is not given" do
      { :put => "http://example.com/admin/contextual_legends/1" }.should_not be_routable
    end
    
    it "should match /admin/contextual_legends/1 with #update action when subdomain is provided" do
      { :put => "http://foo.example.com/admin/contextual_legends/1" }.should route_to(:controller => "admin/contextual_legends", :action => "update", :id => "1")      
    end
    
  end
end