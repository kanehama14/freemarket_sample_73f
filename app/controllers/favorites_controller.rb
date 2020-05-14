class FavoritesController < ApplicationController

  def index
    @favorites = Favorite.where(user_id: current_user.id)
  end

  def create
    @favorite = current_user.favorites.create(item_id: params[:item_id])
    @item = Item.find(params[:item_id])
    @favorite_find = @item.favorites.find_by(user_id: current_user.id)
    render 'favorites/index.js.erb'
  end
   
   def destroy
    @favorite = current_user.favorites.find_by(item_id: params[:id].to_i).destroy
    @item = Item.find(params[:id])
    render 'favorites/index.js.erb'
  end

end
