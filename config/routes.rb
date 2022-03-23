Rails.application.routes.draw do
  get 'oauths/oauth'
  get 'oauths/callback'
  post 'recipes/scrape'

  resources :recipes do
    resource :bookmarks, only: [:create, :destroy]
  end
  resources :contacts, only: [:new, :create]
  resources :categories
  resources :users, only: %i[new create]
  root to: 'recipes#about'
  
  post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
  post 'contacts/back', to: 'contacts#back', as: 'back'
  get 'done', to: 'contacts#done', as: 'done'
  get 'food_costs/output', to: 'food_costs#output'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
end
