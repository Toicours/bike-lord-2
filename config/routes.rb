Rails.application.routes.draw do
  devise_for :users
  root to: 'bikes#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :bikes, except: :index do
    resources :rentals, only: [:new, :create]
  end
  get "/dashboard", to: 'pages#dashboard'
end
