class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  def new
    @order = Order.new
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
    @user = User.find(params[:id])
    shipping = Shipping.where(["min_weight < ? and max_weight > ?", @order.weight, @order.weight])
    if shipping.empty?

    else
      shipping_id = shipping[0]["id"]
      @shipping_name = shipping[0]["name"]
      cost = Cost.where(["int_min_weight < ? and int_max_weight > ? and shipping_id = ?", @order.weight, @order.weight, shipping_id])
      deliv_term = DelivTerm.where(["term_int_min_weight < ? and term_int_max_weight > ? and shipping_id = ?", @order.weight, @order.weight, shipping_id])
      @term_deliv = deliv_term[0]["deliv_term"]
      @cost_km = cost[0]["km_value"]
      @cost_fee = shipping[0]["deliv_fee"]
      @value_km = @order.km_dist * @cost_km/100 + @cost_fee
    end

  end
  def index
    @order = Order.where("status LIKE ?", 0)
  end
end