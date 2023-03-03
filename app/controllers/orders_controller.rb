class OrdersController < ApplicationController
  include OrdersControllerMethods
  before_action :authenticate_user!, only: %i[new edit]
  def index
    if current_user.nil?
      @order = ''
    else
      user = User.find_by(email: current_user.email)
      @order = Order.where('status = ? and user_id = ?', 0, user.id)
    end
  end

  def show
    @order = Order.find(params[:id])
    @user = User.find(@order.user_id)
    @process_order = ProcessOrder.find_by(order_id: params[:id])
    show_selection if @process_order.present?
  end

  def show_selection
    @shipping = Shipping.find_by(id: @process_order.shipping_id)
    @cost = Cost.find_by(shipping_id: @shipping)
    @deliv_term = DelivTerm.find_by(shipping_id: @shipping)
    @vehicle = Vehicle.find_by(id: @process_order.vehicle_id)
    @vehicle_type = VehicleType.find_by(id: @vehicle)
  end

  def new
    @order = Order.new
  end

  def edit
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:collect_street, :collect_number, :collect_nhood, :collect_city,
                                  :collect_state, :width, :height, :depth, :weight, :deliv_reipient,
                                  :deliv_street, :deliv_number, :deliv_nhood, :deliv_city, :deliv_state,
                                  :km_dist, :deliv_zip, :collect_zip)
  end

  def create
    order_params
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    redirect_to @order, notice: I18n.t(:order_register_successfuly) and return if @order.save

    select_zip_to_treat
    render :new
  end

  def select_zip_to_treat
    if @order.collect_street.empty? || @order.deliv_street.empty?
      collect_zip if @order.collect_zip.present?
      deliv_zip if @order.deliv_zip.present?
      @order.errors.clear
    else
      flash.now[:alert] = I18n.t(:order_register_unsuccessfuly)
    end
  end

  def collect_zip
    @zip_code = @order.collect_zip.to_s.rjust(8, '0')
    @zip = 'remetente'
    api_zip
    @order.collect_street = @api_data['logradouro']
    @order.collect_nhood = @api_data['bairro']
    @order.collect_city = @api_data['localidade']
    @order.collect_state = @api_data['uf']
  end

  def deliv_zip
    @zip_code = @order.deliv_zip.to_s.rjust(8, '0')
    @zip = 'destinatário'
    api_zip
    @order.deliv_street = @api_data['logradouro']
    @order.deliv_nhood = @api_data['bairro']
    @order.deliv_city = @api_data['localidade']
    @order.deliv_state = @api_data['uf']
  end

  def api_zip
    @api_data = JSON.parse(Faraday.get("https://viacep.com.br/ws/#{@zip_code}/json/").body)
    flash.now[:alert] = "CEP do #{@zip} inexistente" and return if @api_data['erro']
  end

  def update
    order_params
    if Order.update(params[:id], order_params).valid?
      redirect_to order_path(params[:id]), notice: I18n.t(:order_update_succefuly)
    else
      redirect_to order_path(params[:id]), notice: I18n.t(:order_update_unsuccefuly)
    end
  end

  def select_modal
    ProcessOrder.create!(order_id: params[:order_id], shipping_id: params[:shipping_id],
                         vehicle_id: params[:vehicle_id], total_cost: params[:total_cost])
    selec_modal_info
  end

  def selec_modal_info
    Vehicle.update(params[:vehicle_id], status: 2)
    Order.update(params[:id], status: 3)
    redirect_to order_path(params[:order_id])
  end
end
