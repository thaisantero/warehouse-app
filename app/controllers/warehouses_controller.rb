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

    if @warehouse.save
      flash[:notice] = 'Galpão cadastrado com sucesso.'
      redirect_to root_path
    else
      flash.now[:notice] = 'Galpão não cadastrado.'
      render 'new'
    end
  end

  def edit
    id = params[:id]
    @warehouse = Warehouse.find(id)
      
  end

  def update
    id = params[:id]
    @warehouse = Warehouse.find(id)
    warehouse_params = params.require(:warehouse).permit(:name, :city,
      :area, :code, :address, :cep, :description)
    @warehouse.update(warehouse_params)

    if @warehouse.update(warehouse_params)
      flash[:notice] = 'Galpão atualizado com sucesso.'
      redirect_to warehouse_path(@warehouse.id)
    else
      flash.now[:notice] = 'Não foi possível atualizar o galpão.'
      render 'edit'
    end
  end
end
