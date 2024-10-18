class Public::CustomersController < ApplicationController
  def show
  end

  def edit
  end

  def unsubscribe
  end

  protected
  
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :name, :last_name, :first_name, :kana_last, :kana_first, :postal_code, :address, :telephone_number])
  end

end
