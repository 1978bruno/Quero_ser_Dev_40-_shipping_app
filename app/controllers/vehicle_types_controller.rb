class VehicleTypesController < ApplicationController
  def new
    @vehicle_type = VehicleType.new
  end

  def create
    vehicle_type_params = params.require(:vehicle_type).permit(:manufacturer_vehicle, :model_vehicle)
    @vehicle_type = VehicleType.new(vehicle_type_params)
    if @vehicle_type.save
      redirect_to vehicles_path,
                  notice: "O veículo modelo: #{@vehicle_type.model_vehicle} - #{@vehicle_type.manufacturer_vehicle} foi cadastrado com sucesso"
    else
      flash.now[:alert] = 'Modelo do veículo não cadastrado'
      render :new
    end
  end
end
