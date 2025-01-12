require 'rails_helper'

RSpec.describe 'Recommendation API', type: :request do
  describe 'get recommendations' do
    before do
      WebMock.stub_request(:post, "https://api.openai.com/v1/chat/completions")
            .to_return(
              status: 200,
              body: {
                id: "mock-chatcmpl-123",
                object: "chat.completion",
                choices: [
                  {
                    message: {
                      content: [
                        {
                          name: "Strawberry",
                          description: "Thrives in loamy soil and full sun, ideal for food production.",
                          image: "https://example.com/mock-strawberry.jpg"
                        },
                        {
                          name: "Basil",
                          description: "Aromatic herb thriving in full sun with moderate watering.",
                          image: "https://example.com/mock-basil.jpg"
                        }
                      ].to_json
                    }
                  }
                ]
              }.to_json,
              headers: { 'Content-Type' => 'application/json' }
            )
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

      binding.pry
    end
  end
end