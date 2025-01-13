require 'rails_helper'

RSpec.describe 'Gardens API', type: :request do
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



  end
end