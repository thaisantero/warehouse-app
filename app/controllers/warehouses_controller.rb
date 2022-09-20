class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find(params[:id])
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    warehouse_params = params.require(:warehouse).permit(:name, :city,
    :area, :code, :address, :cep, :description)
    @warehouse = Warehouse.new(warehouse_params)
    @warehouse.save
    
    if @warehouse.save
      flash[:notice] = 'Galpão cadastrado com sucesso.'
      redirect_to root_path
    else
      flash.now[:notice] = 'Galpão não cadastrado.'
      render 'new'
    end
  end
end
