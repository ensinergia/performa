class Project < ActiveRecord::Base
    
  include Order
    
  #*************************************************
  #                   Relations                    *
  #*************************************************
  belongs_to :user
  belongs_to :company
  has_many :liabilities, :dependent => :destroy, :order=>"torder ASC"
  has_many :profits, :dependent => :destroy, :order=>"torder ASC"
  has_many :restrictions, :dependent => :destroy, :order=>"torder ASC"
  has_many :project_objectives, :dependent => :destroy, :order=>"torder ASC"
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
    self.where(:area_id =>id).order("torder ASC")
  end

  
end
