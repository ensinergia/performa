class ProjectArea < ActiveRecord::Base
   include Order
  
  belongs_to :project
  belongs_to :area
  
  def setorder(order)
    setorder(order)
  end
  
end
