class Garden < ApplicationRecord
  has_many :garden_plants, dependent: :destroy
  has_many :plants, through: :garden_plants

  validates :name, :zip_code, :sunlight, :soil_type, :water_needs, :purpose, presence: true
end
