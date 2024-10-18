class Admin::OrdersController < ApplicationController
  def show
    @orders = Order.all
    @order = Order.find(params[:id])
    @order_detail = Order_detail.find(params[:id])
    @customer = @order.customer
    @item = Item.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:name, :sipping_cost, :total_payment)
  end

  def order_detail_params
    params.require(:order_detail).permit(:price, :amount, :status)
  end

  def item_params
    params.require(:item).permit(:price)
  end

end
