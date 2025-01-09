require 'rails_helper'

RSpec.describe GardenPlant, type: :model do
  it { should belong_to(:garden) }
  it { should belong_to(:plant) }
end
