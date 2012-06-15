class Pointer < ActiveRecord::Base
  #*************************************************
   #                   Relations                    *
   #*************************************************
   belongs_to :user
   belongs_to :operative_objective
   belongs_to :strategic_objective
   belongs_to :project
   
   has_many :assets, :dependent => :destroy
   
   accepts_nested_attributes_for :assets, :allow_destroy => true
   

   def notify_to(users)
   end


   #*************************************************
   #                   Instance Methods             *
   #*************************************************
end
