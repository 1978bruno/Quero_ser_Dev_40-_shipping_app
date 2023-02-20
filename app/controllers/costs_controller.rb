class CostsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  def new
    @shipping = Shipping.all
    @cost = Cost.new
  end

  def create
    cost_params = params.require(:cost).permit(:int_min_weight, :int_max_weight, :km_value, :shipping_id)
    @cost = Cost.new(cost_params)
    @shipping = Shipping.find(cost_params[:shipping_id])
    if @cost.save
      flash.now[:notice] = 'Cadastro realizado com sucesso'
      @deliv_term = DelivTerm.find_by(shipping_id: cost_params[:shipping_id])
      render 'shippings/show'
    else
      @shipping = Shipping.all
      flash.now[:alert] = 'Cadastro não realizado'
      flash.now[:notice] = 'Não podem existir campos em branco'
      render :new
    end
  end
end
