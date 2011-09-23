# encoding: utf-8
require 'spec_helper'

describe Admin::ContextualLegendsController do
  
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    @user = Factory(:user)
    sign_in :user, @user
    @request.host = "#{@user.subdomain}.test.host"
  end
  
  describe "GET new" do
    
    before(:each) do
      @contextual_legend = ContextualLegend.new
    end
    
    it "should assign a new record to @contextual_legend" do
      ContextualLegend.should_receive(:new) { @contextual_legend }
      get :new
      assigns(:contextual_legend).should == @contextual_legend
    end
    
  end
  
  describe "GET edit" do
    
    before(:each) do
      @contextual_legend = Factory(:contextual_legend)
    end
    
    it "should find the record and assign it to @contextual_legend" do
      ContextualLegend.should_receive(:find) { @contextual_legend }
      get :edit, :id => "1"
      assigns(:contextual_legend).should == @contextual_legend
    end
    
  end
  
  describe "POST #create action" do
    
    before(:each) do
      @contextual_legend = Factory(:contextual_legend, :content => "some content", :url => admin_contextual_legends_path)
    end
    
    describe "when content is not empty" do
     
      before(:each) do
        @contextual_legend.stub(:save).and_return(true)
      end
     
      it "should save the contextual legend, assign it to @contextual_legend and send notifications" do
        ContextualLegend.stub(:new).and_return { @contextual_legend }
        post :create, :contextual_legend => { :content => "some contextual help legend"}
        assigns(:contextual_legend).should == @contextual_legend
      end 
      
      it "should redirect to index action" do
        ContextualLegend.stub(:new).and_return { @contextual_legend }
        post :create, :contextual_legend => { :content => "" }
        response.should redirect_to(@contextual_legend.url)
      end
      
      it "should set a flash message" do
        ContextualLegend.stub(:new).and_return { @contextual_legend }
        post :create, :contextual_legend => { :content => "" }
        flash[:notice].should == I18n.t('views.common.messages.save.successful', :model => I18n.t("activerecord.models.contextual_legend"), :genre => "a")
      end
      
    end
    
    describe "when content is empty" do
      
      before(:each) do
        @contextual_legend.stub(:save).and_return(false)
      end
      
      it "should render the new action" do
        ContextualLegend.stub(:new).and_return { @contextual_legend }
        post :create, :contextual_legend => {:content => "" }
        response.should render_template('new')
      end
      
    end

  end
  
  describe "PUT #update" do
    
    describe "when content is not empty" do
      
      before(:each) do
        @contextual_legend = Factory(:contextual_legend, :url => admin_contextual_legends_path)
        
        ContextualLegend.stub(:find).with("1").and_return { @contextual_legend }
      end
      
      it "should update it's attributes" do
        @contextual_legend.should_receive(:update_attributes).and_return(true)
        
        put :update, :id => "1", :contextual_legend => { :content => 'some contents' }
        assigns(:contextual_legend).should == @contextual_legend
      end
      
      it "should redirect to stored contextual legend action" do
        put :update, :id => "1", :contextual_legend => { :content => 'some contents' }
        response.should redirect_to(admin_contextual_legends_path)
        flash[:notice].should == I18n.t('views.common.messages.update.successful', :model => I18n.t("activerecord.models.contextual_legend"), :genre => "a")
      end
      
    end
    
    describe "when content is empty" do
    
      before(:each) do
        @contextual_legend = Factory.build(:contextual_legend, :content => "")
        ContextualLegend.stub(:find).and_return { @contextual_legend }
      end
    
      it "should NOT get updated" do
        @contextual_legend.should_receive(:save).and_return(false)
      
        put :update, :id => "1", :contextual_legend => { :content => "" }
      end
      
      it "should render edit action" do
        put :update, :id => "1", :contextual_legend => { :content => "" }
        response.should render_template('edit')
      end
      
    end
    
  end
  
end