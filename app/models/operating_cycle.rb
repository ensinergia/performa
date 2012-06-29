class OperatingCycle < ActiveRecord::Base
  include Shared
  include Order
  
  attr_accessible :name, :reason, :company_id,:area_id, :user_id, :internal_id, :clients_attributes,
    :stages_attributes, :services_attributes,:operative_objective_ids

  #*************************************************
  #                   Relations                    *
  #*************************************************
  belongs_to :user
  belongs_to :company
  has_many :clients, :dependent => :destroy,  :order=>"torder ASC"
  has_many :services, :dependent => :destroy,  :order=>"torder ASC"
  has_many :stages, :dependent => :destroy ,  :order=>"torder ASC"
  has_many :comments, :as => :commentable
  has_and_belongs_to_many :operative_objectives, :uniq => true
  accepts_nested_attributes_for :clients, :stages,:operative_objectives, :services, :allow_destroy => true
  
  #*************************************************
  #                   Instance Methods             *
  #*************************************************
  def notify_to(users)
  end

  def self.new_with_user(params, user)
    initialize_with_user(params, user)
  end
    
  def setorder(order)
    setorder(order)
  end
      
    
  def self.get_all_for(id)
    self.where(:area_id =>id).order("torder ASC")
  end
  
end
