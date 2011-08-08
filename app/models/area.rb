class Area < ActiveRecord::Base
  belongs_to :company
  has_many :users
end
