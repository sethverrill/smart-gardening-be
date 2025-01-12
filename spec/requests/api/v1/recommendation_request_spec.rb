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
  end
end