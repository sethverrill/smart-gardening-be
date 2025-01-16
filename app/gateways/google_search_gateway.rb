class GoogleSearchGateway
  BASE_URL = "https://www.googleapis.com/customsearch/v1"
  DEFAULT_SEARCH_TYPE = "image"
  DEFAULT_RESULTS_COUNT = 1

  def initialize(
    api_key: Rails.application.credentials.dig(:google_api, :key),
    search_engine_id: Rails.application.credentials.dig(:google_api, :search_engine_id)
  )
    @api_key = api_key
    @search_engine_id = search_engine_id
  end

  def enrich_with_google_data(plant_data)
    plant_data.map do |plant|
      if plant[:name].present? || plant["name"].present?
        google_data = fetch_google_data(plant[:name] || plant["name"])
        plant.merge(google_data) if google_data
      else
        plant
      end
    end
  end
  
  private

  def fetch_google_data(query)
    response = Faraday.get(BASE_URL, request_params(query))
    handle_response(response)
  rescue StandardError => error
    nil
  end

  def request_params(query)
    {
      key: @api_key,
      cx: @search_engine_id,
      q: query,
      searchType: DEFAULT_SEARCH_TYPE,
      num: DEFAULT_RESULTS_COUNT
    }
  end

  def handle_response(response)
    return unless response.status == 200

    results = JSON.parse(response.body, symbolize_names: true)
    first_result = results.dig(:items, 0)
    return unless first_result

    {
      image: first_result[:link],
      title: first_result[:title],
      snippet: first_result[:snippet],
      context_link: first_result.dig(:image, :contextLink)
    }
  end
end
