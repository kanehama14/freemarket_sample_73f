class UsersController < ApplicationController
  def new
  end

  def index
  end

  def logout
  end

  # payjpをロード
  # require "payjp"
  def credit_regist
  #   card = Card.find_by(user_id: 1)
  #   Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
  #   customer = Payjp::Customer.retrieve(card.customer_id)
  #   @card = Payjp::Customer.retrieve(card.customer_id).cards.data[0]
  end

end