require 'rails_helper'

RSpec.describe Plant, type: :model do
  it { should have_many(:garden_plants).dependent(:destroy) }
  it { should have_many(:gardens).through(:garden_plants) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:img_url) }
  it { should validate_presence_of(:description) }
end
