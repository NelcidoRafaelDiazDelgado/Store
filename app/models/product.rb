class Product < ApplicationRecord
 has_paper_trail

 enum :status, {
    draft: 0,
    active: 1,
    archived: 2,
    out_of_stock: 3
  }


  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :min, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
