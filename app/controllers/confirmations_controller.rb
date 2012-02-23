class Users::ConfirmationsController < Devise::ConfirmationsController 
     before_filter :set_redirect_location, :only => :show

     def set_redirect_location
         session["user_return_to"] = new_user_session_path
     end
end