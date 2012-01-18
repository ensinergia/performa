class Stage < ActiveRecord::Base
  has_many :steps, :dependent => :destroy
  accepts_nested_attributes_for :steps
end
