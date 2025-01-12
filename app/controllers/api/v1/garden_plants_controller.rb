class Api::V1::GardenPlantsController < ApplicationController

    def update
        garden = Garden.find(params[:garden_id])
      
        plant = find_or_create_plant(params)

        unless check_garden_plant(garden,plant)
            GardenPlant.create!(garden: garden, plant: plant)
        end

        render json: GardenPlantSerializer.format(garden), status: 200
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
