class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :name, :sku, :weight, :width, :height, :depth, presence: true
  validates :sku, uniqueness: true
  validates :sku, length: { is: 20 }
  validates :weight, :width, :height, :depth, numericality: { greater_than_or_equal_to: 0 }
end
