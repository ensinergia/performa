class Task < ActiveRecord::Base
  
  belongs_to :user
  
  cattr_reader :high_priority
  @@high_priority = 1
end
