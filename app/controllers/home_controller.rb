class HomeController < ApplicationController
# before_action :authenticate_user!, only: [ :admin ]
# allow_unauthenticated_access only: %i[ index ]
include CanCan::ControllerAdditions
  def index
    @product = [
      { name: "Premium Shoes", description: "High-quality leather shoes for formal wear.", image_url: "https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp", sold: 5000 },
      { name: "Comfy Sneakers", description: "Perfect for casual walking and daily wear.", image_url: "https://img.daisyui.com/images/stock/photo-1559703248-dcaaec9fab78.webp", sold: 4500 },
      { name: "Mountain Boots", description: "Durable boots for adventurous hikes.", image_url: "https://img.daisyui.com/images/stock/photo-1572635148818-ef6fd45eb394.webp", sold: 4000 },
      { name: "Summer Sandals", description: "Light and breathable sandals for warm weather.", image_url: "https://img.daisyui.com/images/stock/photo-1494253109108-2e30c049369b.webp", sold: 3800 },
      { name: "Leather Wallet", description: "Elegant and durable leather wallet.", image_url: "https://img.daisyui.com/images/stock/photo-1550258987-190a2d41a8ba.webp", sold: 3500 }
      ]
    @page = params[:page] || "dashboard"
    # Assuming `params[:page]` is used to determine which page to render
    # case @page
    # when "dashboard"
    #   Rails.logger.debug "Trying to render: home/owner/#{params[@page]}"
    #   authorize! :access, :dashboard  # Ensure the user has access to the dashboard
    #   render partial: "home/owner/admin_dashboard", layout: false
    # when "invite-user"
    #   authorize! :access, :inviteUser # Ensure the user can invite users
    #   render partial: "devise/invitations/new", layout: false
    # else
    #   # Default rendering (if any)
    #   render "home/index"
    # end
    @current_user = current_user
  end
  def admin
  end
end
