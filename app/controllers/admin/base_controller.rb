class Admin::BaseController < ApplicationController
  before_action :authorize_admin
  # TODO: set layout here for admins
  layout "admin"
  private
  def authorize_admin
    authorize! :access, :dashboard
  end

  # def set_layout
  #   "admin"
  # end
  # TODO: create method to set layout for admins
end
