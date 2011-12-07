module PeopleHelper
  def resource_name
     :user
   end

   def resource
     @resource ||= User.new
   end
   
   def resource!(user)
      @resource ||= User.new(user)
      @resource.company_id=params[:user][:company_id]
      @resource.area_id=params[:user][:area_id]
      @resource.position_id=1
      @resource.password= Digest::SHA1.hexdigest("--#{Time.now.to_s}-login--")[0,6]
      @resource.password_confirmation = @resource.password
    end

   def devise_mapping
     @devise_mapping ||= Devise.mappings[:user]
   end
   
   def devise_error_messages!
         return "" if resource.errors.empty?
         return resource.errors
      end
        
      
   
end
