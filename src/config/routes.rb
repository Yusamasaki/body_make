Rails.application.routes.draw do
  
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
    get 'today_tranings/traning_new'
    get 'today_tranings/traning_analysis'
    
    resources :bodyweights, only: [:create, :edit, :update]

    resources :targetweights, only: [:new, :create, :edit, :update]
    resources :bmrs, only: [:new, :create, :edit, :update]
    resources :pfc_ratios, only: [:new, :create, :edit, :update]
    
    resources :traningevents
    resources :today_tranings, only: [:index, :show, :create, :update, :destroy]
    resources :today_exercises do
      collection do
        get :new_contents
        get :edit_contents
      end
    end

  end

  resources :exercise_categories do
    resources :exercise_contents
  end
end
