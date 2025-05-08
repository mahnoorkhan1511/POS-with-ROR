class Admin::CategoriesController < Admin::BaseController
  before_action :authenticate_user!

  def index
    @categories = Category.all
  end
end
