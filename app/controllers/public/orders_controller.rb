class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  

  def index
    @customer = current_customer
    @orders = @customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:delivery_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:delivery_address] == "1"
      @address = Address.find(params[:order][:delivery_address])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:elivery_address] = "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
      render 'new'
    end
      @cart_items = current_member.cart_items.all
      @order.member_id = current_member.id
  end
  
  def create
    @order = Order.new(order_params)
      @order.customer_id = current_customer.id
      @order.save
      
      current_customer.cart_items.each do |cart_item|
        @order_details = OrderDetail.new
        @order_details.order_id = order.id
        @order_details.item_id cart_item.item.id
        @order_details.price = cart_item.item.add_tax_sales_price
        @order_details.amount = cart_item.amouto
        @order_details.making_status = 0
        @order_details.save
      end
  end

  def thanks
  end
  
  private
  
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :name, :address, :shipping_cost, :total_payment, :status)
  end
end