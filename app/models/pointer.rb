class Pointer < ActiveRecord::Base
  #*************************************************
   #                   Relations                    *
   #*************************************************
   belongs_to :user
   belongs_to :operative_objective


   def notify_to(users)
   end


   #*************************************************
   #                   Instance Methods             *
   #*************************************************
end
