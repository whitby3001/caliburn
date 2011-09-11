class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new
    
    can :read, Product

    if user.admin?
      can :manage, :all
    end
  end
end