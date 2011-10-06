#encoding: utf-8
require 'spec_helper'

describe AreasController do
  
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    @user = Factory(:user)
    sign_in :user, @user
    @request.host = "#{@user.subdomain}.test.host"
  end
  
  describe "GET #new action" do
    
    it "should assign a new area record to @area" do
      Area.should_receive(:new) { 'an area' }
      get :new
      assigns(:area).should_not be_nil
    end
    
    it "should render the new template" do
      Area.should_receive(:new) 
      get :new
      response.should render_template('new')
    end
    
  end
  
  describe "POST #create action" do
    
    before(:each) do
      @area = Factory(:area, :name => "An Area")
    end
    
    describe "on successful save" do
     
      before(:each) do
        @area.stub(:save).and_return(true)
      end
     
      it "should save an strategic line, assign it to @strategic_line and send notifications" do
        Area.stub(:new_with_company).and_return { @area }
        @area.should_receive(:notify_to)
        post :create, :area => { :name => "An Area"}, :functions => { 'some functions' => [] }
        assigns(:area).should == @area
      end 
      
      it "should redirect to people controller index action" do
        Area.stub(:new_with_company).and_return { @area }
        post :create
        response.should redirect_to(people_path)
      end
      
      it "should set a flash message" do
        Area.stub(:new_with_company).and_return { @area }
        post :create
        flash[:notice].should == I18n.t('views.common.messages.save.successful', :model => "Área", :genre => "a")
      end
      
    end
    
    describe "on unsuccessful save" do
      
      before(:each) do
        @area.stub(:save).and_return(false)
      end
      
      it "should render the new action" do
        Area.stub(:new_with_company).and_return { @area }
        post :create
        response.should render_template('new')
      end
      
    end

  end
  
  describe "GET #edit" do
    
    before(:each) do
      @area = Factory(:area, :name => "An Area")
    end
    
    it "should find area and assign it to @area" do
      Area.should_receive(:find).with('1') { @area }
      get :edit, :id => '1'
      assigns(:area).should == @area
    end
    
  end
  
  describe "PUT #update action" do
    
    before(:each) do
      @area = Factory(:area, :name => "An Area")
    end
    
    describe "on successful update" do
     
      before(:each) do
        @area.stub(:update_attributes).and_return(true)
      end
     
      it "should save an strategic line, assign it to @strategic_line and send notifications" do
        Area.stub(:find).and_return { @area }
        @area.should_receive(:notify_to)
        put :update, :id => '1', :area => { :name => "An Area"}, :functions => { 'some functions' => [] }
        assigns(:area).should == @area
      end 
      
      it "should redirect to people controller index action" do
        Area.stub(:find).and_return { @area }
        put :update, :id => '1'
        response.should redirect_to(people_path)
      end
      
      it "should set a flash message" do
        Area.stub(:find).and_return { @area }
        put :update, :id => '1'
        flash[:notice].should == I18n.t('views.common.messages.update.successful', :model => "Área", :genre => "a")
      end
      
    end
    
    describe "on unsuccessful update" do
      
      before(:each) do
        @area.stub(:update_attributes).and_return(false)
      end
      
      it "should render the edit action" do
        Area.stub(:find).and_return { @area }
        put :update, :id => '1'
        response.should render_template('edit')
      end
      
    end

  end
  
  describe "GET admin" do
    
    before(:each) do
      @users = [Factory.build(:user)]
      @area = Factory.build(:area)
    end
    
    it "show retrieve the list of users in a company and assign it to @people" do
      User.should_receive(:all) { @users }
      get :admin, :id => "1"
      assigns(:people).should == @users
    end
    
    it "show retrieve the root area in a company and assign it to @area" do
      Area.should_receive(:first).and_return { @area }
      get :admin, :id => "1"
      assigns(:area).should == @area
    end
  
    it "show retrieve the list of users in a company" do
      User.stub(:all)
      get :admin, :id => "1"
      response.should render_template('admin')
    end
  end
end
