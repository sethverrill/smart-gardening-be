require 'rails_helper'

RSpec.describe "Api::V1::GardenPlants", type: :request do
    before :each do
        @garden1 = Garden.create!(
            name: "Vegetable Garden",
            zip_code: "80209",
            sunlight: "Full Sun",
            soil_type: "Loamy",
            water_needs: "High",
            purpose: "Food Production"
        )

        @garden2 = Garden.create!(
            name: "Flower Garden",
            zip_code: "80422",
            sunlight: "Partial Shade",
            soil_type: "Peaty",
            water_needs: "Low",
            purpose: "Aesthetic"
        )
        @tulip = Plant.create!(
            name: "Tulip",
            img_url: "https://upload.wikimedia.org/wikipedia/commons/4/4c/Tulip_-_floriade_canberra.jpg",
            description: "A colorful spring-blooming flower."
        )
        
        @moss = Plant.create!(
            name: "Moss",
            img_url: "https://upload.wikimedia.org/wikipedia/commons/4/4b/Moss_on_tree_trunk.jpg",
            description: "A low-maintenance ground cover that thrives in shaded areas."
        )
        GardenPlant.create!(garden: @garden1, plant: @tulip)
        GardenPlant.create!(garden: @garden1, plant: @moss)
    end

    describe "POST /api/v1/:garden_id" do
        it "can add a plant that already exists" do
            plant_params= {
                name: "Moss",
                img_url: "https://upload.wikimedia.org/wikipedia/commons/4/4b/Moss_on_tree_trunk.jpg",
                description: "A low-maintenance ground cover that thrives in shaded areas."
            }
            patch "/api/v1/#{@garden2.id}", params: plant_params

            expect(response).to be_successful
            json = JSON.parse(response.body, symbolize_names: true)

            expect(json[:data][0][:id]). to eq(@moss.id)
            expect(json[:data][0][:type]). to eq("plant")
            expect(json[:data][0][:attributes][:name]). to eq("Moss")
            expect(json[:data][0][:attributes][:img_url]). to eq(@moss.img_url)
            expect(json[:data][0][:attributes][:description]). to eq(@moss.description)
        end
        it "can add a new plant" do
            plant_params = {
                name: "Carrot",
                img_url: "https://upload.wikimedia.org/wikipedia/commons/4/4b/Carrot.jpg",
                description: "A root vegetable that grows well in loamy soil."
            }
            patch "/api/v1/#{@garden1.id}", params: plant_params

            expect(response).to be_successful
            json = JSON.parse(response.body, symbolize_names: true)

            expect(json[:data].length).to eq(3)
            expect(json[:data][2][:type]). to eq("plant")
            expect(json[:data][2][:attributes][:name]). to eq(plant_params[:name])
            expect(json[:data][2][:attributes][:img_url]). to eq(plant_params[:img_url])
            expect(json[:data][2][:attributes][:description]). to eq(plant_params[:description])
        end

        it "won't add duplicates if the plant is already part of the garden" do
            plant_params= {
                name: "Moss",
                img_url: "https://upload.wikimedia.org/wikipedia/commons/4/4b/Moss_on_tree_trunk.jpg",
                description: "A low-maintenance ground cover that thrives in shaded areas."
            }
            patch "/api/v1/#{@garden1.id}", params: plant_params

            expect(response).to be_successful
            json = JSON.parse(response.body, symbolize_names: true)

            expect(json[:data].length).to eq(2)
        end

        it "returns a 422 error if plant information is missing" do
            plant_params= {
                name: "Clover",
                description: "A hardy ground cover plant that prevents soil erosion."
            }
            patch "/api/v1/#{@garden1.id}", params: plant_params

            json_response = JSON.parse(response.body, symbolize_names: true)
                expect(json_response[:errors]).to eq(["Validation failed: Img url can't be blank"])
        end

        it "disregards additional fields" do
            plant_params = {
                name: "Carrot",
                img_url: "https://upload.wikimedia.org/wikipedia/commons/4/4b/Carrot.jpg",
                description: "A root vegetable that grows well in loamy soil.",
                extra: "Here is extra information"
            }
            patch "/api/v1/#{@garden1.id}", params: plant_params

            expect(response).to be_successful
            json = JSON.parse(response.body, symbolize_names: true)

            expect(json[:data].length).to eq(3)
            expect(json[:data][2][:type]). to eq("plant")
            expect(json[:data][2][:attributes][:name]). to eq(plant_params[:name])
            expect(json[:data][2][:attributes][:img_url]). to eq(plant_params[:img_url])
            expect(json[:data][2][:attributes][:description]). to eq(plant_params[:description])
            expect(json[:data][2][:attributes][:extra]). to eq(nil)
        end

        it "returns a 404 if the garden is not found" do
            patch "/api/v1/9999999"

            expect(response).to have_http_status(:not_found)

            json = JSON.parse(response.body, symbolize_names: true)
            expect(json[:error]).to eq("Garden not found")
        end
    end

    describe "DELETE /api/v1/:garden_id/:plant_id" do
        it "can delete a garden plant" do
            garden_plant = GardenPlant.find_by(garden: @garden1, plant: @tulip)
            expect(garden_plant).to be_present
          
            delete "/api/v1/gardens/#{@garden1.id}/plants/#{@tulip.id}"            
            expect(response).to have_http_status(:ok)
            json = JSON.parse(response.body, symbolize_names: true)
            expect(json[:message]).to eq('Garden plant removed successfully')
          
            expect(GardenPlant.exists?(garden_plant.id)).to be_falsey
        end

        it "returns a 404 if the garden is not found" do
            delete "/api/v1/gardens/9999999/plants/#{@tulip.id}"
        
            expect(response).to have_http_status(:not_found)
        
            json = JSON.parse(response.body, symbolize_names: true)
            expect(json[:error]).to eq("Garden not found")
          end
        
          it "returns a 404 if the garden plant is not found" do
            delete "/api/v1/gardens/#{@garden1.id}/plants/9999999"
        
            expect(response).to have_http_status(:not_found)
        
            json = JSON.parse(response.body, symbolize_names: true)
            expect(json[:error]).to eq("Garden plant not found")
          end
    end
      
end