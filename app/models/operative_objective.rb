class OperativeObjective < ActiveRecord::Base
  include Order
  
  #*************************************************
  #                   Relations                    *
  #*************************************************
  belongs_to :user
  belongs_to :company
  belongs_to :area
  has_and_belongs_to_many :strategic_lines, :uniq => true
  has_and_belongs_to_many :operating_cycles
  has_many :pointers , :dependent=>:destroy
  has_many :project_objectives, :dependent=>:destroy
  has_many :comments, :as => :commentable
  def notify_to(users)
  end
  
   def setorder(order)
    setorder(order)
  end
  
   def init_sdate
    self.init_date
  end
  
  def final_sdate
    self.init_date
  end

  def self.get_all_for(area_id)
    self.where(:area_id => area_id).order("torder ASC")
  end
  
  def responsable
    unless self.responsable_id.nil?
      User.find(self.responsable_id)
    end
  end  
  
  #*************************************************
  #                   Instance Methods             *
  #*************************************************
  
   
end
