class Admin::ProductsController < Admin::BaseController
  before_action :authenticate_user!
  before_action :set_product, only: %i[ show edit update ]
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
      # render :new
      puts("--------  product saved. --------")
    else
      render :new
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
    else
      render :edit, status: :unprocessable_entity
    end
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
