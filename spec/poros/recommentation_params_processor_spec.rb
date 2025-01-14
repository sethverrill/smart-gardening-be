require 'rails_helper'

RSpec.describe RecommendationParamsProcessor do
  describe '#process' do
    let(:valid_params) do
      {
        zip: "80221",
        sunlight: "Partial Shade",
        soil_type: "Clay",
        water_needs: "High",
        purpose: "Food Production"
      }
    end

    let(:params_with_defaults) do
      {
        zip: "80221",
        sunlight: "Don't Know",
        soil_type: "Don't Know",
        water_needs: "Don't Know",
        purpose: "Food Production"
      }
    end

    it 'returns processed parameters with valid input' do
      processor = RecommendationParamsProcessor.new(valid_params)
      result = processor.process

      expect(result[:zip]).to eq("80221")
      expect(result[:sunlight]).to eq("Partial Shade")
      expect(result[:soil_type]).to eq("Clay")
      expect(result[:water_needs]).to eq("High")
      expect(result[:purpose]).to eq("Food Production")
    end

    it 'uses defaults for "Do not Know" values' do
      processor = RecommendationParamsProcessor.new(params_with_defaults)
      result = processor.process

      expect(result[:zip]).to eq("80221")
      expect(result[:sunlight]).to eq("Full Sun")
      expect(result[:soil_type]).to eq("Loamy")
      expect(result[:water_needs]).to eq("Moderate")
      expect(result[:purpose]).to eq("Food Production")
    end
  end
end
