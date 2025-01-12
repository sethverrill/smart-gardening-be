class RecommendationSerializer
  def self.format_recommendations(recommendations, response_id)
    {
      id: response_id,
      data: recommendations.map.with_index(1) do |recommendation, index|
        {
          index: index,
          type: "plant",
          attributes: {
            name: recommendation[:name],
            description: recommendation[:description],
            image: recommendation[:image]
          }
        }
      end
    }
  end
end
