class Area < ActiveRecord::Base
  has_many :functions

  belongs_to :user
  has_many :users
  has_many :operative_objectives
  has_many :strategic_lines
  has_many :strategic_objectives
  has_many :area_supports, :order=>"torder ASC"
  belongs_to :company
  
  
  accepts_nested_attributes_for :functions, :allow_destroy => true
  accepts_nested_attributes_for :area_supports, :allow_destroy => true
  
  validates_presence_of :name
  
  def self.get_all_for(company)
    self.includes(:users).where(:company_id => company.id).order("is_root_area,alevel,name ASC")
  end
  
  def self.new_with_company(params, company)
    self.new(params.merge(:company_id => company.id))
  end
  
  def notify_to(users)
  end
    
  
  def children_areas
    Area.where(:parent_id=>self.id)   
  end  
  
  def children
    supports=AreaSupport.where(:supported_id=>self.id )   
  end
  
  def is_root?
    is_root_area
  end
end
