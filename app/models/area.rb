class Area < ActiveRecord::Base
  has_many :functions

  belongs_to :user
  has_many :users
  belongs_to :company
  
  accepts_nested_attributes_for :functions, :allow_destroy => true
  
  validates_presence_of :name
  
  def self.get_all_for(company)
    self.includes(:users).where(:company_id => company.id)
  end
  
  def self.new_with_company(params, company)
    self.new(params.merge(:company_id => company.id))
  end
  
  def notify_to(users)
  end
  
  def is_root?
    is_root_area
  end
end
