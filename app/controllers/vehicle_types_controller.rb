class VehicleTypesController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  def new
    @vehicle_type = VehicleType.new
  end

  def create
    vehicle_type_params = params.require(:vehicle_type).permit(:manufacturer_vehicle, :model_vehicle)
    @vehicle_type = VehicleType.new(vehicle_type_params)
    if @vehicle_type.save
      text_params = "#{@vehicle_type.model_vehicle} - #{@vehicle_type.manufacturer_vehicle}"
      redirect_to vehicles_path, notice: "O veículo modelo: #{text_params} foi cadastrado com sucesso"
    else
      flash.now[:alert] = 'Modelo do veículo não cadastrado'
      render :new
    end
  end
end
