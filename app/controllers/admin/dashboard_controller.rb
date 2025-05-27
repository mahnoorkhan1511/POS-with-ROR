class Admin::DashboardController < Admin::BaseController
  before_action :authenticate_user!
  # load_and_authorize_resource

  def index
    # authorize! :access, :dashboard
    @product = [
      { name: "Premium Shoes", description: "High-quality leather shoes for formal wear.", image_url: "https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp", sold: 5000 },
      { name: "Comfy Sneakers", description: "Perfect for casual walking and daily wear.", image_url: "https://img.daisyui.com/images/stock/photo-1559703248-dcaaec9fab78.webp", sold: 4500 },
      { name: "Mountain Boots", description: "Durable boots for adventurous hikes.", image_url: "https://img.daisyui.com/images/stock/photo-1572635148818-ef6fd45eb394.webp", sold: 4000 },
      { name: "Summer Sandals", description: "Light and breathable sandals for warm weather.", image_url: "https://img.daisyui.com/images/stock/photo-1494253109108-2e30c049369b.webp", sold: 3800 },
      { name: "Leather Wallet", description: "Elegant and durable leather wallet.", image_url: "https://img.daisyui.com/images/stock/photo-1550258987-190a2d41a8ba.webp", sold: 3500 }
      ]
    # render partial: "admin/admin_dashboard"
  end
end
