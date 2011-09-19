class Creed < ActiveRecord::Base
  include Shared
  extend Shared::ClassMethods
  
  has_many :comments, :as => :commentable
  
  belongs_to :company
  belongs_to :user
  
  validates_presence_of :description
  
  validates_presence_of :company
  validates_presence_of :user
  
  has_paper_trail
    
  def self.new_or_update_with_user(id, params, user)
    creed=self.find(id)
    return creed if creed.description == params[:description] && user == creed.user
    # we only create a new vision when it's description and  
    # the user who shares it is not the same as the current
    self.new_with_user(params, user)
  end
  
  def self.new_with_user(params, user)
    initialize_with_user(params, user)
  end
    
  def self.get_current(company)
    eval("company.#{self.to_s.underscore.downcase}.versions.last.item") unless eval("company.#{self.to_s.underscore.downcase}").nil?
  end
  
  def notify_to(users)
  end
  
end