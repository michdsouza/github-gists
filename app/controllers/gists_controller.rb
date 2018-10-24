class GistsController < ApplicationController

  def index
    @gists = Github::Gateway.get_private_gists(current_user)
  end

  def new
  end

  def show
  end

  def update
  end

  def destroy
  end
end
