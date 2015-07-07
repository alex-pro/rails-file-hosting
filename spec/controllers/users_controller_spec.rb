require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET new' do
    context 'user sign out' do
      before { get :new }
      it { expect(assigns(:user)).to_not be_nil }
    end

    context 'user sign in' do
      let(:user) { FactoryGirl.create(:user) }

      before do
        login(user)
        get :new
      end

      it { expect(response).to redirect_to(root_path) }
    end
  end

  describe 'POST create' do
    context 'user sign out' do
      context 'valid params' do
        before { post :create, user: { email: 'test@example.com', password: 'password' }}
        it { expect(flash[:notice]).to eq('Користувач успішно створений') }
        it { expect(response).to redirect_to(root_path) }
      end

      context 'invalid params' do
        before { post :create, user: { email: '', password: 'password' } }
        it { expect(response).to render_template(:new) }
      end
    end

    context 'user sign in' do
      let(:user) { FactoryGirl.create(:user) }
      before do
        login(user)
        post :create
      end

      it { expect(response).to redirect_to(root_path) }
    end
  end

end
