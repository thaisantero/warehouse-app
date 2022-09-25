# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @warehouses = Warehouse.all
  end
end
