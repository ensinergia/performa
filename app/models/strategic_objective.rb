class StrategicObjective < ActiveRecord::Base
  include Shared
  extend Shared::ClassMethods

  has_many :comments, :as => :commentable

  has_many :strategic_line_strategic_objective
  has_many :strategic_lines, :through => :strategic_line_strategic_objective

  belongs_to :company
  belongs_to :user

  accepts_nested_attributes_for :strategic_lines

  validates_presence_of :content


  def notify_to(users)
  end

  def self.new_with_user(params, user)
    initialize_with_user(params, user)
  end
end
