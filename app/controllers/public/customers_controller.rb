class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def create
    @customer = current_customer.customers.create(customer_params)

    if @customer.save
      redirect_to customer_path
    else
      render :edit
    end
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
       redirect_to customers_path
    else
      render :edit
    end
  end

  def unsubscribe
    @customer = current_customer
  end
  
  def withdraw
    @customer = current_customer
    @customer.update(is_active: true)
    reset_session
    redirect_to root_path
  end


  private

  def customer_params
    params.require(:customer).permit(:name, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end

  def correct_customer
    @customer = Customer.find(params[:id])
    redirect_to customer_path(current_customer.id) unless @customer == current_customer
  end



end
