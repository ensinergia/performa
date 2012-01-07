class OperatingCycle < ActiveRecord::Base
  include Shared
  
  attr_accessible :name, :reason, :company_id, :user_id, :internal_id, :clients__attributes,
    :key_activities_attributes, :services_attributes, :strategic_line_ids

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
  def notify_to(users)
  end

  def self.new_with_user(params, user)
    initialize_with_user(params, user)
  end
  
  def self.get_all_for(company)
    self.where(:company_id => company.id)
  end
  
end
