Rails.application.routes.draw do
  resources :recipes
  resource :synonyms, :create
  resources :contacts, only: [:new, :create]
  root to: 'recipes#about'
  
  post 'recipes/scrape'
  post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
  post 'contacts/back', to: 'contacts#back', as: 'back'
  get 'done', to: 'contacts#done', as: 'done'
end
