class ShippingsController < ApplicationController
  def show
    id = params[:id]
    @shipping = Shipping.find(id)
  end
  def new
  end
  def create
    shipping_params = params.require(:shipping).permit(:name, :min_dist, :max_dist,
                                                      :min_weight, :max_weight, 
                                                      :deliv_fee, :status)
    s = Shipping.new(shipping_params)
    s.save()
    redirect_to root_path
  end

end