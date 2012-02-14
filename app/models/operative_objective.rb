class OperativeObjective < ActiveRecord::Base
  include Order
  
  #*************************************************
  #                   Relations                    *
  #*************************************************
  belongs_to :user
  belongs_to :company
  has_and_belongs_to_many :strategic_lines, :uniq => true
  has_many :pointers , :dependent=>:destroy
  has_many :project_objectives, :dependent=>:destroy

  def notify_to(users)
  end
  
   def setorder(order)
    setorder(order)
  end

  def self.get_all_for(area_id)
    self.where(:area_id => area_id).order("torder ASC")
  end
  
  #*************************************************
  #                   Instance Methods             *
  #*************************************************
  
   
end
