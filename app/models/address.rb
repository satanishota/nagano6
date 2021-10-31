class Address < ApplicationRecord

  belongs_to :customer, foreign_key: 'customer_id'

  def full_address
    '〒' + postal_code + ' ' + address + ' ' + name
  end
end
