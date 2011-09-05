# encoding: utf-8
require 'spec_helper'

describe Swot::AnalysesController do
  
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    
    @user = Factory(:user)
    sign_in :user, @user
    @request.host = "#{@user.subdomain}.test.host"
  end
  
  describe "GET #index action" do
    
    it "should redirect to weaknesses action" do
      internals = {:weaknesses => 'some weaknesses', :strengths => 'some strengths' }
      Swot.should_receive(:get_internals_for) { internals }

      get :index 
      response.should render_template('analyses')
    end
    
    it "should NOT redirect to weaknesses action" do
      internals = {}
      Swot.should_receive(:get_internals_for) { internals }

      get :index 
      response.should render_template('index')
    end
    
  end
  
  describe "GET #internals action" do
    
    before(:each) do
      @swot = Factory(:swot)
    end
    
    it "should assign weaknesses and strengths to @weaknesses and @strengths respectively" do
      internals = {:weaknesses => 'some weaknesses', :strengths => 'some strengths' }
      Swot.should_receive(:get_internals_for) { internals }

      get :internals
      assigns[:weaknesses].should == 'some weaknesses'
      assigns[:strengths].should == 'some strengths'
    end
    
    it "should render index" do
      get :internals
      response.should render_template('analyses')
    end
    
  end
  
  describe "GET #externals action" do
    
    it "should assign risks and opportunities to @risks and @opportunities respectively" do
      externals = {:risks => 'some risks', :opportunities => 'some opportunities'}
      Swot.should_receive(:get_externals_for) { externals }

      get :externals
      assigns[:opportunities].should == 'some opportunities'
      assigns[:risks].should == 'some risks'
    end
    
    it "should render index" do
      get :externals
      response.should render_template('analyses')
    end
    
  end
  
  describe "POST #create action for internal analysis" do
    
    before(:each) do
      @analysis = Factory.stub(:strength)
    end
    
    describe "with valid params" do
      
      before(:each) do
        @analysis.stub(:save).and_return(true)
        @params = {"content" => 'not empty', "kind" => '1'}
      end
      
      it "should save a new analysis" do
        Analysis.should_receive(:new_with_user).with(@params, an_instance_of(User)).and_return { @analysis }

        post :create, :analysis => @params
      end
      
      it "should redirect to internal_swot_analyses_path" do
        post :create, :analysis => @params
        response.should redirect_to(internal_swot_analyses_path)
      end
      
      it "should set a flash message" do
        post :create, :analysis => @params
        flash[:notice].should_not be_empty
      end
    
    end
    
    describe "with non valid params" do
      
      before(:each) do
        @analysis.stub(:save).and_return(false)
        @params = {"content" => '', "kind" => '3'}
      end
      
      it "should render a flash alert" do
        post :create, :analysis => @params
        flash[:alert].should == I18n.t('views.swot.shared_views.add.unsuccessful_save')
      end
      
    end
    
  end
  
  describe "POST #create action for external analysis" do
    
    before(:each) do
      @analysis = Factory(:opportunity)
    end
    
    it "should assign a new analysis" do
      Analysis.should_receive(:new_with_user).with(@params, an_instance_of(User)).and_return { @analysis }
      post :create, :analysis => @params
      
      assigns(:analysis).should == @analysis
    end
    
    describe "with valid params" do
      
      before(:each) do
        @analysis.stub(:save).and_return(true)
        @params = {"content" => 'not empty', "kind" => '3'}
      end
      
      it "should redirect to external_swot_analyses_path" do
        post :create, :analysis => @params
        response.should redirect_to(external_swot_analyses_path)
      end
      
      it "should set a flash message" do
        post :create, :analysis => @params
        flash[:notice].should_not be_empty
      end
    
    end
    
    describe "with non valid params" do
      
      before(:each) do
        @analysis.stub(:save).and_return(false)
        @params = {"content" => '', "kind" => '3'}
      end
      
      it "should render a flash alert" do
        post :create, :analysis => @params
        flash[:alert].should == I18n.t('views.swot.shared_views.add.unsuccessful_save')
      end
      
    end
    
  end
  
  describe "DELETE #destroy action" do
    
    before(:each) do
      @internal_analysis = Factory(:strength)
      @external_analysis = Factory(:opportunity, :swot => @internal_analysis.swot)
    end
    
    it "should delete the analysis" do
      Analysis.should_receive(:find).with('1') { @internal_analysis }
      @internal_analysis.should_receive(:destroy)
      delete :destroy, :id => '1'
    end
    
    it "should render redirect to listing for internals" do
      Analysis.should_receive(:find).with('1') { @internal_analysis }
      delete :destroy, :id => '1'
      response.should redirect_to(internal_swot_analyses_path)
    end 
    
    it "should render redirect to listing for externals" do
      Analysis.should_receive(:find).with('1') { @external_analysis }
      delete :destroy, :id => '1'
      response.should redirect_to(external_swot_analyses_path)
    end
    
  end
  
  
  describe "UPDATE #update action" do
    
    before(:each) do
      @analysis = Factory(:strength)
    end
    
    it "should update the analysis attributes" do
      Analysis.should_receive(:find).with('1') { @analysis }
      put :update, :id => '1', :analysis => 'attributes'
      assigns(:analysis).should == @analysis
    end
    
  end
  
end