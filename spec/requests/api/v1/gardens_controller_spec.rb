require 'rails_helper'

RSpec.describe "Api::V1::Gardens", type: :request do
  describe "GET /api/v1/gardens/:id" do
    let!(:garden) { create(:garden) }

    it "returns a garden" do
      get "/api/v1/gardens/#{garden.id}"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:id]).to eq(garden.id)
      expect(json[:name]).to eq(garden.name)
      expect(json[:zip_code]).to eq(garden.zip_code)
      expect(json[:sunlight]).to eq(garden.sunlight)
      expect(json[:soil_type]).to eq(garden.soil_type)
      expect(json[:water_needs]).to eq(garden.water_needs)
      expect(json[:purpose]).to eq(garden.purpose)
    end
  end

  it "returns a 404 if the garden is not found" do
    get "/api/v1/gardens/999"

    expect(response).to have_http_status(:not_found)

    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:error]).to eq("Garden not found")
  end

  describe 'POST /api/v1/gardens' do
    let(:garden_attributes) do
      {
        garden: {
          name: 'Herb Garden',
          zip_code: '12345',
          sunlight: 'Full Sun',
          soil_type: 'Loamy',
          water_needs: 'Moderate',
          purpose: 'Food Production'
        }
      }
    end

    it 'can create a garden' do
      post '/api/v1/gardens', params: garden_attributes

      expect(response).to have_http_status(:created)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to have_key('data')
      expect(parsed_response['data']).to have_key('id')

      garden= Garden.last
      expect(garden.name).to eq('Herb Garden')
      expect(garden.zip_code).to eq('12345')
      expect(garden.sunlight).to eq('Full Sun')
    end

    it 'returns validation errors' do
      invalid_attributes = { garden: { name: '', zip_code: '' } }

      post '/api/v1/gardens', params: invalid_attributes

      expect(response).to have_http_status(:unprocessable_entity)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to have_key('errors')
      expect(parsed_response['errors']).to include("Name can't be blank", "Zip code can't be blank")
    end
  end
end