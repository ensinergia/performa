# encoding: utf-8
require 'spec_helper'

describe Creed::WarCriesController do
  
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    
    @user = Factory(:user)
    sign_in :user, @user
    @request.host = "#{@user.subdomain}.test.host"
  end
  
  describe "GET #index action" do
    
    before(:each) do
      @war_cry = Factory.stub(:war_cry, :description => "a desc")
    end
    
    describe "when a war cry is registered" do
      it "should assign it to @war_cry" do
        WarCry.stub(:get_current) { @war_cry }
        get :index
        assigns(:war_cry).should == @war_cry
      end
      
      it "should render action show" do
        WarCry.stub(:get_current) { @war_cry }
        get :index
        request.should render_template('show')
      end
    end
    
    describe "when no war cry is registered" do
      it "should render index template" do
        WarCry.stub(:get_current) { nil }
        get :index
        request.should render_template('index')
      end
    end
    

    
  end
  
  describe "GET #new action" do
    
    before(:each) do
      @war_cry = WarCry.new
    end
    
    it "should assign a new war cry to @war_cry" do
      WarCry.stub(:new) { @war_cry }
      get :new
      assigns(:war_cry).should == @war_cry
    end
    
    it "should render new template" do
      get :new
      request.should render_template('new')
    end
  end
  
  describe "POST #create action" do
    
    before(:each) do
      @war_cry = Factory.stub(:war_cry, :description => "a desc")
    end
    
    describe "on successful save" do
     
      before(:each) do
        @war_cry.stub(:save).and_return(true)
      end
     
      it "should save a war cry, assign it to @war_cry and send notifications" do
        WarCry.stub(:new_with_user).and_return { @war_cry }
        @war_cry.should_receive(:notify_to).with({"2" => "1"})
        post :create, :war_cry => { :description => "a desc"}, :users => {"2" => "1"}
        assigns(:war_cry).should == @war_cry
      end 
      
      it "should redirect to index action" do
        WarCry.stub(:new_with_user).and_return { @war_cry }
        post :create
        response.should redirect_to(creed_war_cries_path)
      end
      
      it "should set a flash message" do
        WarCry.stub(:new_with_user).and_return { @war_cry }
        post :create
        flash[:notice].should == I18n.t('views.common.messages.save.successful', :model => I18n.t('activerecord.models.war_cry'), :genre => "o")
      end
      
    end
    
    describe "on unsuccessful save" do
      
      before(:each) do
        @war_cry.stub(:save).and_return(false)
      end
      
      it "should render the new action" do
        WarCry.stub(:new_with_user).and_return { @war_cry }
        post :create
        response.should render_template('new')
      end
      
    end
  end
  
  describe "GET #show action" do
    
    it "should assign an existant war cry to @war_cry" do
      WarCry.stub(:find).and_return { Factory.stub(:war_cry) }
      get :show, :id => "2"
      assigns(:war_cry).should_not be_nil
    end
  end
  
  describe "GET #edit action" do
    
    before(:each) do
      @war_cry = Factory.stub(:war_cry)
    end
    
    it "should assign clone the editable war cry into a NEW war cry and assign it to @war_cry" do
      WarCry.should_receive(:find).with("1") { @war_cry }
      get :edit, :id => "1"
      assigns(:war_cry).should == @war_cry
    end
    
  end
  
  describe "PUT #update action" do
    
    describe "when description is not empty" do
      
      before(:each) do
        @war_cry = Factory(:war_cry_with_assoc)
        
        WarCry.stub(:find).with("1").and_return { @war_cry }
      end
      
      it "should update it's attributes" do
        @war_cry.should_receive(:update_attributes).and_return(true)
        @war_cry.should_receive(:notify_to)
        
        put :update, :id => "1", :war_cry => { :description => 'a description' }
        assigns(:war_cry).should == @war_cry
      end
      
      it "should redirect to index action" do
        put :update, :id => "1", :war_cry => { :description => 'a description' }
        response.should redirect_to(creed_war_cries_path)
        flash[:notice].should == I18n.t('views.common.messages.update.successful', :model => I18n.t('activerecord.models.war_cry'), :genre => "o")
      end
      
    end
    
    describe "when description is empty" do
    
      before(:each) do
        @war_cry = Factory.build(:war_cry_with_assoc, :description => "")
        WarCry.stub(:find).and_return { @war_cry }
      end
    
      it "should NOT get saved" do
        @war_cry.should_receive(:save).and_return(false)
        @war_cry.should_not_receive(:notify_to)
      
        put :update, :id => "1", :war_cry => { :description => "" }
      end
      
      it "should render edit action" do
        put :update, :id => "1", :war_cry => { :description => "" }
        response.should render_template('edit')
      end
      
    end
  end
  
end