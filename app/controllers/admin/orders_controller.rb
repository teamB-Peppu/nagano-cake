class Admin::OrdersController < ApplicationController
  def show
    @order = Order.includes(:order_details).find(params[:id])
  end

  def update
   @order = Order.includes(:order_details).find(params[:id])
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
