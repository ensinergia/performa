# encoding: utf-8
require 'spec_helper'

describe Creed::MissionsController do
  
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    
    @user = Factory(:user)
    sign_in :user, @user
    @request.host = "#{@user.subdomain}.test.host"
  end
  
  describe "GET #index action" do
    
    before(:each) do
      @mission = Factory.stub(:mission, :description => "a desc")
    end
    
    describe "when a mission is registered" do
      it "should assign it to @mission" do
        Mission.stub(:get_current) { @mission }
        get :index
        assigns(:mission).should == @mission
      end
      
      it "should render action show" do
        Mission.stub(:get_current) { @mission }
        get :index
        request.should render_template('show')
      end
    end
    
    describe "when no mission is registered" do
      it "should render index template" do
        Mission.stub(:get_current) { nil }
        get :index
        request.should render_template('index')
      end
    end
    

    
  end
  
  describe "GET #new action" do
    
    before(:each) do
      @mission = Mission.new
    end
    
    it "should assign a new mission to @mission" do
      Mission.stub(:new) { @mission }
      get :new
      assigns(:mission).should == @mission
    end
    
    it "should render new template" do
      get :new
      request.should render_template('new')
    end
  end
  
  describe "POST #create action" do
    
    before(:each) do
      @mission = Factory.stub(:mission, :description => "a desc")
    end
    
    describe "on successful save" do
     
      before(:each) do
        @mission.stub(:save).and_return(true)
      end
     
      it "should save a mission, assign it to @mission and send notifications" do
        Mission.stub(:new_with_user).and_return { @mission }
        @mission.should_receive(:notify_to).with({"2" => "1"})
        post :create, :mission => { :description => "a desc"}, :users => {"2" => "1"}
        assigns(:mission).should == @mission
      end 
      
      it "should redirect to index action" do
        Mission.stub(:new_with_user).and_return { @mission }
        post :create
        response.should redirect_to(creed_missions_path)
      end
      
      it "should set a flash message" do
        Mission.stub(:new_with_user).and_return { @mission }
        post :create
        flash[:notice].should == I18n.t('views.creed.create_mission.successful_save')
      end
      
    end
    
    describe "on unsuccessful save" do
      
      before(:each) do
        @mission.stub(:save).and_return(false)
      end
      
      it "should render the new action" do
        Mission.stub(:new_with_user).and_return { @mission }
        post :create
        response.should render_template('new')
      end
      
    end
  end
  
  describe "GET #show action" do
    
    it "should assign an existant mission to @mission" do
      Mission.stub(:find).and_return { Factory.stub(:mission) }
      get :show, :id => "2"
      assigns(:mission).should_not be_nil
    end
  end
  
  describe "GET #edit action" do
    
    before(:each) do
      @mission = Factory.stub(:mission)
    end
    
    it "should assign clone the editable mission into a NEW mission and assign it to @mission" do
      Mission.should_receive(:find).with("1") { @mission }
      get :edit, :id => "1"
      assigns(:mission).should == @mission
    end
    
  end
  
  describe "PUT #update action" do
    
    describe "when description is not empty" do
      
      before(:each) do
        @mission = Factory(:mission_with_assoc)
        
        Mission.stub(:find).with("1").and_return { @mission }
      end
      
      it "should update it's attributes" do
        @mission.should_receive(:update_attributes).and_return(true)
        @mission.should_receive(:notify_to)
        
        put :update, :id => "1", :mission => { :description => 'a description' }
        assigns(:mission).should == @mission
      end
      
      it "should redirect to index action" do
        put :update, :id => "1", :mission => { :description => 'a description' }
        response.should redirect_to(creed_missions_path)
        flash[:notice].should == I18n.t('views.creed.update_mission.successful_save')
      end
      
    end
    
    describe "when description is empty" do
    
      before(:each) do
        @mission = Factory.build(:mission_with_assoc, :description => "")
        Mission.stub(:find).and_return { @mission }
      end
    
      it "should NOT get saved" do
        @mission.should_receive(:save).and_return(false)
        @mission.should_not_receive(:notify_to)
      
        put :update, :id => "1", :mission => { :description => "" }
      end
      
      it "should render edit action" do
        put :update, :id => "1", :mission => { :description => "" }
        response.should render_template('edit')
      end
      
    end
  end
  
end