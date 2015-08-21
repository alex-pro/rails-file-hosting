require "rails_helper"

RSpec.describe ApplicationHelper, :type => :helper do
  let(:item) { create(:item) }

  describe "check_render_file" do
    context 'image' do
      let(:tag) { "<a id=\"gallery\" href=\"/uploads/item/file/#{item.id}/image.jpeg\"><img alt=\"image.jpeg\" src=\"/uploads/item/file/#{item.id}/image.jpeg\" /></a>" }
      before { item.file.stub(:content_type).and_return('image') }

      it { expect(helper.check_render_file(item)).to eq(tag) }
    end

    context 'audio' do
      let(:tag) { "<a class=\"mfp-iframe\" id=\"gallery\" href=\"/uploads/item/file/#{item.id}/image.jpeg\"><img alt=\"image.jpeg\" src=\"/assets/audio.png\" /></a>" }
      before { item.file.stub(:content_type).and_return('audio') }

      it { expect(helper.check_render_file(item)).to eq(tag) }
    end

    context 'video' do
      let(:tag) { "<a class=\"mfp-iframe\" id=\"gallery\" href=\"/uploads/item/file/#{item.id}/image.jpeg\"><img alt=\"image.jpeg\" src=\"/assets/video.png\" /></a>" }
      before { item.file.stub(:content_type).and_return('video') }

      it { expect(helper.check_render_file(item)).to eq(tag) }
    end

    context 'doc' do
      let(:tag) { "<a id=\"gallery\" href=\"\"><img alt=\"image.jpeg\" src=\"/assets/doc.png\" /></a>" }
      before { item.file.stub(:content_type).and_return('doc') }

      it { expect(helper.check_render_file(item)).to eq(tag) }
    end
  end
end
