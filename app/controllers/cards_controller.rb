class CardsController < ApplicationController
  # payjpをロード
  require "payjp"

  def new
    @card = Card.new
    card = Card.where(user_id: current_user.id)
    if card.exists?
      redirect_to card_path(card[0].id)
    end
  end

  def create
    # 秘密鍵を設定
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    begin
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
      customer = Payjp::Customer.create(card: token)
      card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if card.save!
        redirect_to card_path(card)
      else
        redirect_to new_card_path
      end
    rescue Payjp::CardError => e
      @message = "このカードはご利用になれません。入力情報を確認してください。"
      redirect_to new_card_path, alert: @message
    end
  end

  def destroy
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "new"
  end

  def show
    @card1 = Card.find_by(user_id: current_user.id)
    if @card1.blank?
      redirect_to action: "create"
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(@card1.customer_id)
      @card = Payjp::Customer.retrieve(@card1.customer_id).cards.data[0]
    end
  end
end
