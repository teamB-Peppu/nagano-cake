class Order < ApplicationRecord

  belongs_to :customer

  has_many :order_details, dependent: :destroy
  has_many :items

  has_one_attached :image

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum delivery_address: { my_address: 0, address: 1, new_address: 2 }
  enum status: { waiting: 0, confirm: 1, production: 2, preparation: 3, shipped: 4 }

  def sum_of_order_price
    total_payment - shipping_cost
  end

  def add_tax_sales_price
    order_details.sum(:price) * 1.1
  end

  def subtotal
    item.add_tax_sales_price * amount
  end

  def item
    order_detail = self.order_details.first
    if order_detail
      item = order_detail.item
      return item
    else
      return nil
    end
  end

  def amount
    order_details.sum(:amount)
  end

end
