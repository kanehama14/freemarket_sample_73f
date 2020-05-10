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
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
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
    rescue Payjp::CardError => e
      @message = "このカードはご利用になれません。お手数ですが、窓口までお問い合わせください。"
      redirect_to new_card_path, alert: @message
    end
    if token.blank?
      # redirect_to new_card_path
    else
      # 上記で作成したトークンをもとに顧客情報を作成
      customer = Payjp::Customer.create(card: token)
      card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if card.save!
        redirect_to card_path(card)
      else
        redirect_to new_card_path
      end
    end
  end

  def destroy #PayjpとCardデータベースを削除
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
    # @card1 = Card.find_by(user_id: current_user.id, id: params[:id])
    @card1 = Card.find_by(user_id: current_user.id)
    if @card1.blank?
      redirect_to action: "create"
    else
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      customer = Payjp::Customer.retrieve(@card1.customer_id)
      @card = Payjp::Customer.retrieve(@card1.customer_id).cards.data[0]
    end
  end
end
