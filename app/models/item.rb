class Item < ApplicationRecord

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  belongs_to :genre

  has_one_attached :image
  
  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

  def add_tax_sales_price
    (self.price * 1.10).round
  end
  
  def status
    if is_active == true
      "販売中"
    else
      "販売停止中"
    end
  end
  
  def active_for_authentication?
    super && (is_active == true)
  end

end
