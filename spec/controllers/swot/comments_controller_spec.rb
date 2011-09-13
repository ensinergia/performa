# encoding: utf-8
require 'spec_helper'

describe Swot::CommentsController do
  
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    
    @user = Factory(:user)
    sign_in :user, @user
    @request.host = "#{@user.subdomain}.test.host"
  end
  
  describe "GET #index" do
    
    before(:each) do
      @analysis = Factory(:weakness)
    end
    
    it "should find and assign an analysis record to analysis" do
      Analysis.should_receive(:find).with('1', an_instance_of(Hash)) { @analysis }
      get :index , :analysis_id => '1'
      assigns(:analysis).should == @analysis
    end
    
    it "should render the index template" do
      get :index, :analysis_id => '1'
      response.should render_template('index')
    end
    
  end
  
end