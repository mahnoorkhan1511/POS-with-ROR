class Admin::CategoriesController < Admin::BaseController
  before_action :authenticate_user!

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
       redirect_back fallback_location: admin_categories_path, notice: "Category successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    name = @category.name
    @category.destroy
    redirect_to admin_categories_path, alert: "#{name} deleted along with related products !"
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
