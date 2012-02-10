module Order
  
  def self.included(base)
    base.extend(ClassMethods)
  end


  module ClassMethods
    def setorder(order)
      order.each_with_index  do |id,index|
        @obj = self.find(id)
        @obj.torder=index
        @obj.save
      end
    end
  end  
  

end    