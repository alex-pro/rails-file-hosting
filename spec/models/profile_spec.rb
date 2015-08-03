require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { should validate_length_of(:name).is_at_most(60) }
  it { should validate_presence_of(:birthday) }
  it { should have_many(:addresses).dependent :destroy }
  it { should belong_to(:user) }
end
