class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find(params[:id])
  end

  def new

  end

  def create
    warehouse_params = params.require(:warehouse).permit(:name, :city,
    :area, :code, :address, :cep, :description)
    w = Warehouse.new(warehouse_params)
    w.save
    
    flash[:notice] = 'Galpão cadastrado com sucesso.'
    redirect_to root_path
  end
end
