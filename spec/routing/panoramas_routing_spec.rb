require "spec_helper"

describe PanoramasController do
  
  describe "routing" do
    
    it "should match /panorama with #index action" do
      { :get => "http://foo.example.com/panorama" }.should route_to(:controller => "panoramas", :action => "index")
    end
    
  end
end