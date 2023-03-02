class VehicleCategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  def new
    @vehicle_category = VehicleCategory.new
  end

  def create
    vehicle_category_params = params.require(:vehicle_category).permit(:category)
    @vehicle_category = VehicleCategory.new(vehicle_category_params)
    if @vehicle_category.save
      redirect_to vehicles_path,
                  notice: "A categoria de veículo #{@vehicle_category.category} foi cadastrado com sucesso"
    else
      flash.now[:alert] = 'Categoria do veículo não cadastrado'
      render :new
    end
  end
end
