class StrategicLine < ActiveRecord::Base
  include Shared
  extend Shared::ClassMethods
  
  has_many :comments, :as => :commentable
  
  belongs_to :company
  belongs_to :user
  
  validates_presence_of :content
  
  
  def self.get_all_for(company)
    self.where(:company_id => company.id)
  end
  
  def notify_to(users)
  end
  
  def self.new_with_user(params, user)
    initialize_with_user(params, user)
  end
end
