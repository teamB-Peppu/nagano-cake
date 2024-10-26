class Public::ItemsController < ApplicationController
  before_action :check_item_activation, only: [:show]

  def index
    @items = Item.all
    @items = Item.where(is_active: true).page(params[:page]).per(8)
    @quantity = Item.count
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  def add_to_cart
    unless logged_in?
      flash[:error] = "会員登録またはログインが必要です"
      redirect_back(fallback_location: root_path)
      return
    end
  
    @item = Item.find(params[:item_id])
    if params[:amount].blank?
      flash[:error] = "個数を選択してください"
      redirect_to @item
      return
    end
    cart_item = current_customer.cart_items.find_by(item_id: @item.id)
    if cart_item.present?
      cart_item.update(amount: cart_item.amount + params[:amount].to_i)
    else
      current_customer.cart_items.create(item: @item, amount: params[:amount])
    end
    redirect_to cart_items_path
  end
  
  private

  def check_item_activation
    item = Item.find(params[:id])
    redirect_to root_path unless item.is_active
  end
  
  private

  def require_login
    unless logged_in?
      redirect_to :back, notice: "ログインが必要です"
    end
  end
  
  def logged_in?
    current_customer.present?
  end

end