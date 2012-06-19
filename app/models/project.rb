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
  has_many :project_tasks, :dependent => :destroy, :order=>"torder ASC"
  has_many :project_areas, :dependent => :destroy, :order=>"torder ASC"
  has_many :project_members, :dependent => :destroy, :order=>"role ASC"
  has_many :comments, :as => :commentable
  has_many :pointers , :dependent=>:destroy
  
  accepts_nested_attributes_for :project_objectives,:liabilities, :restrictions, :profits, :project_tasks,:project_areas,:project_members, :allow_destroy => true
  
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
