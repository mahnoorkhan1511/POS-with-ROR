class Abilities::Role::Customer < Ability
  def initialize(user)
    can [ :new, :create ], Order
    can :index, Order
    can :show, Order, customer_id: user.customer.id
    can :create, Order
    can :success, Order, customer_id: user.customer.id
    can :stripe_checkout, Order
    can :create_stripe_session, Order
  end
end
