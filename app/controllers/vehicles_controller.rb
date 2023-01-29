class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all
    @vehicle_categories = VehicleCategory.all
    @vehicle_types = VehicleType.all
  end
  def create
    vehicle_params = params.require(:vehicle).permit(:license_plate, :manufature_year, :maximum_load_capacity, :vehicle_categories_id, :vehicle_types_id)
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      redirect_to vehicles_path, notice: 'Veículo cadastrado com sucesso'
    else
      @vehicle_categories = VehicleCategory.all
      @vehicle_types = VehicleType.all
      flash.now[:alert] = 'Veículo não cadastrado'
      render :new
    end
  end
  def new
    @vehicle = Vehicle.new
    @vehicle_categories = VehicleCategory.all
    @vehicle_types = VehicleType.all
  end
end