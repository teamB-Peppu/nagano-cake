class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, presence: true
  validates :email, presence: true

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])[a-z\d]{6,}+\z/
  

  validates :last_name, :first_name, presence: true, format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/ }

  validates :last_name_kana, :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true
  validates_inclusion_of :is_active, in: [true, false]

  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  
  attr_accessor :payment_method

  def name
    "#{last_name} #{first_name}"
  end
  
  def name_kana
  "#{last_name_kana} #{first_name_kana}"
  end
  def customer_status
    if is_active == true
      "有効"
    else
      "退会"
    end
  end
  
  def active_for_authentication?
    super && (is_active == true)
  end
  
end
