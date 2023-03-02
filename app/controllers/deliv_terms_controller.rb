class DelivTermsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def new
    @shipping = Shipping.all
    @deliv_term = DelivTerm.new
  end

  def create
    @deliv_term = DelivTerm.new(params.require(:deliv_term).permit(:term_int_min_weight, :term_int_max_weight,
                                                                   :deliv_term, :shipping_id))
    deliv_term_capture and return if @deliv_term.save

    @shipping = Shipping.all
    flash.now[:alert] = "#{I18n.t(:register_unsuccessfuly)} Não podem existir campos em branco."
    render :new
  end

  def deliv_term_capture
    @shipping = Shipping.find(@deliv_term.shipping_id)
    @cost = Cost.where(shipping: @shipping)
    @deliv_term = DelivTerm.where(shipping: @shipping)
    redirect_to shipping_path(@shipping.id), notice: I18n.t(:register_sucessfuly)
  end
end
