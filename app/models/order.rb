class Order < ApplicationRecord

  belongs_to :customer

  has_many :order_details, dependent: :destroy

  def sum_of_order_price
    total_payment - shipping_cost
  end

end
