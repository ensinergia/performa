class Vision < ActiveRecord::Base
  
  belongs_to :company
  belongs_to :user
    
  validates_presence_of :description
  
  validates_presence_of :company
  validates_presence_of :user
  
  before_create :make_current
  after_create :umake_current
    
  def self.new_or_update_with_user(id, params, user)
    vision=self.find(id)
    return vision if vision.description == params[:description] && user == vision.user
    # we only create a new vision when it's description and  
    # the user who shares it is not the same as the current
    self.new_with_user(params, user)
  end  
  
  def self.new_with_user(params, user)
    self.new(params.merge(:user => user, :company => user.company, :current => true))
  end
    
  def self.get_current(company)
    company.vision
  end
  
  def notify_to(users)
  end
  
  private
  def make_current
    self.current = true
  end
  
  # TODO: Mover a Trigger en PostgreSQL
  def umake_current
    @current_vision = Vision.last(:conditions => ["id != '?' AND current is TRUE AND company_id = '?'", id, company.id])
    @current_vision.update_attribute(:current, false) if @current_vision
  end
  
end
