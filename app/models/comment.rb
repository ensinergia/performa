class Comment < ActiveRecord::Base
  has_many :attachments, :as => :attachable, :dependent => :delete_all
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  
  before_destroy :delete_attachments 
  
  validates_presence_of :content
  validates_presence_of :user
  validates_presence_of :commentable
  
  def set_attachments(attachs)
    attachs.each_value do |attachment|
      self.attachments.build(:content => attachment)
    end
  end
  
  def delete_attachments
    self.attachments.each { |attachment| attachment.remove_content! }
  end
  
  def self.find_and_destroy(id)
    comment = self.find(id)
    comment.attachments.each { |a| a.remove_content! }
    comment.destroy
    comment
  end
  
end
