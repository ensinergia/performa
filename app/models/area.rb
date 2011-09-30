class Area < ActiveRecord::Base
  belongs_to :company
  has_many :users
  has_many :functions
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
end
