Rails.application.routes.draw do

  constraints subdomain: Settings.super_subdomain do
    namespace :super, path: nil do
      controller :sessions do
        get 'sign' => :new
        post 'sign' => :create
        delete 'sign_out' => :destroy
      end

      resources :posts do
        post :preview, on: :collection
      end
    end
  end

end
