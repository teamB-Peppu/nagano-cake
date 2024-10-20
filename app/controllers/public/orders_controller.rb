class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  

  def index
    @orders = Order.where(customer: current_customer).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirm
    @cart_items = CartItem.where(customer: current_customer)
    @shipping_cost = 800
    @selected_paymet_method = params[:order][:payment_method]

    ary = []
    @cart_items.each do |cart_item|
      ary << cart_item.item.price * cart_item.quantity
    end
    @cart_items_price = ary.sum

    @total_payment = @shipping_cost + @cart_items_price
    @address_type = params[:order][:address_type]
    case @address_type
    when "customer_address"
      @selected_address = current_customer.postal_code + " " + current_customer.address + " " + current_customer.last_name + current_customer.first_name
    when "registered_address"
      unless params[:order][:registered_address_id] == ""
        selected = Address.find(params[:order][:address_id])
        @selected_address = selected.postal_code + " " + selected.address + " " + selected.name
      else
        render :new
      end
    when "new_address"
      unless params[:order][:new_postal_code] == "" && params[:order][:new_address] == "" && params[:order][:new_name] == ""
        @selected_address = params[:order][:new_postal_code] + " " + params[:order][:new_address] + " " + params[:order][:new_name]
      else
        render :new
      end
    end
  end
  
  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to customers_confirm_path
    else
      render :new
    end
  end

  def thanks
  end
  
  private
  
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :name, :address, :shipping_cost, :total_payment, :status)
  end
end