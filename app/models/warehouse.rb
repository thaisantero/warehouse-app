# frozen_string_literal: true

class Warehouse < ApplicationRecord
  validates :name, :city, :area, :code, :address, :cep, :description, presence: true
  validates :code, length: { is: 3 }, uniqueness: true
  validates :cep, length: { is: 8 }
  has_many :stock_products

  def full_description
    "#{code} - #{name}"
  end
end
