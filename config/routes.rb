Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get 'public_recipes', to: 'recipes#public_recipes'
  get 'general_shopping_list', to: 'recipes#general_shopping_list'
  # Defines the root path route ("/")
  root "recipes#index"
  resources :foods

  resources :recipes do
    resources :recipe_foods, only: [:new, :create, :destroy]
  end
end
