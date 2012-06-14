
class StrategicObjective < ActiveRecord::Base
  include Shared
  include Order
  has_many :comments, :as => :commentable

  has_many :strategic_line_strategic_objective
  has_many :strategic_lines, :through => :strategic_line_strategic_objective
  has_many :pointers , :dependent=>:destroy

  belongs_to :company
  belongs_to :user
  belongs_to :area

  accepts_nested_attributes_for :strategic_lines

  validates_presence_of :content

   def self.get_all_for(company)
    self.where(:company_id => company.id).order("torder ASC")
  end

   def setorder(order)
    setorder(order)
  end


  def notify_to(users)
  end

  def self.new_with_user(params, user)
    initialize_with_user(params, user)
  end
  
 
  
end
