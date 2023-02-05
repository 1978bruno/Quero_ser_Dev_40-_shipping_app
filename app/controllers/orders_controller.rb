class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  def new
  end
  def create
    order_params = params.require(:order).permit(:collect_street, :collect_number, :collect_nhood, :collect_city, :collect_state, :width, :height, :depth, :weight,
                                                :deliv_reipient, :deliv_street, :deliv_number, :deliv_nhood, :deliv_city, :deliv_state, :km_dist, :deliv_zip, :collect_zip)
    @order = Order.new(order_params)
    @order.user_id = current_user.id


    if @order.save
      redirect_to @order, notice: 'Pedido registrado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível registrar o pedido'
      render :new
    end
  end
  def show
    @order = Order.find(params[:id])
  end
end