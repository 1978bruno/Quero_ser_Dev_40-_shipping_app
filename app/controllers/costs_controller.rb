class CostsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  def new
    @shipping = Shipping.all
    @cost = Cost.new
  end

  def create
    @cost = Cost.new(params.require(:cost).permit(:int_min_weight, :int_max_weight, :km_value, :shipping_id))
    @shipping = Shipping.find(@cost.shipping_id)
    cost_capture and return if @cost.save

    @shipping = Shipping.all
    flash.now[:alert] = 'Cadastro não realizado. Não podem existir campos em branco.'
    render :new
  end

  def cost_capture
    @deliv_term = DelivTerm.where(shipping: @cost.shipping_id)
    @cost = Cost.where(shipping: @cost.shipping_id)
    redirect_to shipping_path(@shipping.id), notice: I18n.t(:register_sucessfuly)
  end
end
