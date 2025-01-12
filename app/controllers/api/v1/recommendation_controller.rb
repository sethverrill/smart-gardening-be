class Api::V1::RecommendationController < ApplicationController

  def index
    if Rails.env.test? || Rails.env.development?
      # Checks if it is in testing or dev environments so it can mock response (will remove line 5 later)
      mock_response_id = "mock-chatcmpl-123"
      stub_json = [
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
      ]
      render json: RecommendationSerializer.format_recommendations(stub_json, mock_response_id), status: 200
      return
    end
  end
end