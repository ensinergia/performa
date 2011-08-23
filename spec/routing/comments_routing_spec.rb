require "spec_helper"

describe CommentsController do
  
  describe "routing" do
    
    it "should not match /comments with #post action when subdomain is not given" do
      { :post => "http://example.com/comments" }.should_not be_routable
    end
    
    it "should match /comments with #post action when subdomain is provided" do
      { :post => "http://foo.example.com/comments" }.should route_to(:controller => "comments", :action => "create")      
    end
   
    it "should not match /comments with #delete action when subdomain is not given" do
      { :delete => "http://example.com/comments/1" }.should_not be_routable
    end
    
    it "should match /comments with #delete action when subdomain is provided" do
      { :delete => "http://foo.example.com/comments/1" }.should route_to(:controller => "comments", :action => "destroy", :id => '1')   
    end
    
  end
end