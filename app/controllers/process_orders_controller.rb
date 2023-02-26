class ProcessOrdersController < ApplicationController
  def show

  end
  def edit
    Order.update(params[:id], status: 3)
    ProcessOrder.new(order_id: params[:id].to_i)
    @order = Order.find(params[:id])
    @user = current_user

    @vehicle = Vehicle.where(['status = ? and maximum_load_capacity > ?', 1, @order.weight]).take
    @vehicle_category = VehicleCategory.find_by(id: @vehicle.vehicle_category)
    @vehicle_type = VehicleType.find_by(id: @vehicle.vehicle_type)

    @shippings = Shipping.where(['min_weight < ? and max_weight > ? and status = ?', @order.weight, @order.weight, 1])
    @cost = Cost.where(['int_min_weight < ? and int_max_weight > ?', @order.weight, @order.weight])
    @deliv_term = DelivTerm.where(['term_int_min_weight < ? and term_int_max_weight > ?', @order.weight, @order.weight])
    
    if @shippings.empty?
      flash.now[:alert] = 'Sem cadastro de modalidade de transporte'
    elsif @cost.empty?
      flash.now[:alert] = 'Sem cadastro do custo da modalidade de transporte'
    elsif @deliv_term.empty?
      flash.now[:alert] = 'Sem cadastro do prazo de entrega da modalidade de transporte'
    end

  end
  def create
    shipping = params[:id]
    
  end

  def canceled
    Order.update(params[:id], status: 2)
    return_to order_path(params[:id])
  end
  def delivered
    Order.update(params[:id], status: 1)
    return_to order_path(params[:id])
  end

end