class CardsController < ApplicationController
  # payjpをロード
  require "payjp"

  def new
    @card = Card.new
    # card = Card.where(user_id: current_user.id)
    card = Card.where(user_id: 1)
    if card.exists?
      redirect_to card_path(card[0].id)
    end
  end

  def create
    # 秘密鍵を設定
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    # トークンを作成 
    token = Payjp::Token.create({
      card: {
        number:     params[:card][:number],
        cvc:        params[:card][:cvc],
        exp_month:  params[:card][:exp_month],
        exp_year:   params[:card][:exp_year]
      }},
      {'X-Payjp-Direct-Token-Generate': 'true'} 
    )
    if token.blank?
      redirect_to new_card_path
    else
      # 上記で作成したトークンをもとに顧客情報を作成
      customer = Payjp::Customer.create(card: token)
      # card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      @card = Card.new(user_id: 1, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "create"
      end
    end
  end

  def show
    # show画面にテストデータを入れる
    # @default_card_information = {number: "4242424242424242", exp_month: "12", exp_year: "2020"}
    # card = Card.find_by(user_id: current_user.id)
    card = Card.find_by(user_id: 1)
    if card.blank?
      redirect_to action: "create"
    else
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      customer = Payjp::Customer.retrieve(card.customer_id)
      @card = Payjp::Customer.retrieve(card.customer_id).cards.data[0]
    end
  end
end
