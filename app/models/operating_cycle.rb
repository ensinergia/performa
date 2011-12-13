class OperatingCycle < ActiveRecord::Base
  attr_accessible :name, :reason, :company_id, :clients__attributes,
    :key_activities_attributes, :services_attributes
  #*************************************************
  #                   Relations                    *
  #*************************************************
 belongs_to :user
 belongs_to :company
 has_many :clients
 has_many :services
 has_many :key_activities
 accepts_nested_attributes_for :clients, :key_activities, :services, :allow_destroy => true
end
