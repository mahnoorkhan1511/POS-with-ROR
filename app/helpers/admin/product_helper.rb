module Admin
  module ProductHelper
    def creation_status(product)
     if product.published?
      content_tag(:p, "Published", class: "text-sky-600 pr-5 text-l font-semibold mt-1")
     elsif product.reviewed?
      content_tag(:p, "Reviewed", class: " text-emerald-700 pr-5 text-l font-semibold mt-1")
     else
      content_tag(:p, "Drafted", class: "text-yellow-600 pr-5 text-l font-semibold mt-1")
     end
    end
  end
end
