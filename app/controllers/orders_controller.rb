class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_and_check_user, only: [:show, :edit, :update, :delivered, :canceled]

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save
      redirect_to @order, notice: 'Pedido registrado com sucesso.'
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:alert] = 'Não foi possível registrar o pedido.'
      render 'new'
    end
  end

  def show; end

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
    @order.update(order_params)
    redirect_to @order, notice: 'Pedido atualizado com sucesso.'
  end

  def search
    @code = params[:query]
    @orders = Order.where('code LIKE ?', "%#{@code}%")
  end

  def delivered
    @order.delivered!
    redirect_to @order

    @order.order_items.each do |item|
      item.quantity.times do 
        StockProduct.create(warehouse: @order.warehouse, order: @order, product_model: item.product_model)
      end
    end
  end

  def canceled
    @order.canceled!
    redirect_to @order
  end

  private
  def set_order_and_check_user
    @order = Order.find(params[:id])
    if @order.user != current_user
      return redirect_to root_path, alert: 'Você não possui acesso a esta pedido.'
    end
  end
end
