class Public::CustomersController < ApplicationController

  def show
    @customer = Customer.find_by(id: params[:id])
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
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find_by(id: params[:id])
    if @customer.id == current_customer.id
       @customer.update(customer_params)
       redirect_to customer_path
    else
      render :edit
    end
  end

  def unsubscribe
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
