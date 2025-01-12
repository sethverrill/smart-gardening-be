class Api::V1::GardenPlantsController < ApplicationController

    def update
        garden = Garden.find(params[:garden_id])
      
        plant = find_or_create_plant(params)
        # if !check_plant(params)
        #     plant = Plant.create!(
        #         name: params[:name],
        #         img_url: params[:img_url],
        #         description: params[:description]
        #     )
        # else
        #     plant = Plant.find_by(name: params[:name])
        # end

        unless check_garden_plant(garden,plant)
            GardenPlant.create!(garden: garden, plant: plant)
        end

        render json: GardenPlantSerializer.format(garden), status: 200
    end

    private
    def plant_params
        params.permit(:name, :img_url,:description)
    end

    # def check_plant(params)
    #     plant = Plant.find_by(name: params[:name])
    # end

    def check_garden_plant(garden, plant)
        GardenPlant.exists?(garden: garden, plant:plant)
    end

    def find_or_create_plant(params)
        if Plant.find_by(name: params[:name])
            plant = Plant.find_by(name: params[:name])
        else
            plant = Plant.create!(
                        name: params[:name],
                        img_url: params[:img_url],
                        description: params[:description])
        end
    end
end
