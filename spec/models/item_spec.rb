require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:folder) }

  let(:item) { create(:item) }

  describe "check_file" do
    context 'item is image' do
      before { item.file.stub(:content_type).and_return('image') }
      it { expect(item.image?).to eq(true) }
    end

    context 'audio' do
      before { item.file.stub(:content_type).and_return('audio') }
      it { expect(item.audio?).to eq(true) }
    end

    context 'video' do
      before { item.file.stub(:content_type).and_return('video') }
      it { expect(item.video?).to eq(true) }
    end
  end

  describe 'item name' do
    it { expect(item.name).to_not be_nil }
  end

  describe 'item token' do
    it { expect(item.token).to_not be_nil }
  end
end
