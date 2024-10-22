class Admin::HomesController < ApplicationController
  def top
    @orders = Order.page(params[:page]).per(10)
  end

  private

  def order_params
    params.require(:order).permit(:created_at, :name, :status)
  end

  def order_detail_params
    params.require(:order_detail).permit(:name, :status, :amount)
  end

end
