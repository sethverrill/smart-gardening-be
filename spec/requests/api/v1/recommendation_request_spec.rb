require 'rails_helper'
RSpec.describe 'Recommendation API', type: :request do
  describe 'get recommendations' do
    context 'happy path' do
      it 'returns recommendations based on valid parameters' do
        VCR.use_cassette("openai_recommendation") do
          get "/api/v1/recommendation",
              params: {
                zip_code: 80221,
                sunlight: "full_sun",
                soil_type: "clay",
                water_needs: "low_water",
                purpose: "edible"
              },
              as: :json
        end
        Rails.logger.info("Response Body: #{response.body}")
        expect(response).to be_successful
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:id]).to eq("chatcmpl-AqT9Hr24KfUfj8tdnIJlxGoL7peuP")
        expect(json[:data].length).to eq(3)
        expect(json[:data][0][:index]).to eq(1)
        expect(json[:data][0][:attributes][:name]).to eq("Asparagus")
        expect(json[:data][0][:attributes][:description]).to eq("Asparagus thrives in well-drained clay soil and requires minimal watering once established")
        expect(json[:data][0][:attributes][:image]).to eq("https://upload.wikimedia.org/wikipedia/commons/0/05/Asparagus_officinalis_-_Asparagus.jpg")
        expect(json[:data][1][:index]).to eq(2)
        expect(json[:data][1][:attributes][:name]).to eq("Rhubarb")
        expect(json[:data][1][:attributes][:description]).to eq("Rhubarb is a hardy perennial that can tolerate clay soil and requires little water after establishment")
        expect(json[:data][1][:attributes][:image]).to eq("https://upload.wikimedia.org/wikipedia/commons/8/8c/Rhubarb_Rheum_rhabarbarum.jpg")
        expect(json[:data][2][:index]).to eq(3)
        expect(json[:data][2][:attributes][:name]).to eq("Thyme")
        expect(json[:data][2][:attributes][:description]).to eq("Thyme is a drought-tolerant herb that grows well in clay soil and enjoys full sun.")
        expect(json[:data][2][:attributes][:image]).to eq("https://upload.wikimedia.org/wikipedia/commons/4/4f/Chives_%28Allium_schoenoprasum%29.jpg")
      end
    end
    context 'sad path' do
      it 'returns a 400 error if zip code is missing' do
        get "/api/v1/recommendation",
            params: { sunlight: "full_sun", soil_type: "clay", water_needs: "low_water", purpose: "edible" },
            as: :json
        expect(response).to have_http_status(400)
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:error]).to eq("Zip code is required.")
      end
    end
    context 'server error' do
      before do
        allow_any_instance_of(OpenaiGateway).to receive(:generate_recommendations).and_return({
          success: false,
          error: 'Something went wrong'
        })
        end
      it 'returns a 500 error' do
        get "/api/v1/recommendation",
            params: {
              zip_code: 80221,
              sunlight: "full_sun",
              soil_type: "clay",
              water_needs: "low_water",
              purpose: "edible"
            },
            as: :json
          expect(response).to have_http_status(:internal_server_error)
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json[:error]).to include('Something went wrong')
      end
    end
  end
end