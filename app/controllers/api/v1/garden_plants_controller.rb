class Api::V1::GardenPlantsController < ApplicationController

    def update
        #add plant to a garden
        #get the garden id
        garden = Garden.find(params[:garden_id])
        #check to create the plant if it's not already made
      
        if !check_plant(params)
            plant = Plant.create!(
                name: params[:name],
                img_url: params[:img_url],
                description: params[:description]
            )
        else
            plant = Plant.find_by(name: params[:name])
        end

        GardenPlant.create!(garden: garden, plant: plant)

        #binding.pry
        render json: garden
    end

    private
    def plant_params
        params.permit(:name, :img_url,:description)
    end

    def check_plant(params)
        plant = Plant.find_by(name: params[:name])
    end

    def check_garden_plant(params)
        gardenPlant
    end
end


# tomato = Plant.create!(
#   name: "Tomato",
#   img_url: "https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg",
#   description: "A popular vegetable that thrives in full sun."
# )