class ItemsController < ApplicationController
  before_action :index_category_set, only: :index
  before_action :set_item, only: [:edit, :update, :destroy, :show]
  before_action :ensure_correct_user, only: [:edit]
  # before_action :a, only: [:new]

  def index
    @images = Image.all
    @categories = Category.where('ancestry IS NULL')
    @items = Item.where(status: 1).order('created_at ASC')
  end

  def show
  end

  def new
    # 登録ボタン名
    @submit_btn = ['new','出品する']
    @item = Item.new
    @item.images.new
    # @item.users << current_user
    @category_parents = Category.where('ancestry IS NULL').map{ |category|[category.name, category.name] }
  end

  def create
    @submit_btn = ['new','出品する']
    # バリデーションチェックで引っかかって出品画面に戻ったとき、上の変数がないとエラーになる。
    @status = 1
    # ステータスの状態を「出品中：１」にして登録する
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path(@item)
    else
      render :new
      # 「render :new」ではなく「redirect_to」でnew画面を呼び出したいがエラーメッセージが表示されなくなってしまう
      # redirect_toにしてエラーメッセージをセッションで表示する方法に修正したい。
    end
  end

  def edit
    # 登録ボタン名
    @submit_btn = ['edit','更新する']
    # @category_parents = Category.where('ancestry IS NULL').map{ |category|[category.name, category.name] }
    # @category_childs = @item.category_id.parent.parent.children.map{ |category|[category.name, category.id] }
    # @category_grandchilds = @item.category_id.parent.children.map{ |category|[category.name, category.id] }
  end

  def update
    @submit_btn = ['edit','更新する']
    # ステータスの状態を「出品中：１」にして登録する
    @status = 1
    if @item.update(item_params)
      redirect_to item_path(@item), notice: '出品情報を更新しました'
    else
      render :edit
    end
  end
  
  # 親カテゴリーが選択された際に動く(Ajax)
  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  # 子カテゴリーが選択された際に動く(Ajax)
  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :edit
    end
  end

  private
  def item_params
    params
    .require(
      :item
    )
    .permit(
      :name, 
      :explanation, 
      :category_id, 
      :size, 
      :brand_name, 
      :condition_id, 
      :status_id, 
      :delivery_fee_id, 
      :prefecture_id, 
      :delivery_day_id, 
      :price, 
      images_attributes: [:image, :_destroy, :id]
    )
    .merge(
      user_id: current_user.id,
      status_id: @status
    ) 
  end

  def index_category_set
    search_anc = Category.where('ancestry IS NULL')
    array = []
    search_anc.each do |i|
      array << i[:id]
    end
    for num in array do
      search_anc = Category.where('ancestry LIKE(?)', "#{num}%")
      ids = []
      search_anc.each do |i|
        ids << i[:id]
      end
      items = Item.where(category_id: ids).order("id DESC").limit(10)
      instance_variable_set("@cat_no#{num}", items)
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def ensure_correct_user
    if current_user != @item.user
      redirect_to new_user_session_path
    end
  end

  # def a
  #   if !user_signed_in?
  #     redirect_to items_path
  #   end
  # end

end
