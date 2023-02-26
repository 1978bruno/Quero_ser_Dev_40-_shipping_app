class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all
    @vehicle_categories = VehicleCategory.all
    @vehicle_types = VehicleType.all
  end

  def create
    vehicle_params = params.require(:vehicle).permit(:license_plate, :manufature_year, :maximum_load_capacity,
                                                     :vehicle_category_id, :vehicle_type_id, :status)
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

  def edit
    @vehicle_categories = VehicleCategory.all
    @vehicle_types = VehicleType.all
    @vehicle = Vehicle.find(params[:id])
  end

  def update
    vehicle_params = params.require(:vehicle).permit(:license_plate, :manufature_year, :maximum_load_capacity,
                                                     :vehicle_category_id, :vehicle_type_id)
    
    Vehicle.update(params[:id], vehicle_params)
    if vehicle_params['license_plate'].empty? || vehicle_params['manufature_year'].empty? || vehicle_params['maximum_load_capacity'].empty?
      redirect_to vehicles_path, notice: 'Não foi possível atualizar os dados do veículo.'
    else
      redirect_to vehicles_path, notice: 'Dados do veículo atualizados com sucesso'
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
