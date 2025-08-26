class Abilities::Role::Admin < Ability
  def initialize(user)
    can :access, :dashboard
    can :invite, User
    can :access, :inviteUser
    can :manage, User
    can :manage, Employee
    can :manage, Category
    can :manage, Product
    can :read, Order
    can :update, Order
  end
end
