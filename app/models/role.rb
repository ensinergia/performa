class Role
  
  @@super_admin = 99
  @@admin = 88
  @@user = 77
  
  cattr_accessor :super_admin, :admin, :user
  
  def self.default_role
    return @user
  end
end
