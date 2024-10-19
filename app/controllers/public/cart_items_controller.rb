class Public::CartItemsController < ApplicationController
  
  def index
    @cart_items = current_customer.cart_items
    @total = 0
  end
  
  def create
    increase_or_create(params[:cart_item][:item_id])
  end
    
  

	def destroy
		@cart_item = CartItem.find(params[:id])
		@cart_item.destroy
		redirect_to public_cart_items_path
	end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to public_cart_items_path
  end
	
	
	private

	def cart_item_item?
		redirect_to public_item_path(params[:cart_item][:item_id]), notice: "個数を入力してください。" if params[:cart_item][:number_of_items].empty?
	end

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
  
end
