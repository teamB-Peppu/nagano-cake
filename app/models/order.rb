class Order < ApplicationRecord

  belongs_to :customer

  has_many :order_details, dependent: :destroy

  has_one_attached :image

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum delivery_address: { my_address: 0, address: 1, new_address: 2 }

  def sum_of_order_price
    total_payment - shipping_cost
  end

  enum status: { 入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4 }

end
