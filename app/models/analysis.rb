class Analysis < ActiveRecord::Base
  
  
  include Order
  
  has_many :comments, :as => :commentable
  belongs_to :swot
  belongs_to :user
  
  validates_presence_of :user, :swot, :content
  
  cattr_reader :weakness, :strength, :opportunity, :risk
  @@weakness = 1
  @@strength = 2
  @@risk = 3
  @@opportunity = 4 
  
  def weakness?
    self.kind == weakness
  end
  
  def risk?
    self.kind == risk
  end
  
  def opportunity?
    self.kind == opportunity
  end
  
  def strength?
    self.kind == strength
  end
  
  def is_internal?
    self.kind <= 2
  end
  
   def setorder(order)
    setorder(order)
  end
  
  def self.new_with_user(params, user)
    user.company.swot = Swot.new if user.company.swot.nil? 
    self.new params.merge({ :user => user, :swot => user.company.swot })
  end
  
  def self.create_with_user(params, user)
    analysis=self.new_with_user(params, user)
    analysis.save!
    analysis
  end
  
end
