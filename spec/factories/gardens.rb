FactoryBot.define do
  factory :garden do
    name { "Test Garden" }
    zip_code { "80555" }
    sunlight { "Full Sun" }
    soil_type { "Loam"}
    water_needs { "High" }
    purpose { "Edible" }
  end
end