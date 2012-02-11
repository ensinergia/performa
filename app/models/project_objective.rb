class ProjectObjective < ActiveRecord::Base
  
  include Order
  
  belongs_to :project
  belongs_to :operative_objective
  
  def setorder(order)
    setorder(order)
  end
  
end
