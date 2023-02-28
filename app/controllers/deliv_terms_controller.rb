class DelivTermsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  def new
    @shipping = Shipping.all
    @deliv_term = DelivTerm.new
  end
  def create
    @deliv_term = DelivTerm.new(params.require(:deliv_term).permit(:term_int_min_weight, :term_int_max_weight, :deliv_term,
                                :shipping_id))
    @shipping = Shipping.find(@deliv_term.shipping_id)
    if @deliv_term.save
      flash.now[:notice] = 'Cadastro realizado com sucesso'
      @cost = Cost.where(shipping: @shipping)
      @deliv_term = DelivTerm.where(shipping: @shipping)
      render 'shippings/show'
    else
      @shipping = Shipping.all
      flash.now[:alert] = 'Cadastro não realizado'
      flash.now[:notice] = 'Não podem existir campos em branco'
      render :new
    end
  end
end
