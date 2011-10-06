class Role < ActiveRecord::Base
  has_many :users
  
  def self.default_role
    return Role.find_by_name('user')
  end
end
