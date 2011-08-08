require 'subdomain_guards'
class AccountsController < ActionController::Base
  include SubdomainGuards
  layout 'application'
  
  before_filter :authenticate_user!
  before_filter :logged_in_user_to_action
  before_filter :verify_subdomain
  
  def index
    render :action => :user_info
  end
  
  def account_info
  end
  
  def user_info
  end
  
  def user_tasks
  end
  
  private 
  def logged_in_user_to_action
    @user = current_user
  end
  
end