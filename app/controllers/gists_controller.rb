class GistsController < ApplicationController
  before_action :authorize_user
  rescue_from Github::ApiError, with: :render_error

  def index
    @gists = Github::Gateway.get_gists(current_user)
  end

  def new
    @gist = Gist.new(nil)
  end

  def create
    if Github::Gateway.create(gist_params.to_json, current_user)
      redirect_to gists_path, notice: 'Gist was successfully created.'
    else
      render :new
    end
  end

  def edit
    @gist = Github::Gateway.get_gist(params[:id], current_user)
  end

  def update
    Github::Gateway.update_gist(params[:id], params[:gist].to_json, current_user)
    redirect_to gists_path, notice: 'Gist was successfully updated.'
  end

  def destroy
    Github::Gateway.delete_gist(params[:id], current_user)
    redirect_to gists_path, notice: 'Gist was successfully deleted.'
  end

  private

  def gist_params
    params.require(:gist).permit(:description, :filename, :content)
  end

  def authorize_user
    redirect_to root_url unless current_user
  end
end
