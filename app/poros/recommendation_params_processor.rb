class RecommendationParamsProcessor
  DEFAULTS = {
    sunlight: "Full Sun",
    soil_type: "Loamy",
    water_needs: "Moderate"
  }.freeze

  def initialize(params)
    @params = params
  end

  def process
    {
      zip: @params[:zip],
      sunlight: process_field(:sunlight),
      soil_type: process_field(:soil_type),
      water_needs: process_field(:water_needs),
      purpose: @params[:purpose]
    }
  end

  private

  def process_field(field)
    @params[field] == "Don't Know" ? DEFAULTS[field] : @params[field]
  end
end
