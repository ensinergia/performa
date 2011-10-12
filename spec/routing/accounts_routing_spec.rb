require "spec_helper"

describe AccountsController do
  
  describe "routing" do
    
    it "should match /accounts when subdomain" do
      { :get => "http://foo.example.com/accounts"  }.should route_to(:controller => "accounts", :action => "index")
    end
    
    it "shouldn't match /accounts neither redirect to /accounts/info when no subdomain" do
      { :get => "http://example.com/accounts"  }.should_not be_routable
    end
    
    it "should match /accounts/account_info with #account_info and subdomain" do
      { :get => "http://foo.example.com/accounts/account_info"  }.should route_to(:controller => "accounts", :action => "account_info")
    end
    
    it "shouldn't match /accounts/account_info with #account_info and no subdomain" do
      { :get => "http://example.com/accounts/account_info"  }.should_not be_routable
    end
    
    it "should match /accounts/user_info with #user_info" do
      { :get => "http://foo.example.com/accounts/user_info" }.should route_to(:controller => "accounts", :action => "user_info")
    end
    
    it "shouldn't match /accounts/user_info with #account_info and no subdomain" do
      { :get => "http://example.com/accounts/user_info"  }.should_not be_routable
    end
    
    it "should match /accounts/user_tasks with #user_tasks" do
      { :get => "http://foo.example.com/accounts/user_tasks" }.should route_to(:controller => "accounts", :action => "user_tasks")
    end
    
    it "shouldn't match /accounts/user_tasks with #user_tasks and no subdomain" do
      { :get => "http://example.com/accounts/user_tasks"  }.should_not be_routable
    end
    
    it "shouldn't match /accounts/1 when no subdomain given" do
      { :put => "http://example.com/accounts/1"  }.should_not be_routable
    end
    
    it "should match /accounts/1 with #update when subdomain given" do
      { :put => "http://foo.example.com/accounts/1"  }.should route_to(:controller => "accounts", :action => "update", :id => "1")
    end
    
    it "shouldn't match /accounts/destroy_current when no subdomain given" do
      { :delete => "http://example.com/accounts/destroy_current"  }.should_not be_routable
    end
    
    it "should match /accounts/destroy_current with #destroy when subdomain given" do
      { :delete => "http://foo.example.com/accounts/destroy_current"  }.should route_to(:controller => "accounts", :action => "destroy")
    end
  end
  
end