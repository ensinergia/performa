require "spec_helper"

describe Users::RegistrationsController do
  
  describe "routing" do
    
    it "should match /users/sign_up with #new action" do
      { :get => "http://example.com/users/sign_up" }.should route_to(:controller => "users/registrations", :action => "new")
    end
    
    it "should not match /users/sign_up with #new action" do
      { :get => "http://foo.example.com/users/sign_up" }.should_not be_routable
    end
    
  end
end