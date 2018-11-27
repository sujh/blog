Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  constraints subdomain: Settings.admin_subdomain do
    get 'sign', to: 'sessions#new'
    resource :session, only: [:create, :delete]

    resources :posts
  end

end
