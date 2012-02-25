#encoding: utf-8
require 'subdomain_guards'
class HomeController < ActionController::Base
  include SubdomainGuards
  layout 'application_index_page'

  
  
  def index
  end
  
  def confirm
    @user=User.where(:id=>params[:id], :confirmation_token=>params[:confirmation_token]).first
    unless @user.nil?
      @user.confirmed_at=Time.now
      @user.save
      unless @user.password.nil?
        redirect_to new_user_session_url, :notice => t('views.mailer.thanks.confirm')
      end 
      sign_in @user 
    else      
        redirect_to new_user_session_url, :notice=>t('views.mailer.confirm.bad')
    end    
    
  end  
  
end