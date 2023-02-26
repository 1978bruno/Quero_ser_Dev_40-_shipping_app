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
          if @order.collect_zip.to_s.length == 8
            api_collect = JSON.parse(Faraday.get("https://viacep.com.br/ws/#{@order.collect_zip}/json/").body)
            if api_collect['erro'] != true
              @order.collect_street = api_collect['logradouro']
              @order.collect_nhood = api_collect['bairro']
              @order.collect_city = api_collect['localidade']
              @order.collect_state = api_collect['uf']
            else
              flash.now[:alert] = 'CEP do remetente inexistente'
            end
          else
            flash.now[:alert] = 'CEP do remetente inexistente'
          end
        end
        if @order.deliv_zip.present?
          if @order.deliv_zip.to_s.length == 8
            api_deliv = JSON.parse(Faraday.get("https://viacep.com.br/ws/#{@order.deliv_zip}/json/").body)
            if api_deliv['erro'] != true
              @order.deliv_street = api_deliv['logradouro']
              @order.deliv_nhood = api_deliv['bairro']
              @order.deliv_city = api_deliv['localidade']
              @order.deliv_state = api_deliv['uf']
            else
              flash.now[:alert] = 'CEP do destinatário inexistente'
            end
          else
            flash.now[:alert] = 'CEP do destinatário inexistente'
          end
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
  end
  def index
    if current_user.nil?
      @order = ""
    else
      user = User.where('email = ?', current_user.email)
      @order = Order.where('status = ? and user_id = ?', 0, user[0]["id"])
    end
  end
  def edit
    @order = Order.find(params[:id])
  end
  def update
    order_params = params.require(:order).permit(:collect_street, :collect_number, :collect_nhood, :collect_city, :collect_state, :width, 
                                                :height, :depth, :weight, :deliv_reipient, :deliv_street, :deliv_number, :deliv_nhood, 
                                                :deliv_city, :deliv_state, :km_dist, :deliv_zip, :collect_zip)
    @order = Order.update(params[:id], order_params)
    if order_params.empty?
      redirect_to order_path(@order), notice: 'Não foi possível atualizar os dados do veículo.'
    else
      redirect_to order_path(@order), notice: 'Dados do veículo atualizados com sucesso'
    end
  end
  def select_modal(shipping, order, vehicle, total_cost)
    @process_oreder = ProcessOrder.create!(shipping, order, vehicle, total_cost)
    
    redirect_to banana_path
  end
end
