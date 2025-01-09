require 'rails_helper'

RSpec.describe 'Recommendation API', type: :request do
  describe 'get recommendations' do
    it 'can get a recommendation based on a valid request' do
      get "/api/v1/recommendation", params: {zip: 80221, sunlight: "full_sun", soil_type: "clay", water_needs: "low_water", purpose: "edible"}, as: :json

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data].length).to eq(2)
      expect(json[:data][0][:id]).to eq(1)
      expect(json[:data][0][:type]).to eq("plant")
      expect(json[:data][0][:attributes][:name]).to eq("strawberry")
      expect(json[:data][0][:attributes][:short_description]).to eq("red")
      expect(json[:data][0][:attributes][:img_url]).to eq("https://foodal.com/wp-content/uploads/2015/03/Make-Strawberry-Season-Last-All-Year.jpg")
    end
  end
end