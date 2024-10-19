class Item < ApplicationRecord

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  belongs_to :genre

  has_one_attached :image

  def add_tax_sales_price
    (self.sales_price * 1.10).round
  end

  enum status: { on_sale: 0, off_sale: 1 }

end
