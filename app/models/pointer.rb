class Pointer < ActiveRecord::Base
  #*************************************************
   #                   Relations                    *
   #*************************************************
   belongs_to :user
   belongs_to :operative_objective
   
   has_many :assets, :dependent => :destroy
   
   accepts_nested_attributes_for :assets, :allow_destroy => true
   

   def notify_to(users)
   end


   #*************************************************
   #                   Instance Methods             *
   #*************************************************
end
