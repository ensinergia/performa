class Position < ActiveRecord::Base
  has_many :users
  
  def self.owner
    'owner'
  end
  
  def self.employee
    'employee'
  end
  
  def self.admin
    'admin'
  end
  
  def self.get_owner
    self.first(:conditions => {:name => Position.owner})
  end
end
