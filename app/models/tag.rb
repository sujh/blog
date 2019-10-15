class Tag < ApplicationRecord

  belongs_to :post

  validates :value, length: { maximum: 10 }

end