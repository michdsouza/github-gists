class GistsController < ApplicationController

  def index
    @gists = Github::Gateway.get_private_gists(current_user)
  end

  def new
    @gist = Gist.new
  end

  def create
    if Github::Gateway.save(gist_params.to_json, current_user)
      redirect_to gists_path, notice: "Gist was successfully created."
    else
      render :new
    end
  end

  def edit
    @gist = Github::Gateway.get_gist(params[:id], current_user)
  end

  def update
    Github::Gateway.update_gist(params[:id], params[:gist].to_json, current_user)
    redirect_to gists_path, notice: "Gist was successfully updated."
  end

  def destroy
  end

  private

  def gist_params
    params.require(:gist).permit(:description, :filename, :content)
  end

end
