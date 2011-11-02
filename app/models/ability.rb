class Ability
  include CanCan::Ability
 
  def initialize(user)
    user ||= User.new

    if user.guest?
      can :manage, :all, :user_id => user.id
      cannot :manage, PoiSet
      cannot :read, User

    elsif user.registered?
      can :manage, :all, :user_id => user.id
      cannot :read, User

    elsif user.admin?
      can :manage, :all
    end

  end
end
