require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_length_of(:email).is_at_most(255) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should have_many(:folders).dependent :destroy }
  it { should have_many(:items).dependent :destroy }

  describe 'valid email' do
    subject { User.create(email: 'email') }

    it { expect(subject.errors[:email]).to include(' не дійсний') }
  end
end
