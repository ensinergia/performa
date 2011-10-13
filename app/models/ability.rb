class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user

      if user.role? Role.super_admin
        can :manage, :all
      elsif user.role? Role.admin
        can :manage, :all
      else
        can :read, :all
      end
    end
end
