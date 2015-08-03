require 'rails_helper'

RSpec.describe Address, type: :model do
  it { should validate_length_of(:country).is_at_most(25) }
  it { should validate_length_of(:city).is_at_most(25) }
  it { should validate_length_of(:street).is_at_most(30) }
  it { should validate_length_of(:house_number).is_at_most(10) }
  it { should belong_to(:profile) }
end
