class Plant < ApplicationRecord
  has_many :garden_plants, dependent: :destroy
  has_many :gardens, through: :garden_plants

  validates :img_url, :description, presence: true
  validates :name, uniqueness: true, presence: true
end
