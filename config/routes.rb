Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "recipes#index"

  get '/create_recipe', to: 'recipes#new'
  get 'login', to: 'devise/sessions#new'
  get 'my_recipes', to: 'recipes#my_recipes'
  resources :recipes
  resources :ingredients
  resources :steps


end
