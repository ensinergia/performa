class AreaSupport < ActiveRecord::Base
  include Order
  
  belongs_to :area


  def supported
    Area.find(self.supported_id)
  end 
  
   def setorder(order)
    setorder(order)
  end

end
