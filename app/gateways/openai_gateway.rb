class OpenAIGateway
  def generate_recommendations(params)
    prompt = build_prompt(params)

    response = Faraday.post("https://api.openai.com/v1/chat/completions") do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{Rails.application.credentials.dig(:open_ai, :key)}"
      req.body = {
        model: "gpt-4o-mini",
        messages: [{ role: "user", content: prompt }],
        max_tokens: 300,
        temperature: 0.7
      }.to_json
    end

    if response.status == 200
      api_response = JSON.parse(response.body, symbolize_names: true)
      raw_content = api_response.dig(:choices, 0, :message, :content)
    
      cleaned_content = raw_content.match(/\[.*\]/m)&.to_s if raw_content
      if cleaned_content
        {
          success: true,
          id: api_response[:id],
          data: JSON.parse(cleaned_content)
        }
      else
        { success: false, error: "Unexpected response format from OpenAI." }
      end
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
      Zip: #{params[:zip_code]}, Sunlight: #{params[:sunlight]}, Soil: #{params[:soil_type]},
      Water: #{params[:water_needs]}, Purpose: #{params[:purpose]}.
      ONLY return a JSON array where each element has the following keys:
      - name: the plant's name
      - description: a brief sentence about why this plant is suitable
      - image: a URL to a real example image of the plant.
      Do NOT include any additional text or explanation.
    "
  end
end
