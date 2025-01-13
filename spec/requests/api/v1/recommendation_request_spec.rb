require 'rails_helper'

RSpec.describe 'Recommendation API', type: :request do
  describe 'get recommendations' do
    before do
      WebMock.stub_request(:post, "https://api.openai.com/v1/chat/completions")
            .to_return(status: 200, body: File.read("spec/fixtures/recommendation_stubbed_response.json"))
    end

    it 'returns recommendations based on valid parameters' do
      get "/api/v1/recommendation", 
          params: { 
            zip: 80221, 
            sunlight: "full_sun", 
            soil_type: "clay", 
            water_needs: "low_water", 
            purpose: "edible" 
          }, 
          as: :json
      
      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:id]).to eq("mock-chatcmpl-123")

      expect(json[:data].length).to eq(2)

      expect(json[:data][0][:index]).to eq(1)
      expect(json[:data][0][:attributes][:name]).to eq("Strawberry")
      expect(json[:data][0][:attributes][:description]).to eq("Thrives in loamy soil and full sun, ideal for food production.")
      expect(json[:data][0][:attributes][:image]).to eq("https://example.com/mock-strawberry.jpg")

      expect(json[:data][1][:index]).to eq(2)
      expect(json[:data][1][:attributes][:name]).to eq("Basil")
      expect(json[:data][1][:attributes][:description]).to eq("Aromatic herb thriving in full sun with moderate watering.")
      expect(json[:data][1][:attributes][:image]).to eq("https://example.com/mock-basil.jpg")
    end
  end
end