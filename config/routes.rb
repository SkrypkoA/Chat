Rails.application.routes.draw do

  get 'conversations/index'

  get 'conversations/show'

  get 'conversations/create'

  get 'user_categories/create'

  get 'user_categories/destroy'

  get 'events/index'
  get 'comments/index'
  root 'pictures#index'

  resources :categories do
    get '/:id', to: 'pictures#show', as: "picture"
    match 'delete_relation', to: 'categories#delete_relation', on: :member, via: :delete
    match 'create_relation', to: 'categories#create_relation', on: :member, via: :post
  end

  resources :pictures, only: [:index, :show, :create] do
    resources :comments, only: [:index, :create]
    resources :likes, only: [:create, :destroy]
  end

  resources :messages, only: [:index]

  resources :conversations, only: [:create, :show, :show_partial] do
    match 'show_partial', to: 'conversations#show_partial', on: :member, via: :get
  end

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      omniauth_callbacks: "users/omniauth_callbacks"
  }

  mount ActionCable.server => '/cable'
end
