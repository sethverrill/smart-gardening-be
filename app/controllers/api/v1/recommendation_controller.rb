class Api::V1::RecommendationController < ApplicationController
  require_relative '../../../gateways/openai_gateway'

  def index
    if params[:zip_code].blank?
      render json: { error: "Zip code is required." }, status: 400
      return
    end

    processed_params = RecommendationParamsProcessor.new(params).process

    if Rails.env.test? || Rails.env.development?
      mock_response = File.read("spec/fixtures/recommendation_stubbed_response.json")
      api_response = JSON.parse(mock_response, symbolize_names: true)
      render json: RecommendationSerializer.format_recommendations(api_response[:data], api_response[:id]), status: 200
      return
    end

    api_response = OpenaiGateway.new.generate_recommendations(processed_params)

    render json: RecommendationSerializer.format_recommendations(api_response[:data], api_response[:id]), status: 200
  end
end