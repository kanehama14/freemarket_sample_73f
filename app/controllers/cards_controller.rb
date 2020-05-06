class CardsController < ApplicationController
  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to users_path
    else
      render 'new'
    end
    binding.pry
  end

  private
  def card_params
    # 仮でユーザーIDを１にしている
    params.require(:card).permit(:customer_id, :card_id).merge(user_id: 1) 
  end
end
