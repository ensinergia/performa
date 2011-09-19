# encoding: utf-8
require 'spec_helper'

describe Creed::VisionsController do
  
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    
    @user = Factory(:user)
    sign_in :user, @user
    @request.host = "#{@user.subdomain}.test.host"
  end
  
  describe "GET #index action" do
    
    before(:each) do
      @vision = Factory.stub(:vision, :description => "a desc")
    end
    
    describe "when a vision is registered" do
      it "should assign it to @vision" do
        Vision.stub(:get_current) { @vision }
        get :index
        assigns(:vision).should == @vision
      end
      
      it "should render action show" do
        Vision.stub(:get_current) { @vision }
        get :index
        request.should render_template('show')
      end
    end
    
    describe "when no vision is registered" do
      it "should render index template" do
        Vision.stub(:get_current) { nil }
        get :index
        request.should render_template('index')
      end
    end
    

    
  end
  
  describe "GET #new action" do
    
    before(:each) do
      @vision = Vision.new
    end
    
    it "should assign a new vision to @vision" do
      Vision.stub(:new) { @vision }
      get :new
      assigns(:vision).should == @vision
    end
    
    it "should render new template" do
      get :new
      request.should render_template('new')
    end
  end
  
  describe "POST #create action" do
    
    before(:each) do
      @vision = Factory.stub(:vision, :description => "a desc")
    end
    
    describe "on successful save" do
     
      before(:each) do
        @vision.stub(:save).and_return(true)
      end
     
      it "should save a vision, assign it to @vision and send notifications" do
        Vision.stub(:new_with_user).and_return { @vision }
        @vision.should_receive(:notify_to).with({"2" => "1"})
        post :create, :vision => { :description => "a desc"}, :users => {"2" => "1"}
        assigns(:vision).should == @vision
      end 
      
      it "should redirect to index action" do
        Vision.stub(:new_with_user).and_return { @vision }
        post :create
        response.should redirect_to(creed_visions_path)
      end
      
      it "should set a flash message" do
        Vision.stub(:new_with_user).and_return { @vision }
        post :create
        flash[:notice].should == I18n.t('views.common.messages.save.successful', :model => I18n.t('activerecord.models.vision'), :genre => "a")
      end
      
    end
    
    describe "on unsuccessful save" do
      
      before(:each) do
        @vision.stub(:save).and_return(false)
      end
      
      it "should render the new action" do
        Vision.stub(:new_with_user).and_return { @vision }
        post :create
        response.should render_template('new')
      end
      
    end
  end
  
  describe "GET #show action" do
    
    it "should assign an existant vision to @vision" do
      Vision.stub(:find).and_return { Factory.stub(:vision) }
      get :show, :id => "2"
      assigns(:vision).should_not be_nil
    end
  end
  
  describe "GET #edit action" do
    
    before(:each) do
      @vision = Factory.stub(:vision)
    end
    
    it "should assign clone the editable vision into a NEW vision and assign it to @vision" do
      Vision.should_receive(:find).with("1") { @vision }
      get :edit, :id => "1"
      assigns(:vision).should == @vision
    end
    
  end
  
  describe "PUT #update action" do
    
    describe "when description is not empty" do
      
      before(:each) do
        @vision = Factory(:vision_with_assoc)
        
        Vision.stub(:find).with("1").and_return { @vision }
      end
      
      it "should update it's attributes" do
        @vision.should_receive(:update_attributes).and_return(true)
        @vision.should_receive(:notify_to)
        
        put :update, :id => "1", :vision => { :description => 'a description' }
        assigns(:vision).should == @vision
      end
      
      it "should redirect to index action" do
        put :update, :id => "1", :vision => { :description => 'a description' }
        response.should redirect_to(creed_visions_path)
        flash[:notice].should == I18n.t('views.common.messages.update.successful', :model => I18n.t('activerecord.models.vision'), :genre => "a")
      end
      
    end
    
    describe "when description is empty" do
    
      before(:each) do
        @vision = Factory.build(:vision_with_assoc, :description => "")
        Vision.stub(:find).and_return { @vision }
      end
    
      it "should NOT get saved" do
        @vision.should_receive(:save).and_return(false)
        @vision.should_not_receive(:notify_to)
      
        put :update, :id => "1", :vision => { :description => "" }
      end
      
      it "should render edit action" do
        put :update, :id => "1", :vision => { :description => "" }
        response.should render_template('edit')
      end
      
    end
  end
  
end