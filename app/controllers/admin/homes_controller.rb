class Admin::HomesController < ApplicationController
  def top
    @order = Order.find(params[:id])
    @order_detail = Order_detail.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:created_at, :name, :status)
  end

  def order_detail_params
    params.require(:order_detail).permit(:amount)
  end

end
