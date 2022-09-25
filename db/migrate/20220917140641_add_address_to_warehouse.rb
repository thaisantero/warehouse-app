# frozen_string_literal: true

class AddAddressToWarehouse < ActiveRecord::Migration[7.0]
  def change
    add_column :warehouses, :address, :string
  end
end
