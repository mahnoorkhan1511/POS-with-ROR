class Admin::HomeController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @page = params[:page] || "dashboard"
    case @page
    when "dashboard"
      authorize! :access, :dashboard
      render "home/owner/admin_dashboard"
    when "invite-user"
      authorize! :access, :inviteUser
      render "devise/invitations/new"
    end
  end
end
