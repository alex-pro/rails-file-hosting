Rails.application.routes.draw do
  resources :users, only: [:new, :create] do
    resources :items, only: :show
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :items do
    get :download, on: :collection
    get :download_my
  end
  resources :folders
  root to: 'items#index'
end
