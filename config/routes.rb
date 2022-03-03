Rails.application.routes.draw do
  resources :recipes
  resource :synonyms, :create
  root to: 'recipes#about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
