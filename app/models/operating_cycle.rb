class OperatingCycle < ActiveRecord::Base
  include Shared
  
  attr_accessible :name, :reason, :company_id,:area_id, :user_id, :internal_id, :clients_attributes,
    :stages_attributes, :services_attributes, :strategic_line_ids

  #*************************************************
  #                   Relations                    *
  #*************************************************
  belongs_to :user
  belongs_to :company
  has_many :clients, :dependent => :destroy
  has_many :services, :dependent => :destroy
  has_many :stages, :dependent => :destroy ,  :order=>"torder ASC"
  has_and_belongs_to_many :strategic_lines, :uniq => true
  accepts_nested_attributes_for :clients, :stages, :services, :allow_destroy => true
  
  #*************************************************
  #                   Instance Methods             *
  #*************************************************
  def notify_to(users)
  end

  def self.new_with_user(params, user)
    initialize_with_user(params, user)
  end
  
  def self.get_all_for(id)
    self.where(:area_id =>id)
  end
  
end
