class Admin::TagsController < Admin::BaseController
  def index
    if params[:query].present?
      @tags = Tag.where("name ILIKE?", "%#{params[:query]}%")
    else
      @tags = Tag.all
    end
    respond_to do |format|
      format.json { render json: @tags.pluck(:name) }
    end
  end
end
