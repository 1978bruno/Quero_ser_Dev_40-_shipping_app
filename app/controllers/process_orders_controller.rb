class ProcessOrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @user = User.find(@order.user_id)
    @process_order = ProcessOrder.find_by(order_id: @order.id)
    @shipping = Shipping.find(@process_order.shipping_id)
    @cost = Cost.find_by(params[shipping: @shipping])
    @deliv_term = DelivTerm.find_by(params[shipping: @shipping])
    @vehicle = Vehicle.find(@process_order.vehicle_id)
    @vehicle_type = VehicleType.find(@vehicle.id)
  end
  def edit
    ProcessOrder.new(order_id: params[:id].to_i)
    @order = Order.find(params[:id])
    @user = current_user

    @vehicle = Vehicle.where(['status = ? and maximum_load_capacity > ?', 1, @order.weight]).take
    if @vehicle.present?
      @vehicle_category = VehicleCategory.find_by(id: @vehicle.vehicle_category)
      @vehicle_type = VehicleType.find_by(id: @vehicle.vehicle_type)
    end

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

end