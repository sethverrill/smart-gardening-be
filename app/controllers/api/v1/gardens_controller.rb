class Api::V1::GardensController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  def index
    gardens = Garden.all
    render json: gardens, status: :ok
  end

  def show
    garden = Garden.find(params[:id])
    render json: garden 
  end
  
  def create
    if Garden.exists?
      render json: ErrorSerializer.format_errors("Only one garden allowed at this time"), status: :unprocessable_entity
      return
    end

    garden = Garden.new(garden_params)

    if garden.save
      render json: { data: { id: garden.id } }, status: :created
    else
      render json: ErrorSerializer.format_errors(garden.errors.full_messages), status: :unprocessable_entity
    end    
  end

  def update
    garden = Garden.find_by(id: params[:id])

    if garden.nil?
      render json: ErrorSerializer.format_errors(["Garden not found"]), status: :not_found
      return
    end

    if garden.update(garden_params)
      render json: { data: garden }, status: :ok
    else
      render json: ErrorSerializer.format_errors(garden.errors.full_messages), status: :unprocessable_entity
    end
  end

  private
    def garden_params
      params.require(:garden).permit(:name, :zip_code, :hardiness_zone, :sunlight, :soil_type, :water_needs, :purpose)
    end
end
