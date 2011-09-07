class Vision < ActiveRecord::Base
  has_many :comments, :as => :commentable
  
  belongs_to :company
  belongs_to :user
    
  validates_presence_of :description
  
  validates_presence_of :company
  validates_presence_of :user
  
  has_paper_trail
    
  def self.new_or_update_with_user(id, params, user)
    vision=self.find(id)
    return vision if vision.description == params[:description] && user == vision.user
    # we only create a new vision when it's description and  
    # the user who shares it is not the same as the current
    self.new_with_user(params, user)
  end  
  
  def self.new_with_user(params, user)
    self.new(params.merge(:user => user, :company => user.company))
  end
    
  def self.get_current(company)
    company.vision.versions.last.item unless company.vision.nil?
  end
  
  def notify_to(users)
  end
  
end
