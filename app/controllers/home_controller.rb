class HomeController < ApplicationController
# before_action :authenticate_user!, only: [ :admin ]
# allow_unauthenticated_access only: %i[ index ]
include CanCan::ControllerAdditions
  def index
    @products = Product.all
  end
end
