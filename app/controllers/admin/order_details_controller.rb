class Admin::OrderDetailsController < ApplicationController

  def update
   @order = Order.find(params[:id])
   @order_details = OrderDetail.find(params[:order_detail][:order_detail_id])
    if @order_details.update!(order_detail_params)
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

end
