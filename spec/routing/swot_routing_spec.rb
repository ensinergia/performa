require "spec_helper"

describe Swot::AnalysesController do
  
  describe "routing" do
    
    it "should not match /swot/analysis with #index action when subdomain is not provided" do
      { :get => "http://example.com/swot/analyses" }.should_not be_routable
    end
    
    it "should match /swot/analysis with #index action when subdomain is provided" do
      { :get => "http://foo.example.com/swot/analyses" }.should route_to(:controller => "swot/analyses", :action => "index")      
    end
    
    it "should not match /swot/analyses/external with #externals action when subdomain is not provided" do
      { :get => "http://example.com/swot/analyses/external" }.should_not be_routable
    end
    
    it "should match /swot/analyses/external with #externals action when subdomain is provided" do
      { :get => "http://foo.example.com/swot/analyses/external" }.should route_to(:controller => "swot/analyses", :action => "externals")      
    end
    
    it "should not match /swot/analyses/internal with #internals action when subdomain is not provided" do
      { :get => "http://example.com/swot/analyses/internal" }.should_not be_routable
    end
    
    it "should match /swot/analyses/internal with #internals action when subdomain is provided" do
      { :get => "http://foo.example.com/swot/analyses/internal" }.should route_to(:controller => "swot/analyses", :action => "internals")      
    end
    
    it "should not match /swot/analyses/new with #new action when subdomain is not provided" do
      { :get => "http://example.com/swot/analyses/new" }.should_not be_routable
    end
    
    it "should match /swot/analyses/new with #new action when subdomain is not provided" do
      { :get => "http://foo.example.com/swot/analyses/new" }.should route_to(:controller => "swot/analyses", :action => "new")
    end
    
    it "should not match /swot/analyses with #create action when subdomain is not provided" do
      { :post => "http://example.com/swot/analyses" }.should_not be_routable
    end
    
    it "should match /swot/analyses with #create action when subdomain is provided" do
      { :post => "http://foo.example.com/swot/analyses" }.should route_to(:controller => "swot/analyses", :action => "create")
    end
    
    it "should not match /swot/analyses/1/comments with #index action when subdomain is not provided" do
      { :get => "http://example.com/swot/analyses/1/comments" }.should_not be_routable
    end
    
    it "should match /swot/analyses/1/comments with #index action when subdomain is provided" do
      { :get => "http://foo.example.com/swot/analyses/1/comments" }.should route_to(:controller => "swot/comments", :action => "index", :analysis_id => "1")
    end
    
    it "should not match /swot/analyses/1 with #delete action when subdomain is not provided" do
      { :delete => "http://example.com/swot/analyses/1" }.should_not be_routable
    end
    
    it "should match /swot/analyses/1 with #delete action when subdomain is provided" do
      { :delete => "http://foo.example.com/swot/analyses/1" }.should route_to(:controller => "swot/analyses", :action => "destroy", :id => "1")
    end
    
    it "should not match /swot/analyses/1 with #update action when subdomain is not provided" do
      { :put => "http://example.com/swot/analyses/1" }.should_not be_routable
    end
    
    it "should match /swot/analyses/1 with #update action when subdomain is provided" do
      { :put => "http://foo.example.com/swot/analyses/1" }.should route_to(:controller => "swot/analyses", :action => "update", :id => "1")
    end
    
  end

end