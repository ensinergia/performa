require "spec_helper"

describe StrategicLinesController do
  
  describe "routing" do
    
    it "should not match /strategic_lines with #index action when subdomain is not given" do
      { :get => "http://example.com/strategic_lines" }.should_not be_routable
    end
    
    it "should match /strategic_lines with #index action when subdomain is provided" do
      { :get => "http://foo.example.com/strategic_lines" }.should route_to(:controller => "strategic_lines", :action => "index")      
    end
    
    it "should not match /strategic_lines with #destroy action when subdomain is not given" do
      { :delete => "http://example.com/strategic_lines/1" }.should_not be_routable
    end
    
    it "should match /strategic_lines with #destroy action when subdomain is provided" do
      { :delete => "http://foo.example.com/strategic_lines/1" }.should route_to(:controller => "strategic_lines", :action => "destroy", :id => "1")      
    end
    
    it "should not match /strategic_lines with #edit action when subdomain is not given" do
      { :get => "http://example.com/strategic_lines/1/edit" }.should_not be_routable
    end
    
    it "should match /strategic_lines with #edit action when subdomain is provided" do
      { :get => "http://foo.example.com/strategic_lines/1/edit" }.should route_to(:controller => "strategic_lines", :action => "edit", :id => "1")      
    end
    
    it "should not match /strategic_lines with #update action when subdomain is not given" do
      { :put => "http://example.com/strategic_lines/1" }.should_not be_routable
    end
    
    it "should match /strategic_lines with #update action when subdomain is provided" do
      { :put => "http://foo.example.com/strategic_lines/1" }.should route_to(:controller => "strategic_lines", :action => "update", :id => "1")      
    end
    
    it "should not match /strategic_lines with #new action when subdomain is not given" do
      { :get => "http://example.com/strategic_lines/new" }.should_not be_routable
    end
    
    it "should match /strategic_lines with #new action when subdomain is provided" do
      { :get => "http://foo.example.com/strategic_lines/new" }.should route_to(:controller => "strategic_lines", :action => "new")      
    end
    
    it "should not match /strategic_lines with #post action when subdomain is not given" do
      { :post => "http://example.com/strategic_lines" }.should_not be_routable
    end
    
    it "should match /strategic_lines with #post action when subdomain is provided" do
      { :post => "http://foo.example.com/strategic_lines" }.should route_to(:controller => "strategic_lines", :action => "create")      
    end
  end
end