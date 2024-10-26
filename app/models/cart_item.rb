class CartItem < ApplicationRecord
  
  belongs_to :customer
  belongs_to :item
  has_one_attached :image
  
  def subtotal
    item.add_tax_sales_price * amount
  end
  
end
