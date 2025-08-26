module Customers
   module OrderHelper
     def show_stripe_checkout?(order)
      order&.persisted? && order&.order_transaction&.online?
     end
   end
end
