class HomeController < ApplicationController
  def index
    @shippings = Shipping.all
  end

end