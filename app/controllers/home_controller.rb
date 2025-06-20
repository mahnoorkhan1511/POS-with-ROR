class HomeController < ApplicationController
  def index
    @products = Product.published
    @categories = Category.all
    @tags = Tag.all
  end

  def search
    if params[:query].present?
      @products = Product.search_by_name(params[:query])
      @products_by_category = Product.search_by_category(params[:query])
      @products_by_tags = Product.search_by_tags(params[:query])
    else
        @products = []
        @products_by_category = []
        @products_by_tags = []
    end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("search_results", partial: "shared/search_results",
          locals: {
            param: params[:query],
            products: @products,
            products_by_category: @products_by_category,
            products_by_tags: @products_by_tags
          }
        )
      end
    end
  end

  def filter
    minimum = params[:min]
    maximum = params[:max]
    categories = Category.where(id: params[:category_ids]).pluck(:name)
    if categories.empty?
      categories = Category.all.pluck(:name)
    end
    @products = Product.filter_products(categories, minimum, maximum)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("filter_results", partial: "shared/filter_results",
          locals: {
            products: @products
          }
        )
      end
    end
  end
end
