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
end