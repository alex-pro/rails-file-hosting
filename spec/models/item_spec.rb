require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:folder) }

  describe 'item name' do
    let(:item) { create(:item) }
    it { expect(item.name).to_not be_nil }
  end

  describe 'item token' do
    let(:item) { create(:item) }
    it { expect(item.token).to_not be_nil }
  end
end
