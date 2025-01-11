class RecommendationSerializer


  def self.format_recommendations(recommendations)
    {
    data: 
    recommendations.map do |recommendation|
      {
        id: recommendation[:id],
        type: "plant",
        attributes: {
          name: recommendation[:attributes][:name],
          short_description: recommendation[:attributes][:short_description],
          img_url: recommendation[:attributes][:img_url]
        }
      }
    end
  }
  end
end