class OperativeObjective < ActiveRecord::Base
  #*************************************************
  #                   Relations                    *
  #*************************************************
  belongs_to :user
  belongs_to :company
  has_and_belongs_to_many :strategic_lines, :uniq => true
  has_and_belongs_to_many :projects, :uniq => true
  has_many :pointers

  def notify_to(users)
  end
  
  def self.get_all_for(area_id)
    self.where(:area_id => area_id).order("id DESC")
  end
  #*************************************************
  #                   Instance Methods             *
  #*************************************************
  
end
