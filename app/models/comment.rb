class Comment < ActiveRecord::Base
  has_many :attachments, :as => :attachable, :dependent => :delete_all
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  
  validates_presence_of :content
  validates_presence_of :user
  validates_presence_of :commentable
  
  def set_attachments(attachs)
    attachs.each_value do |attachment|
      self.attachments.build(:content => attachment)
    end
  end
end
