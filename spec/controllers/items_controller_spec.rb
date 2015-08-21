require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  after(:all) do
    Item.remove_all_from_index!
  end

  describe 'GET index' do
    context 'user sign in' do
      context 'folder parent id is nil' do
        context 'without search' do
          let(:user) { create(:user) }
          let!(:parent) { create(:folder, user: user) }
          let!(:item) { create(:item, user: user) }

          before do
            login(user)
            get :index
          end

          it { expect(assigns(:items)).to include(item) }
          it { expect(assigns(:folders)).to include(parent) }
          it { expect(response).to render_template("index") }
        end

        context 'with search' do
          let(:user) { create(:user) }
          let!(:parent) { create(:folder, user: user) }
          let!(:item) { create(:item, user: user) }

          before do
            login(user)
            get :index, search: item.name
          end

          it { expect(assigns(:items)).to include(item) }
          it { expect(assigns(:folders)).to include(parent) }
          it { expect(response).to render_template("index") }
        end
      end

      context 'folder parent id is not nil' do
        context 'without search' do
          let(:user) { create(:user) }
          let!(:parent) { create(:folder, user: user) }
          let!(:children) { create(:folder, user: user, parent: parent) }
          let!(:item) { create(:item, user: user) }

          before do
            login(user)
            get :index
          end

          it { expect(assigns(:items)).to include(item) }
          it { expect(assigns(:folders).count).to eq(1) }
          it { expect(response).to render_template("index") }
        end

        context 'with search' do
          let(:user) { create(:user) }
          let!(:parent) { create(:folder, user: user) }
          let!(:children) { create(:folder, user: user, parent: parent) }
          let!(:item) { create(:item, user: user) }

          before do
            login(user)
            get :index, search: item.name
          end

          it { expect(assigns(:items)).to include(item) }
          it { expect(assigns(:folders).count).to eq(1) }
          it { expect(response).to render_template("index") }
        end
      end
    end

    context 'user sign out' do
      before { get :index }
      it { expect(response).to redirect_to(new_session_path) }
    end
  end

  describe 'POST create' do
    context 'user sign in' do
      context 'save in folder' do
        let(:file) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'image.jpeg')) }
        let(:user) { create(:user) }
        let!(:parent) { create(:folder, user: user) }

        context 'valid item' do
          before do
            login(user)
            post :create, item: { folder_id: parent.id }, file: file
          end

          it { expect(flash[:notice]).to eq('Файл(и) успішно завантажені') }
          it { expect(response).to have_text(' ') }
        end

        context 'invalid item' do
          before do
            login(user)
            post :create, item: { folder_id: parent.id }
          end

          it { expect(flash[:error]).to eq('Сталася помилка') }
          it { expect(response).to have_text(' ') }
        end
      end

      context 'save if root path' do
        let(:file) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'image.jpeg')) }
        let(:user) { create(:user) }
        let!(:parent) { create(:folder, user: user) }

        context 'valid item' do
          before do
            login(user)
            post :create, item: {}, file: file
          end

          it { expect(flash[:notice]).to eq('Файл(и) успішно завантажені') }
          it { expect(response).to have_text(' ') }
        end

        context 'invalid item' do
          before do
            login(user)
            post :create, item: {}
          end

          it { expect(flash[:error]).to eq('Сталася помилка') }
          it { expect(response).to have_text(' ') }
        end
      end
    end

    context 'user sign out' do
      before { post :create }
      it { expect(response).to redirect_to(new_session_path) }
    end
  end

  describe 'DELETE destroy' do
    context 'user sign in' do
      let(:user) { create(:user) }

      context 'item was found' do
        let(:item) { create(:item, user: user) }

        before do
          login(user)
          request.env["HTTP_REFERER"] = 'http://test.host/'
          delete :destroy, format: :js, id: item.id
        end

        it { expect(Item.count).to eq(0) }
        it { expect(flash[:notice]).to eq('Файл успішно видалений') }
      end
    end

    context 'user sign out' do
      let(:item) { create(:item, user: nil) }
      before { delete :destroy, id: item.id }
      it { expect(response).to redirect_to(new_session_path) }
    end
  end

  describe 'GET download' do
    context 'correct params' do
      let(:user) { create(:user) }
      let(:item) { create(:item, user: user) }

      before do
        get :download, user_id: user, id: item.token
      end

      it { expect(@controller).to receive(:send_file).with(item.file.path) }
    end

    context 'uncorrect params' do
      let(:user) { create(:user) }
      let!(:item) { create(:item, user: user) }

      before do
        get :download
      end

      it { expect(response).to redirect_to(root_path) }
    end
  end

  describe 'GET download_my' do
    context 'user sign in' do
      let(:user) { create(:user) }
      let!(:item) { create(:item, user: user) }

      before do
        login(user)
        get :download_my, item_id: item
      end

      it { expect(@controller).to receive(:send_file).with(item.file.path) }
    end

    context 'user sign out' do
      let(:item) { create(:item, user: nil) }
      before { get :download_my, item_id: item }
      it { expect(response).to redirect_to(new_session_path) }
    end
  end
end
