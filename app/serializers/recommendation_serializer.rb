class RecommendationSerializer
  include JSONAPI::RecommendationSerializer
  attributes :name, :short_description, :img_url
end