require 'rails_helper'
require_relative '../../app/gateways/openai_gateway'

RSpec.describe OpenaiGateway do
  describe "generate_recommendations" do
    let(:valid_params) do
      {
        zip_code: "80221",
        sunlight: "Full Sun",
        soil_type: "Loamy",
        water_needs: "Moderate",
        purpose: "Food Production"
      }
    end

    it "returns recommendations when OpenAI API responds successfully" do
      VCR.use_cassette("openai_gateway_success") do
        stubbed_response = File.read("spec/fixtures/openai_gateway_stubbed.json")

        stub_request(:post, "https://api.openai.com/v1/chat/completions")
          .with(
            headers: {
              "Content-Type" => "application/json",
              "Authorization" => "Bearer #{Rails.application.credentials.dig(:open_ai, :key)}"
            }
          )
          .to_return(status: 200, body: stubbed_response)

        gateway = OpenaiGateway.new
        result = gateway.generate_recommendations(valid_params)

        expect(result[:success]).to be true
        expect(result[:id]).to eq("mock-chatcmpl-123")
        expect(result[:data]).to be_an Array
        expect(result[:data].length).to eq(2)

        first_recommendation = result[:data][0]
        expect(first_recommendation["name"]).to eq("Tomato")
        expect(first_recommendation["description"]).to eq("Thrives in full sun.")
        expect(first_recommendation["image"]).to eq("https://example.com/tomato.jpg")
      end
    end

    it "handles API errors gracefully" do
      stub_request(:post, "https://api.openai.com/v1/chat/completions")
        .to_return(status: 500, body: "")

      gateway = OpenaiGateway.new
      result = gateway.generate_recommendations(valid_params)

      expect(result[:success]).to be false
      expect(result[:error]).to eq("Failed to fetch plant recommendations.")
    end

    it "handles unexpected response format" do
      stubbed_response = { id: "mock-chatcmpl-123", choices: [] }.to_json

      stub_request(:post, "https://api.openai.com/v1/chat/completions")
        .to_return(status: 200, body: stubbed_response)

      gateway = OpenaiGateway.new
      result = gateway.generate_recommendations(valid_params)

      expect(result[:success]).to be false
      expect(result[:error]).to eq("Unexpected response format from OpenAI.")
    end

    it "handles exceptions gracefully" do
      allow(Faraday).to receive(:post).and_raise(StandardError.new("Connection error"))

      gateway = OpenaiGateway.new
      result = gateway.generate_recommendations(valid_params)

      expect(result[:success]).to be false
      expect(result[:error]).to eq("An error occurred: Connection error")
    end
  end
end
