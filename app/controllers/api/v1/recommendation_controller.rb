class Api::V1::RecommendationController < ApplicationController
  require_relative '../../../gateways/openai_gateway'
  require_relative '../../../gateways/google_search_gateway'

  def index
    if params[:zip_code].blank?
      render json: ErrorSerializer.format_errors("Zip code is required."), status: :bad_request
      return
    end

    processed_params = RecommendationParamsProcessor.new(params).process

    api_response = OpenaiGateway.new.generate_recommendations(processed_params)

    if api_response[:success]
      enriched_data = GoogleSearchGateway.new.enrich_with_google_data(api_response[:data])
      render json: RecommendationSerializer.format_recommendations(enriched_data, api_response[:id]), status: 200
    else
      render json: ErrorSerializer.format_errors(api_response[:error]), status: :internal_server_error
    end
  end
end
