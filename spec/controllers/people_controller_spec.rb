require 'spec_helper'

describe PeopleController do
  
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    @user = Factory(:user)
    sign_in :user, @user
    @request.host = "#{@user.subdomain}.test.host"
  end
  
  describe "GET #index" do
    
    describe "with non existant areas" do
    
      before(:each) do
        @areas = []
      end
    
      it "should assign company to @company" do
        get :index
        assigns(:company).should_not be_nil
      end
    
      it "should assign the areas to @areas" do
        Area.should_receive(:get_all_for) { @areas }
        get :index
        assigns(:areas).should == @areas
      end
    
      it "should show the welcome index template" do
        Area.should_receive(:get_all_for) { @areas }
        get :index
        response.should render_template('index_welcome')
      end
    end
    
    describe "with existant areas" do
    
      before(:each) do
        @areas = [Factory(:area, :name => "This area")]
      end
    
      it "should assign company to @company" do
        get :index
        assigns(:company).should_not be_nil
      end
    
      it "should assign the areas to @areas" do
        Area.should_receive(:get_all_for) { @areas }
        get :index
        assigns(:areas).should == @areas
      end
    
      it "should show the index template" do
        Area.should_receive(:get_all_for) { @areas }
        get :index
        response.should render_template('index')
      end
    end
  end
  
  describe "PUT #bulk_update_admin" do
    
    it "should invoke update permission method and then render admin action" do
      User.should_receive(:change_role_for)
      put :bulk_update_admin, :users => { '1' => '2'}
      response.should be_redirect
    end
    
  end
  
end
