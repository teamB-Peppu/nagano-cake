class Admin::OrderDetailsController < ApplicationController

  def update
   @order = Order.find(params[:id])
   @order_detail = OrderDetail.find(params[:order_detail][:order_detail_id])
   @order_details = @order.order_details
   
   
    if @order_detail.update(order_detail_params)
       @order.update(status: "production") if @order_detail.making_status == "production"
       @order.update(status: "preparation") if @order_details.all? { |detail| detail.making_status == "ok" }
         redirect_to admin_order_path(@order.id)
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

