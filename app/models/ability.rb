class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user

      if user.role? :owner
        can :manage, :all
      elsif user.role? :admin
        can :manage, :all
      else
        can :read, :all
      end
    end
end
