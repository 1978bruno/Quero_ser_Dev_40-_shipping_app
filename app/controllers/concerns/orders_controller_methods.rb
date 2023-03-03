module OrdersControllerMethods
  extend ActiveSupport::Concern

  def canceled
    Order.update(params[:id], status: 2)
    redirect_to order_path(params[:id]), notice: I18n.t(:order_cancel_successfuly)
  end

  def delivered
    Order.update(params[:id], status: 1)
    vehicle_id = ProcessOrder.find_by(order_id: params[:id]).vehicle_id
    Vehicle.update(vehicle_id, status: 1)
    redirect_to order_path(params[:id])
  end

  def delivering
    @order = Order.where(status: 'delivering')
  end
end
