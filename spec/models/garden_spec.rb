require 'rails_helper'

RSpec.describe Garden, type: :model do
  it { should have_many(:garden_plants).dependent(:destroy) }
  it { should have_many(:plants).through(:garden_plants) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:zip_code) }
  it { should validate_presence_of(:sunlight) }
  it { should validate_presence_of(:soil_type) }
  it { should validate_presence_of(:water_needs) }
  it { should validate_presence_of(:purpose) }
end
