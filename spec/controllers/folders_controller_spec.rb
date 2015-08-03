require 'rails_helper'

RSpec.describe FoldersController, type: :controller do
  describe 'POST create' do
    let(:user) { create(:user) }

    context 'user sign in' do
      before do
        login(user)
        request.env["HTTP_REFERER"] = 'http://test.host/'
        post :create
      end

      it { expect(Folder.count).to eq(1) }
      it { expect(response).to redirect_to(:back) }
    end

    context 'user sign out' do
      before { post :create }
      it { expect(response).to redirect_to(new_session_path) }
    end
  end

  describe 'GET show' do
    let(:folder) { create(:folder) }

    context 'user sign in' do
      before do
        login(folder.user)
        get :show,  id: folder.id
      end
      it { expect(response).to render_template(:show) }
    end

    context 'user sign out' do
      before { get :show, id: folder.id }
      it { expect(response).to redirect_to(new_session_path) }
    end
  end

  describe 'PUT update' do
    let(:folder) { create(:folder) }
    context 'user sign in' do
      context 'valid params' do
        before do
          login(folder.user)
          request.env["HTTP_REFERER"] = 'http://test.host/'
          put :update, id: folder.id, name: 'folder'
        end
        it { expect(response).to redirect_to(:back) }
        it { expect(flash[:notice]).to eq('Тека успішно перейменована') }
      end

      context 'invalid params' do
        before do
          login(folder.user)
          request.env["HTTP_REFERER"] = 'http://test.host/'
          put :update, id: folder.id, name: ''
        end
        it { expect(response).to redirect_to(:back) }
        it { expect(flash[:error]).to eq('Теку не вдалося перейменувати') }
      end
    end

    context 'user sign out' do
      before { put :update, id: folder.id }
      it { expect(response).to redirect_to(new_session_path) }
    end
  end

  describe 'DELETE destroy' do
    let(:folder) { create(:folder) }
    context 'user sign in' do
      before do
        login(folder.user)
        request.env["HTTP_REFERER"] = 'http://test.host/'
        delete :destroy, id: folder.id
      end
      it { expect(response).to redirect_to(:back) }
      it { expect(Folder.count).to eq(0) }
      it { expect(flash[:notice]).to eq('Тека успішно видалена') }
    end

    context 'user sign out' do
      before { delete :destroy, id: folder.id }
      it { expect(response).to redirect_to(new_session_path) }
    end
  end
end
