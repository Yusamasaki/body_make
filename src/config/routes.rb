Rails.application.routes.draw do
  
  get 'exercise_contents/new'
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
  
  resources :exercise_categories do
    resources :exercise_contents
  end
end
