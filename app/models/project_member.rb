class ProjectMember < ActiveRecord::Base
   belongs_to :project
   belongs_to :user
   
   
   
   def member
      user
   end 
end
