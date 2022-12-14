# frozen_string_literal: true

class WarehousesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :set_warehouse, only: %i[show edit update destroy]

  def show
    @stocks = @warehouse.stock_products.where.missing(:stock_product_destination).group(:product_model).count
    @product_models = ProductModel.all
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)

    if @warehouse.save
      flash[:notice] = 'Galpão cadastrado com sucesso.'
      redirect_to root_path
    else
      flash.now[:notice] = 'Galpão não cadastrado.'
      render 'new'
    end
  end

  def edit; end

  def update
    @warehouse.update(warehouse_params)

    if @warehouse.update(warehouse_params)
      flash[:notice] = 'Galpão atualizado com sucesso.'
      redirect_to warehouse_path(@warehouse.id)
    else
      flash.now[:notice] = 'Não foi possível atualizar o galpão.'
      render 'edit'
    end
  end

  def destroy
    @warehouse.destroy
    flash[:notice] = 'Galpão removido com sucesso.'
    redirect_to root_path
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(:name, :city,
                                      :area, :code, :address, :cep, :description)
  end
end
