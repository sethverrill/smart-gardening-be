class Api::V1::GardenPlantsController < ApplicationController
  #added the 2 below to all for POST calls
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token

    def update
        garden = Garden.find(params[:garden_id])
      
        plant = find_or_create_plant(params)

        unless check_garden_plant(garden,plant)
            GardenPlant.create!(garden: garden, plant: plant)
        end

        render json: GardenPlantSerializer.format(garden), status: 200
    end

    def destroy
        garden_plant = GardenPlant.find_by(garden_id: params[:garden_id], plant_id: params[:plant_id])
      
        if garden_plant
          garden_plant.destroy
          render json: { message: 'Garden plant removed successfully' }, status: :ok
        else
          render json: { error: 'Garden plant not found' }, status: :not_found
        end
    end

    private
    def plant_params
        params.permit(:name, :img_url,:description)
    end

    def find_or_create_plant(params)
        plant = Plant.find_by(name: params[:name])
        return plant if plant
      
        Plant.create!(
          name: params[:name],
          img_url: params[:img_url],
          description: params[:description]
        )
    end

    def check_garden_plant(garden, plant)
        GardenPlant.exists?(garden: garden, plant:plant)
    end
end
