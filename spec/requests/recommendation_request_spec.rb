require 'rails_helper'

RSpec.describe 'Recommendation Endpoints' do
  describe 'get recommendations' do
    it 'can get a recommendation based on a valid request' do
      get "/api/v1/recommendations", params: {zip: 80221, sunlight: full_sun, soil_type: clay, water_needs: low_water, purpose: edible}, as: :json
      
      expect(true).to eq(false)
    end
  end
end