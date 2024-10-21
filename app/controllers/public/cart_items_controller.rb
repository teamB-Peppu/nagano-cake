class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items
    @total = 0
  end

  def create
    increase_or_create(params[:cart_item][:item_id])
    redirect_to cart_items_path
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_back(fallback_location: root_path)
  end

	def destroy
		@cart_item = CartItem.find(params[:id])
		@cart_item.destroy
		redirect_to cart_items_path
	end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end


	private

  def increase_or_create(item_id)
    @cart_item = current_customer.cart_items.find_by(item_id: item_id)

    if @cart_item
      @cart_item.amount += 1
    else
      @cart_item = current_customer.cart_items.build(item_id: item_id)
    end

    @cart_item.save
  end

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
