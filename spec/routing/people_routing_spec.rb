require "spec_helper"

describe PeopleController do
  
  describe "routing" do
    
    it "should not match /people with #index action when subdomain is not given" do
      { :get => "http://example.com/people" }.should_not be_routable
    end
    
    it "should match /people with #index action when subdomain is provided" do
      { :get => "http://foo.example.com/people" }.should route_to(:controller => "people", :action => "index")      
    end
    
    it "should not match /people/new with #new action when subdomain is not given" do
      { :get => "http://example.com/people/new" }.should_not be_routable
    end
    
    it "should match /people/new with #new action when subdomain is provided" do
      { :get => "http://foo.example.com/people/new" }.should route_to(:controller => "people", :action => "new")      
    end

    it "should not match /people/1/edit with #edit action when subdomain is not given" do
      { :get => "http://example.com/people/1/edit" }.should_not be_routable
    end
    
    it "should match /people/1/edit with #edit action when subdomain is provided" do
      { :get => "http://foo.example.com/people/1/edit" }.should route_to(:controller => "people", :action => "edit", :id => "1")      
    end    
  end
end