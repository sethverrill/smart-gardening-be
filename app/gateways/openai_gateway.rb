class OpenAIGateway
  def generate_recommendations(params)
    prompt = build_prompt(params)

    response = Faraday.post("https://api.openai.com/v1/chat/completions") do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{ENV['OPENAI_API_KEY']}"
      req.body = {
        model: "gpt-4o-mini",
        messages: [{ role: "user", content: prompt }],
        max_tokens: 300,
        temperature: 0.7
      }.to_json
    end

    if response.status == 200
      api_response = JSON.parse(response.body, symbolize_names: true)
      {
        success: true,
        id: api_response[:id],
        data: JSON.parse(api_response[:choices][0][:message][:content])
      }
    else
      { success: false, error: "Failed to fetch plant recommendations." }
    end
  rescue => error
    { success: false, error: "An error occurred: #{error.message}" }
  end

  private

  def build_prompt(params)
    "
      Suggest 2-3 plants for a garden based on these criteria:
      Zip: #{params[:zip]}, Sunlight: #{params[:sunlight]}, Soil: #{params[:soil_type]},
      Water: #{params[:water_needs]}, Purpose: #{params[:purpose]}.
      Return JSON with the following structure:
      [
        {
          \"name\": \"Plant Name\",
          \"description\": \"Brief sentence about why this plant is suitable.\",
          \"image\": \"URL to a real example image of the plant\"
        }
      ]
    "
  end
end
