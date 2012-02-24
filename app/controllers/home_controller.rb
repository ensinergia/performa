class HomeController < ActionController::Base
  layout 'application'
  
  def index
  end
  
  def confirm
    user=User.where(:id=>params[:id], :confirmation_token=>params[:confirmation_token]).first
    unless user.nil?
      user.confirmed_at=Time.now
      user.save
      redirect_to new_user_session_url, :notice => t('views.mailer.thanks.confirm')
    else
      redirect_to new_user_session_url, :notice=>t('views.mailer.confirm.bad')
    end    
    
  end  
  
end