class Public::ItemsController < ApplicationController
  
  def index
    @items = Item.all
    @quantity = Item.count
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
  
  def add_to_cart
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
  
end
