class Product < ApplicationRecord
  has_one_attached :cover_image
  has_many_attached :images
end
