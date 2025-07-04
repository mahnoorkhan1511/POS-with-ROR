class Admin::BaseController < ApplicationController
  before_action :authorize_admin

  layout "admin"
  private
  def authorize_admin
    authorize! :access, :dashboard
  end
end
