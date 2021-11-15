Rails.application.routes.draw do
  get 'rentals/new'
  root to: 'bikes#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :bike, only: [:new, :create, :show] do
    resources :rentals, only: [:new, :create]
  end
end
