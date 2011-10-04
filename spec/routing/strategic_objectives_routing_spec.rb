require "spec_helper"

describe StrategicObjectivesController do
  describe "routing" do

    it "should not match /strategic_objectives with #index action when subdomain is not given" do
      { :get => "http://example.com/strategic_objectives" }.should_not be_routable
    end

    it "should match /strategic_objectives with #index action when subdomain is provided" do
      { :get => "http://foo.example.com/strategic_objectives" }.should route_to(:controller => "strategic_objectives", :action => "index")
    end

    it "should not match /strategic_objectives with #destroy action when subdomain is not given" do
      { :delete => "http://example.com/strategic_objectives/1" }.should_not be_routable
    end

    it "should match /strategic_objectives with #destroy action when subdomain is provided" do
      { :delete => "http://foo.example.com/strategic_objectives/1" }.should route_to(:controller => "strategic_objectives", :action => "destroy", :id => "1")
    end

    it "should not match /strategic_objectives with #edit action when subdomain is not given" do
      { :get => "http://example.com/strategic_objectives/1/edit" }.should_not be_routable
    end

    it "should match /strategic_objectives with #edit action when subdomain is provided" do
      { :get => "http://foo.example.com/strategic_objectives/1/edit" }.should route_to(:controller => "strategic_objectives", :action => "edit", :id => "1")
    end

    it "should not match /strategic_objectives with #update action when subdomain is not given" do
      { :put => "http://example.com/strategic_objectives/1" }.should_not be_routable
    end

    it "should match /strategic_objectives with #update action when subdomain is provided" do
      { :put => "http://foo.example.com/strategic_objectives/1" }.should route_to(:controller => "strategic_objectives", :action => "update", :id => "1")
    end

    it "should not match /strategic_objectives with #new action when subdomain is not given" do
      { :get => "http://example.com/strategic_objectives/new" }.should_not be_routable
    end

    it "should match /strategic_objectives with #new action when subdomain is provided" do
      { :get => "http://foo.example.com/strategic_objectives/new" }.should route_to(:controller => "strategic_objectives", :action => "new")
    end

    it "should not match /strategic_objectives with #post action when subdomain is not given" do
      { :post => "http://example.com/strategic_objectives" }.should_not be_routable
    end

    it "should match /strategic_objectives with #post action when subdomain is provided" do
      { :post => "http://foo.example.com/strategic_objectives" }.should route_to(:controller => "strategic_objectives", :action => "create")
    end
  end

end
