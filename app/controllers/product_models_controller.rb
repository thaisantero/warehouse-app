class ProductModelsController < ApplicationController
  def index
    @product_models = ProductModel.all
  end

  def new
    @product_model = ProductModel.new
    @suppliers = Supplier.all
  end

  def create
    @product_model = ProductModel.new(product_model_params)

    if @product_model.save
      flash[:notice] = 'Modelo de Produto cadastrado com sucesso.'
      redirect_to @product_model
    else
      flash.now[:notice] = 'Modelo de Produto não cadastrado.'
      render 'new'
    end
  end

  def show
    @product_model = ProductModel.find(params[:id])
  end

  private

  def product_model_params
    params.require(:product_model).permit(
      :name, :weight,
      :width, :height, :height, :depth, :sku, :supplier_id
    )
  end
end
