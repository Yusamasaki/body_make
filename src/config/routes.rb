Rails.application.routes.draw do
  get 'pfc_ratio/new'
  get 'pfc_ratio/edit'
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

    get 'setting'
    
    get 'bodyweights/calender'
    
    resources :bodyweights, only: [:create, :edit, :update]
    resources :targetweights, only: [:new, :create, :edit, :update]
    resources :bmrs, only: [:new, :create, :edit, :update]
  end

  resources :today_exercises

  resources :exercise_categories do
    resources :exercise_contents
  end
end
