module Shared
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def initialize_with_user(params, user)
      self.new(params.merge(:user => user, :company => user.company))
    end
  end
end
