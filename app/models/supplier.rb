class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email, presence: true
  validates :registration_number, length: { is: 14 }, uniqueness: true
end
