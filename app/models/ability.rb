class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :access, :sessions
    can :read, :application

    # Registered users
    if user.persisted?
      can :update, :users, id: user.id

      if user.valid?
        can :read, :characters
        can :update, :characters, user_id: user.id
        can :access, :users, id: user.id
      end
    end
  end
end
