Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :bikes do
    resources :rentals, except: :index
  end
  get "/dashboard", to: 'pages#dashboard', as: 'dashboard'
end
