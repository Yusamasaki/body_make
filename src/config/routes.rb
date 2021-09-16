Rails.application.routes.draw do
  get 'today_exercises/new'
  root to: 'staticpages#top'

  devise_for :users,
    controllers: {
      sessions: 'users/sessions',
      registrations: "users/registrations",
      omniauth_callbacks: 'users/omniauth_callbacks'
    }
  
  devise_for :admins,
    controllers: {
      sessions: 'admins/sessions',
      registrations: "admins/registrations",
    }
  
  resources :admins, only: [:show]
  resources :users, only: [:show] do
    
    get 'bodyweights/calender'
    
    resources :bodyweights, only: [:create, :edit, :update]
    resources :targetweights, only: [:new, :create, :edit, :update]
    resources :bmrs, only: [:new, :create, :edit, :update]
    
    resources :today_exercises
  end

  resources :exercise_categories do
    resources :exercise_contents
  end
end
