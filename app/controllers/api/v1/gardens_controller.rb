class Api::V1::GardensController < ApplicationController

  def show
    garden = Garden.find(params[:id])
    render json: garden 
  end
  
  def create
    garden = Garden.new(garden_params)

    if garden.save
      render json: { data: { id: garden.id } }, status: :created
    else
      render json: { errors: garden.errors.full_messages }, status: :unprocessable_entity
    end    
  end

  private
    def garden_params
      params.require(:garden).permit(:name, :zip_code, :hardiness_zone, :sunlight, :soil_type, :water_needs, :purpose)
    end
end