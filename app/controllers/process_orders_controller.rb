class ProcessOrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @user = User.find(@order.user_id)
    @process_order = ProcessOrder.find_by(order_id: @order.id)
    show_process_order_shipping
    show_process_order_vehicle
  end

  def show_process_order_shipping
    @shipping = Shipping.find(@process_order.shipping_id)
    @cost = Cost.find_by(params[shipping: @shipping])
    @deliv_term = DelivTerm.find_by(params[shipping: @shipping])
  end

  def show_process_order_vehicle
    @vehicle = Vehicle.find(@process_order.vehicle_id)
    @vehicle_type = VehicleType.find(@vehicle.id)
  end

  def edit
    ProcessOrder.new(order_id: params[:id].to_i)
    @order = Order.find(params[:id])
    @user = current_user
    data_vehicle_for_order
    shipping_selection
  end

  def data_vehicle_for_order
    @vehicle = Vehicle.where(['status = ? and maximum_load_capacity > ?', 1, @order.weight]).take
    return if @vehicle.blank?

    @vehicle_category = VehicleCategory.find_by(id: @vehicle.vehicle_category)
    @vehicle_type = VehicleType.find_by(id: @vehicle.vehicle_type)
  end

  def shipping_selection
    @shippings = Shipping.where(['min_weight < ? and max_weight > ? and status = ?', @order.weight, @order.weight, 1])
    @cost = Cost.where(['int_min_weight < ? and int_max_weight > ?', @order.weight, @order.weight])
    @deliv_term = DelivTerm.where(['term_int_min_weight < ? and term_int_max_weight > ?', @order.weight, @order.weight])
    shipping_selection_alert
  end

  def shipping_selection_alert
    flash.now[:alert] = 'Sem cadastro do custo da modalidade de transporte' if @cost.empty?
    flash.now[:alert] = 'Sem cadastro do prazo de entrega da modalidade de transporte' if @deliv_term.empty?
    flash.now[:alert] = 'Sem cadastro de modalidade de transporte' if @shippings.empty?
  end

  def create; end
end
