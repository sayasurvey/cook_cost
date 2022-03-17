Rails.application.routes.draw do
  post 'recipes/scrape'
  get 'categories/populer_menu', to: 'categories#populer_menu'

  resources :recipes
  resources :contacts, only: [:new, :create]
  resources :categories
  root to: 'recipes#about'
  
  post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
  post 'contacts/back', to: 'contacts#back', as: 'back'
  get 'done', to: 'contacts#done', as: 'done'
end
