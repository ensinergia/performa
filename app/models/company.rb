class Company < ActiveRecord::Base
  has_many :users
  has_many :areas
  
  
  validates_uniqueness_of :name
end
