class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @item = Item.find(params[:id])
    @order_details = @order.order_details
  end

  def update
   @order = Order.find(params[:id])
   @order_details = @order.order_details
    if @order.update(order_params)
       @order_details.update_all(making_status: "waiting") if @order.status == "confirm"
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
