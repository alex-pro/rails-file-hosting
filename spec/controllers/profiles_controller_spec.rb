require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  describe 'GET edit' do
    let(:profile) { create(:profile) }

    context 'user sign in' do
      before do
        login(profile.user)
        get :edit,  id: profile.id
      end

      it { expect(response).to render_template(:edit) }
    end

    context 'user sign out' do
      before { get :edit, id: profile.id }
      it { expect(response).to redirect_to(new_session_path) }
    end
  end

  describe 'PUT update' do
    let(:user) { create(:user) }
    let!(:profile) { create(:profile, user: user) }

    context 'user sign in' do
      context 'valid params' do
        before do
          login(user)
          request.env["HTTP_REFERER"] = 'http://test.host/'
          put :update, id: profile.id, profile: { name: profile.name, photo: profile.photo, birthday: profile.birthday}
        end

        it { expect(response).to redirect_to(:back) }
        it { expect(flash[:notice]).to eq('Профіль успішно оновлений') }
      end

      context 'invalid params' do
        before do
          login(user)
          request.env["HTTP_REFERER"] = 'http://test.host/'
          put :update, id: profile.id, profile: { birthday: '' }
        end

        it { expect(response).to redirect_to(:back) }
        it { expect(flash[:error]).to eq('Профіль не вдалося оновити') }
      end
    end

    context 'user sign out' do
      before { put :update, id: profile.id }
      it { expect(response).to redirect_to(new_session_path) }
    end
  end
end
