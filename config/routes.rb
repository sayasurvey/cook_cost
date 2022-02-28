Rails.application.routes.draw do
  resources :recipes
  root to: 'recipes#about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
