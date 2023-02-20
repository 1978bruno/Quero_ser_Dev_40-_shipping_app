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
      if @order.collect_street.empty? || @order.deliv_street.empty?
        if @order.collect_zip.present?
          api_collect = JSON.parse(Faraday.get("https://viacep.com.br/ws/#{@order.collect_zip}/json/").body)
          @order.collect_street = api_collect['logradouro']
          @order.collect_nhood = api_collect['bairro']
          @order.collect_city = api_collect['localidade']
          @order.collect_state = api_collect['uf']
        end
        if @order.deliv_zip.present?
          api_deliv = JSON.parse(Faraday.get("https://viacep.com.br/ws/#{@order.deliv_zip}/json/").body)
          @order.deliv_street = api_deliv['logradouro']
          @order.deliv_nhood = api_deliv['bairro']
          @order.deliv_city = api_deliv['localidade']
          @order.deliv_state = api_deliv['uf']
        end
        @order.errors.clear
      else
        flash.now[:alert] = 'Não foi possível registrar o pedido'
      end
      render :new
    end
  end
  def show
    @order = Order.find(params[:id])
    @user = User.find(@order.user_id)
    @shippings = Shipping.where(['min_weight < ? and max_weight > ?', @order.weight, @order.weight])
    if @shippings.empty?
    else
      shipping_id = @shippings[0]['id']
      @shipping_name = @shippings[0]['name']
      cost = Cost.where(['int_min_weight < ? and int_max_weight > ? and shipping_id = ?', @order.weight, @order.weight,
                         shipping_id])
      deliv_term = DelivTerm.where(['term_int_min_weight < ? and term_int_max_weight > ? and shipping_id = ?',
                                    @order.weight, @order.weight, shipping_id])
      if cost.empty? || deliv_term.empty?
        flash.now[:alert] = 'Sem cadastro de frete e/ou Custo'
      else
        @term_deliv = deliv_term[0]['deliv_term']
        @cost_km = cost[0]['km_value']
        @cost_fee = @shippings[0]['deliv_fee']
        @value_km = @order.km_dist * @cost_km / 100 + @cost_fee
      end
    end
  end
  def index
    @order = Order.where('status LIKE ?', 0)
  end
  def edit
    @order = Order.find(params[:id])
  end
  def update
    order_params = params.require(:order).permit(:collect_street, :collect_number, :collect_nhood, :collect_city, :collect_state, :width, 
                                                :height, :depth, :weight, :deliv_reipient, :deliv_street, :deliv_number, :deliv_nhood, 
                                                :deliv_city, :deliv_state, :km_dist, :deliv_zip, :collect_zip, :code)
    @order = Order.update(order_params)
    if order_params.empty?
      redirect_to order_path(@order), notice: 'Não foi possível atualizar os dados do veículo.'
    else
      redirect_to order_path(@order), notice: 'Dados do veículo atualizados com sucesso'
    end
  end
end
