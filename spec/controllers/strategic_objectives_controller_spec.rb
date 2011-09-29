# encoding: utf-8
require 'spec_helper'

describe StrategicObjectivesController do
  before :each do
    request.env['devise.mapping'] = Devise.mappings[:user]
    @user = Factory(:user)
    sign_in :user, @user
    @request.host = "#{@user.subdomain}.test.host"
  end

  describe "GET index" do
    describe "when none strategic objectives are registered" do
      before :each do
        Company.any_instance.should_receive(:strategic_objectives).and_return([])
      end

      it "should assign @strategic_objectives with an empty Array" do
        get :index
        assigns(:strategic_objectives).should be_a_kind_of(Array)
        assigns(:strategic_objectives).should be_empty
      end
      it "should render the welcome empty index template" do
        get :index
        response.should render_template('index_welcome')
      end
    end

    describe "when some strategic objectives are registered" do
      before :each do
        strategic_objective = [
          Factory(:strategic_objective, :company => @user.company, :user => @user),
          Factory(:strategic_objective, :company => @user.company,:user => @user)
        ]
        Company.any_instance.should_receive(:strategic_objectives).and_return(strategic_objective)
      end

      it "should assign @strategic_objectives with an Array with the objectives" do
        get :index
        assigns(:strategic_objectives).should be_a_kind_of(Array)
        assigns(:strategic_objectives).should_not be_empty
      end

      it "should render the index template" do
        get :index
        response.should render_template('index')
      end
    end
  end

  describe "GET new" do
    before(:each) do
      @strategic_objective = StrategicObjective.new
    end

    it "should assign a new record to @strategic_objective" do
      StrategicObjective.should_receive(:new) { @strategic_objective }
      get :new
      assigns(:strategic_objective).should == @strategic_objective
    end
  end

  describe "POST #create action" do
    before(:each) do
      @strategic_objective = Factory(:strategic_objective, :content => "some content")
    end

    describe "on successful save" do
      before(:each) do
        @strategic_objective.stub(:save).and_return(true)
        StrategicObjective.stub(:new_with_user).and_return { @strategic_objective }
      end

      it "should save an strategic objective, assign it to @strategic_objective and send notifications" do
        @strategic_objective.should_receive(:notify_to).with({"2" => "1"})
        post :create, :strategic_objective => { :content => "come content"}, :users => {"2" => "1"}
        assigns(:strategic_objective).should == @strategic_objective
      end

      it "should redirect to index action" do
        post :create
        response.should redirect_to(strategic_objectives_path)
      end

      it "should set a flash message" do
        post :create
        flash[:notice].should == I18n.t('views.common.messages.save.successful', :model => "Objetivos Estratégicos", :genre => "os")
      end
    end

    describe "on unsuccessful save" do
      before(:each) do
        @strategic_objective.stub(:save).and_return(false)
      end

      it "should render the new action" do
        StrategicObjective.stub(:new_with_user).and_return { @strategic_objective }
        post :create
        response.should render_template('new')
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      @strategic_objective = Factory(:strategic_objective)
    end

    it "should assign the record to be destroyed" do
      StrategicObjective.should_receive(:find).with('1') { @strategic_objective }
      @strategic_objective.should_receive(:destroy)
      delete :destroy, :id => '1'
    end

    it "should redirect to index action" do
      StrategicObjective.should_receive(:find).with('1') { @strategic_objective }
      delete :destroy, :id => '1'
      response.should redirect_to(strategic_objectives_path)
    end
  end

  describe "GET edit" do
    before(:each) do
      @strategic_objective = Factory(:strategic_objective)
    end

    it "should find and assign a record to an @strategic_objective" do
      StrategicObjective.should_receive(:find).with('1') { @strategic_objective }
      get :edit, :id => '1'
      assigns(:strategic_objective).should == @strategic_objective
    end
  end

  describe "PUT update" do
    describe "when content is not empty" do
      before(:each) do
        @strategic_objective = Factory(:strategic_objective)
        StrategicObjective.stub(:find).with("1").and_return { @strategic_objective }
      end

      it "should update it's attributes" do
        @strategic_objective.should_receive(:update_attributes).and_return(true)
        @strategic_objective.should_receive(:notify_to)

        put :update, :id => "1", :strategic_objective => { :content => 'some contents' }
        assigns(:strategic_objective).should == @strategic_objective
      end

      it "should redirect to index action" do
        put :update, :id => "1", :strategic_objective => { :content => 'some contents' }
        response.should redirect_to(strategic_objectives_path)
        flash[:notice].should == I18n.t('views.common.messages.update.successful', :model => "Objetivos Estratégicos", :genre => "os")
      end

    end

    describe "when content is empty" do
      before(:each) do
        @strategic_objective = Factory.build(:strategic_objective, :content => "")
        StrategicObjective.stub(:find).and_return { @strategic_objective }
      end

      it "should NOT get updated" do
        @strategic_objective.should_receive(:save).and_return(false)
        @strategic_objective.should_not_receive(:notify_to)

        put :update, :id => "1", :strategic_objective => { :content => "" }
      end

      it "should render edit action" do
        put :update, :id => "1", :strategic_objective => { :content => "" }
        response.should render_template('edit')
      end
    end
  end
end
