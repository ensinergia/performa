describe ContextualLegendsController do
  
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    @user = Factory(:user)
    sign_in :user, @user
    @request.host = "#{@user.subdomain}.test.host"
  end
  
  describe "POST show" do
    
    before(:each) do
      @contextual_legend = Factory(:contextual_legend, :url => "/a_simple/path")
    end
    
    it "should assign a new record to @contextual_legend" do
      ContextualLegend.should_receive(:find) { @contextual_legend }
      post :show, :route => '/a_simple/path'
      assigns(:contextual_legend).should == @contextual_legend
    end
    
  end
  
end