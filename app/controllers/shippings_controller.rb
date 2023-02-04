class ShippingsController < ApplicationController
  def show
    id = params[:id]
    @shipping = Shipping.find(id)
    @cost = Cost.find(id)
  end
  def new
    @shipping = Shipping.new()
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
    @name = params["query"]
    @shippings = Shipping.where("name LIKE ?", "%#{@name}%")
  end

end