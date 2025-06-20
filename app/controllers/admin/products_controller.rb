class Admin::ProductsController < Admin::BaseController
  before_action :authenticate_user!
  before_action :set_product, only: %i[ show edit update destroy ]
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      @product.product_status = :drafted
      # @product[:status] = "drafted"
      assign_tags()
      redirect_to admin_products_path
      flash[:notice] =" #{@product.name} created successfully! "
      puts("--------  product saved. --------")
    else
      redirect_to new_admin_product_path
      flash[:alert] = "Error while saving the product !"
    end
  end
  def show
  end

  def edit
  end
  def update
    puts params.inspect
    if @product.update(product_params)
      puts @product.product_status
      assign_tags()
      redirect_to [ :admin, @product ]
      flash[:notice] =" #{@product.name} updated successfully! "
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @name = @product.name
    @product.destroy
    redirect_to admin_products_path
    flash[:alert] = "#{@name} deleted !"
  end
  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name,
    :description,
    :featured_image,
    :cost_price,
    :sales_price,
    :tag_names,
    :category_id,
    :product_status)
  end

  # using this function instead of nested attributes to prevent duplication of tags
  def assign_tags
    return unless product_params[:tag_names]
    # splitting by comma, removing spaces around the tag and removing empty tags
    tag_names = params[:product][:tag_names].split(",").map(&:strip).reject(&:blank?)
    tags = tag_names.map { |tag| Tag.find_or_create_by(tag: tag.downcase) }
    @product.tags = tags
    puts ("----------tags if saved are shown below--------")
    puts @product.tags
  end
end
