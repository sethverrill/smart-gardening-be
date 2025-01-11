class Api::V1::GardensController < ApplicationController

  def show
    garden = Garden.find(params[:id])
    render json: garden 
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Garden not found" }, status: :not_found
  end

end
