module Order
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  
  def self.reorder(order)
      order.each_with_index  do   |id,index|
        @obj = self.find(id)
        @obj.torder=index
        @obj.save
      end
    end

  module ClassMethods
  end
  
end    