# encoding: utf-8
require 'spec_helper'

describe StrategicLinesController do
  
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    @user = Factory(:user)
    sign_in :user, @user
    @request.host = "#{@user.subdomain}.test.host"
  end
  
  describe "GET index" do
    
    describe "when none strategic lines are registered" do
      
      before(:each) do
        @strategic_lines = []
      end
      
      it "should assign 'them' to @strategic_lines" do
        StrategicLine.should_receive(:get_all_for) { @strategic_lines }
        get :index
        assigns(:strategic_lines).should == @strategic_lines
      end
      
      it "should render the welcome empty index template" do
        get :index
        response.should render_template('index_welcome')
      end
      
    end
    
    describe "when some strategic lines are registered" do
      
      before(:each) do  
        @strategic_line = ['one', 'two']
      end
      
      it "should assign them to @strategic_lines" do
        StrategicLine.should_receive(:get_all_for) { @strategic_lines }
        get :index
        assigns(:strategic_lines).should == @strategic_lines
      end
      
      it "should render the index template" do
        get :index
        response.should render_template('index')
      end
      
    end
    
  end
  
  describe "GET new" do
    
    before(:each) do
      @strategic_line = StrategicLine.new
    end
    
    it "should assign a new record to @strategic_line" do
      StrategicLine.should_receive(:new) { @strategic_line }
      get :new
      assigns(:strategic_line).should == @strategic_line
    end
    
  end
  
  describe "POST #create action" do
    
    before(:each) do
      @strategic_line = Factory(:strategic_line, :content => "some content")
    end
    
    describe "on successful save" do
     
      before(:each) do
        @strategic_line.stub(:save).and_return(true)
      end
     
      it "should save an strategic line, assign it to @strategic_line and send notifications" do
        StrategicLine.stub(:new_with_user).and_return { @strategic_line }
        @strategic_line.should_receive(:notify_to).with({"2" => "1"})
        post :create, :strategic_line => { :content => "come content"}, :users => {"2" => "1"}
        assigns(:strategic_line).should == @strategic_line
      end 
      
      it "should redirect to index action" do
        StrategicLine.stub(:new_with_user).and_return { @strategic_line }
        post :create
        response.should redirect_to(strategic_lines_path)
      end
      
      it "should set a flash message" do
        StrategicLine.stub(:new_with_user).and_return { @strategic_line }
        post :create
        flash[:notice].should == I18n.t('views.strategic_lines.messages.save.successful')
      end
      
    end
    
    describe "on unsuccessful save" do
      
      before(:each) do
        @strategic_line.stub(:save).and_return(false)
      end
      
      it "should render the new action" do
        StrategicLine.stub(:new_with_user).and_return { @strategic_line }
        post :create
        response.should render_template('new')
      end
      
    end

  end
  
  
  describe "DELETE destroy" do
    
    before(:each) do
      @strategic_line = Factory(:strategic_line)
    end
    
    it "should assign the record to be destroyed" do
      StrategicLine.should_receive(:find).with('1') { @strategic_line }
      @strategic_line.should_receive(:destroy)
      delete :destroy, :id => '1'
    end
    
    it "should redirect to index action" do
      delete :destroy, :id => '1'
      response.should redirect_to(strategic_lines_path)
    end
    
  end
  
  describe "GET edit" do
    
    before(:each) do
      @strategic_line = Factory(:strategic_line)
    end
    
    it "should find and assign a record to an @strategic_line" do
      StrategicLine.should_receive(:find).with('1') { @strategic_line }
      get :edit, :id => '1'
      assigns(:strategic_line).should == @strategic_line
    end
    
  end
  
  describe "PUT update" do
    
    describe "when content is not empty" do
      
      before(:each) do
        @strategic_line = Factory(:strategic_line)
        
        StrategicLine.stub(:find).with("1").and_return { @strategic_line }
      end
      
      it "should update it's attributes" do
        @strategic_line.should_receive(:update_attributes).and_return(true)
        @strategic_line.should_receive(:notify_to)
        
        put :update, :id => "1", :strategic_line => { :content => 'some contents' }
        assigns(:strategic_line).should == @strategic_line
      end
      
      it "should redirect to index action" do
        put :update, :id => "1", :strategic_line => { :content => 'some contents' }
        response.should redirect_to(strategic_lines_path)
        flash[:notice].should == I18n.t('views.strategic_lines.messages.update.successful')
      end
      
    end
    
    describe "when content is empty" do
    
      before(:each) do
        @strategic_line = Factory.build(:strategic_line, :content => "")
        StrategicLine.stub(:find).and_return { @strategic_line }
      end
    
      it "should NOT get updated" do
        @strategic_line.should_receive(:save).and_return(false)
        @strategic_line.should_not_receive(:notify_to)
      
        put :update, :id => "1", :strategic_line => { :content => "" }
      end
      
      it "should render edit action" do
        put :update, :id => "1", :strategic_line => { :content => "" }
        response.should render_template('edit')
      end
      
    end
    
  end
  
end