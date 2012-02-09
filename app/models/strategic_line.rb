class StrategicLine < ActiveRecord::Base
  include Shared
  include Order

  has_many :comments, :as => :commentable
  has_many :strategic_line_strategic_objective
  
  has_many :strategic_objectives, :through => :strategic_line_strategic_objective
  has_and_belongs_to_many :operating_cycles
  belongs_to :company
  belongs_to :user

  validates_presence_of :content


  def self.get_all_for(company)
    self.where(:company_id => company.id).order("torder ASC")
  end

  def notify_to(users)
  end

  def self.new_with_user(params, user)
    initialize_with_user(params, user)
  end
end
