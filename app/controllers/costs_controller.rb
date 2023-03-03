class CostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit]
  def new
    @shipping = Shipping.where(status: 'activated')
    @cost = Cost.new
  end

  def edit
    @cost = Cost.find(params[:id])
    @shipping = Shipping.where(id: @cost.shipping_id)
  end

  def create
    @cost = Cost.new(params.require(:cost).permit(:int_min_weight, :int_max_weight, :km_value, :shipping_id))
    @shipping = Shipping.find(@cost.shipping_id)
    cost_capture and return if @cost.save

    @shipping = Shipping.all
    flash.now[:alert] = 'Cadastro não realizado. Não podem existir campos em branco.'
    render :new
  end

  def update
    @cost = Cost.update(params[:id], params.require(:cost).permit(:int_min_weight, :int_max_weight,
                                                                  :km_value, :shipping_id))
    cost_capture and return if @cost.valid?

    @shipping = Shipping.where(status: 'activated')
    flash.now[:alert] = "#{I18n.t(:register_unsuccessfuly)} Não podem existir campos em branco."
    render :edit
  end

  def cost_capture
    @shipping = Shipping.find(@cost.shipping_id)
    @deliv_term = DelivTerm.where(shipping: @cost.shipping_id)
    @cost = Cost.where(shipping: @cost.shipping_id)
    redirect_to shipping_path(@shipping.id), notice: I18n.t(:register_sucessfuly)
  end
end
