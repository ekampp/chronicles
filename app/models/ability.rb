class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :create, :user

    # Registered user
    if user.persisted?
      cannot :create, :user
      can :update, [ User, user ]

      # admin
      if user.role == :admin
        can :manage, Project
      end
    end
  end
end
