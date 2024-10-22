class Admin::OrdersController < ApplicationController
  def show
    @order = Order.includes(:order_details).find(params[:id])
  end

  def update
   @order = Order.includes(:order_details).find(params[:id])
    if @order.update(order_params)
     redirect_to admin_order_path(@order.id)
    else
     render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :sipping_cost, :total_payment, :status)
  end

  def order_detail_params
    params.require(:order_detail).permit(:price, :amount, :making_status)
  end

  def item_params
    params.require(:item).permit(:price)
  end

end
