class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :payment_method, presence: true
  
end
