Rails.application.routes.draw do
  root 'sessions#new'

  # User routes
  resources :users, only: [:new, :create, :edit, :show, :index, :update] do
    resources :comments, only: [:index, :new,:create], controller: 'comments'  # Comments on profiles
  end

  # Session routes (login/logout)
  resource :session, only: [:new, :create, :destroy]
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  # Post routes
  resources :posts do
    resources :comments, only: [:create, :index]  # Comments for posts (listing + creating)
  end

  # To reply to comments
  post 'comments/:id/reply', to: 'comments#reply', as: 'reply_comment'
end
