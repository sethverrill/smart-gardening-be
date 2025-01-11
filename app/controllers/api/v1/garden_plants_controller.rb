class Api::V1::GardenPlantsController < ApplicationController

    def update
        #add plant to a garden
        #get the garden id
        binding.pry
        garden = Garden.find(params[:garden_id])
        #inding.pry
        #GardenPlant.create!(garden: garden, plant: plant)
        render json: garden
    end
end