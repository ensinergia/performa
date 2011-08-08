require "spec_helper"

describe PanoramasController do
  
  describe "routing" do
    
    it "should match /panorama with #index action" do
      { :get => "http://foo.example.com/panorama" }.should route_to(:controller => "panoramas", :action => "index")
    end
    
    it "shouldn't match /panorama with #index action" do
      { :get => "http://example.com/panorama" }.should_not be_routable
    end
  end
end