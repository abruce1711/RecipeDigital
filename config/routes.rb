Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'recipes#index'
  get '/create_recipe', to: 'recipes#new'
  resources :recipes
  resources :ingredients
  resources :steps

end
