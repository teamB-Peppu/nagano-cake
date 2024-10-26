class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  def add_tax_sales_price
    (self.price * 1.10).round
  end

  def subtotal
    return add_tax_sales_price * amount
  end

  enum making_status: { aa: 0, waiting: 1, production: 2, ok: 3 }


end
