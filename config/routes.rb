Rails.application.routes.draw do

  constraints subdomain: Settings.super_subdomain do
    namespace :super, path: nil do
      controller :sessions do
        get 'sign' => :new
        post 'sign' => :create
        delete 'sign_out' => :destroy
      end

      resources :posts do
        get :preview, on: :collection
      end

      resources :post_trashes, only: [:index, :destroy] do
        post :renew, on: :member
      end

      resources :post_drafts, only: [:index, :destroy, :edit] do
        post :publish, on: :member
        post :preserve, on: :collection
      end

      resources :tags, only: [:show]
      resource :admin, only: [:edit, :update]
    end
  end

  resources :photos, only: [:create]

  controller :search do
    get 'search' => :index
  end

end
