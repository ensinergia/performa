class Project < ActiveRecord::Base
    
  include Order
    
  #*************************************************
  #                   Relations                    *
  #*************************************************
  belongs_to :user
  belongs_to :company
  has_many :liabilities, :dependent => :destroy
  has_many :profits, :dependent => :destroy
  has_many :restrictions, :dependent => :destroy
  has_many :project_objectives
  accepts_nested_attributes_for :project_objectives,:liabilities, :restrictions, :profits, :allow_destroy => true
  
  #*************************************************
  #                   Instance Methods             *
  #*************************************************
  def notify_to(users)
  end

  def setorder(order)
    setorder(order)
  end
  
  def self.get_all_for(id)
    self.where(:area_id =>id)
  end

  
end
