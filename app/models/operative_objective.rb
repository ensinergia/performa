class OperativeObjective < ActiveRecord::Base
  #*************************************************
  #                   Relations                    *
  #*************************************************
  belongs_to :user
  belongs_to :company
  has_many :clients
  has_many :services
  has_many :key_activities
  has_and_belongs_to_many :strategic_lines, :uniq => true
  accepts_nested_attributes_for :clients, :key_activities, :services, :allow_destroy => true
  
  #*************************************************
  #                   Instance Methods             *
  #*************************************************
  
end
