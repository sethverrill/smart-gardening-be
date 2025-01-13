class Api::V1::GardensController < ApplicationController
 
  def show
    garden = Garden.find(params[:id])
    render json: garden 
  end
  
  def create
    garden = Garden.new(garden_params)
    render json: { data: { id: garden.id } }, status: :created    
  end

  private
    def garden_params
      params.require(:garden).permit(:name, :zip_code, :hardiness_zone, :sunlight, :soil_type, :water_needs, :purpose)
  end
end