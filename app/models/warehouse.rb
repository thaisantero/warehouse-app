class Warehouse < ApplicationRecord
  validates :name, :city, :area, :code, :address, :cep, :description, presence: true
  validates :code, length: { is: 3 }
  validates :code, uniqueness: true
end