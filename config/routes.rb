Rails.application.routes.draw do
  resources :recipes
  resource :synonyms, :create
  root to: 'recipes#about'
  
  post 'recipes/scrape'
end
