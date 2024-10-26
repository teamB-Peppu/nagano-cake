class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses
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
    elsif params[:order][:delivery_address] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
    @cart_items = current_customer.cart_items
    @order_new = Order.new
    render :confirm
  end

  def thanks
  end

    def create
    order = Order.new(order_params)
    order.customer_id = current_customer.id
    order.shipping_cost = 800
    order.save
    @cart_items = current_customer.cart_items.all

    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id = order.id
      @order_details.item_id = cart_item.item.id
      @order_details.price = cart_item.item.add_tax_sales_price
      @order_details.amount = cart_item.amount
      @order_details.making_status = 0
      @order_details.save!
      end
      CartItem.destroy_all
      redirect_to orders_thanks_path
    end


  def index
    @customer = current_customer
    @orders = @customer.orders
    @order = Order.find_by(id: params[:id])
    @orders = current_customer.orders
  end

  def show
    @customer = current_customer
    @orders = @customer.orders
    @order = Order.find_by(id: params[:id])
    unless @order
      redirect_to root_path
    end
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :name, :address, :shipping_cost, :total_payment, :status)
  end

  def cartitem_nill
    cart_items = current_customer.cart_items
    if cart_items.blank?
      redirect_to cart_items_path
    end
  end
end