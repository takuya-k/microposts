class FavoritesController < ApplicationController
  before_action :logged_in_user
  
  def create
    @micropost = params[:id]
    current_user.favolite(@micropost)
  end
  
  def destroy
    @micropost = params[:id]
    current_user.unfavolite(@micropost)
  end
end
