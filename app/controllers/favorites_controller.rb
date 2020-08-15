class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @wine = Wine.find(params[:wine_id])
    current_user.favorite(@wine)
    flash[:success] = 'いいねしました！'
    redirect_back(fallback_location: root_url)
  end

  def destroy
    @wine = Wine.find(params[:wine_id])
    current_user.unfavorite(@wine)
    flash[:success] = 'いいねを解除しました！'
    redirect_back(fallback_location: root_url)
  end
end
