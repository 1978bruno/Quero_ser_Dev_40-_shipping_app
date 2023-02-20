class ShippingsController < ApplicationController
  def show
    @shipping = Shipping.find(params[:id])
    @cost = Cost.find_by(shipping: params[:id])
    @deliv_term = DelivTerm.find_by(shipping: params[:id])
  end

  def new
    @shipping = Shipping.new
  end

  def create
    shipping_params = params.require(:shipping).permit(:name, :min_dist, :max_dist,
                                                       :min_weight, :max_weight,
                                                       :deliv_fee, :statuses)
    s = Shipping.new(shipping_params)
    s.save
    redirect_to root_path
  end

  def search
    @name = params['query']
    @shippings = Shipping.where('name LIKE ?', "%#{@name}%")
  end
  def edit
    @shipping = Shipping.find(params[:id])
  end
  def update
    shipping_params = params.require(:shipping).permit(:name, :min_dist, :max_dist,
                                                      :min_weight, :max_weight,
                                                      :deliv_fee, :statuses)
    Shipping.update(shipping_params)
    redirect_to shipping_path(shipping_params)
  end
end
