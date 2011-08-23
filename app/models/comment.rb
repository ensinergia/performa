class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  
  validates_presence_of :content
  validates_presence_of :user
  validates_presence_of :commentable
end
