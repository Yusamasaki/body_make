Rails.application.routes.draw do
  
  get 'bodyweights/index'
  get 'bodyweights/new'
  get 'bodyweights/create'
  get 'bodyweights/show'
  get 'bodyweights/update'
  get 'bodyweights/destroy'
  root to: 'staticpages#top'

  devise_for :users,
    controllers: {
      sessions: 'users/sessions',
      registrations: "users/registrations",
      omniauth_callbacks: 'users/omniauth_callbacks'
    }
  devise_for :admin,
    controllers: {
      sessions: 'admins/sessions',
      registrations: "admins/registrations",
    }

  resources :users, only: [:show]
  resources :admins, only: [:show]
end
