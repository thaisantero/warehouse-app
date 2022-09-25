class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show]
  def index
    @suppliers = Supplier.all
  end

  def show
  end

  private
  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(
      :corporate_name, :brand_name,
      :registration_number, :full_address, :city, :state, :email
    )
  end
end
