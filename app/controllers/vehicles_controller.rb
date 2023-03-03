class VehiclesController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit index]
  def index
    @vehicles = Vehicle.all
    @vehicle_categories = VehicleCategory.all
    @vehicle_types = VehicleType.all
  end

  def new
    @vehicle = Vehicle.new
    @vehicle_categories = VehicleCategory.all
    @vehicle_types = VehicleType.all
  end

  def edit
    @vehicle_categories = VehicleCategory.all
    @vehicle_types = VehicleType.all
    @vehicle = Vehicle.find(params[:id])
  end

  def create
    vehicle_params = params.require(:vehicle).permit(:license_plate, :manufature_year, :maximum_load_capacity,
                                                     :vehicle_category_id, :vehicle_type_id)
    @vehicle = Vehicle.new(vehicle_params)
    return redirect_to vehicles_path, notice: I18n.t(:vehicle_register_successfuly) if @vehicle.save

    @vehicle_categories = VehicleCategory.all
    @vehicle_types = VehicleType.all
    flash.now[:alert] = I18n.t(:vehicle_register_unsuccessfuly)
    render :new
  end

  def update
    vehicle_params = params.require(:vehicle).permit(:license_plate, :manufature_year, :maximum_load_capacity,
                                                     :vehicle_category_id, :vehicle_type_id)
    if Vehicle.update(params[:id], vehicle_params).valid?
      redirect_to vehicles_path, notice: I18n.t(:vehicle_update_successfuly)
    else
      redirect_to vehicles_path, notice: I18n.t(:vehicle_update_unsuccessfuly)
    end
  end

  def active
    Vehicle.update(params[:id], status: 1)
    redirect_to vehicles_path
  end

  def disable
    Vehicle.update(params[:id], status: 0)
    redirect_to vehicles_path
  end
end
