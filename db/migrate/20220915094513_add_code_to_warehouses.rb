# frozen_string_literal: true

class AddCodeToWarehouses < ActiveRecord::Migration[7.0]
  def change
    add_column :warehouses, :code, :string
  end
end
