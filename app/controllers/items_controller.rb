class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @item = Item.new
    @item.images.new
    # @item.users << current_user
  end

  def create
    # binding.pry
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path
    else
      render 'new'
    end
  end
  
  private
  def item_params
    # 仮でユーザーIDを１にしている
    params.require(:item).permit(:name, :explanation, :category_id, :size, :brand_name, :condition_id, :status_id, :delivery_fee_id, :prefecture_id, :delivery_day_id, :price, images_attributes: [:image]).merge(user_id: 1,status_id: 1) 
  end

end
