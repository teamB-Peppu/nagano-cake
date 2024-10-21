class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @current_customer = current_customer
    if @current_customer.nil?
      redirect_to login_path, alert: "ログインしていません"
    else
      @addresses = @current_customer.addresses
      @address = Address.new
      @customers = Customer.where.not(id: @current_customer.id)
    end
  end

  def create
    @address = current_customer.addresses.build(address_params)

    if @address.save
      redirect_to addresses_path
    else
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
  	@address = Address.find(params[:id])
  	@address.destroy
  	redirect_to addresses_path
  end


  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

  def correct_customer
    @customer = Customer.find(params[:id])
    redirect_to customer_path(current_customer.id) unless @customer == current_customer
  end

end
