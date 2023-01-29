class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all
    @vehicle_categories = VehicleCategory.all
    @vehicle_types = VehicleType.all
  end
  def create
    vehicle_params = params.require(:vehicle).permit(:vehicle_categories_id, :vehicle_types_id)
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.save
    @vehicle_categories = VehicleCategory.all
    @vehicle_types = VehicleType.all
  end
  def new
    @vehicle = Vehicle.new
    @vehicle_categories = VehicleCategory.all
    @vehicle_types = VehicleType.all
  end
end