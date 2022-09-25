# frozen_string_literal: true

class RemoveCodigoFromWarehouses < ActiveRecord::Migration[7.0]
  def change
    remove_column :warehouses, :codigo, :string
  end
end
