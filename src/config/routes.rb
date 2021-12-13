Rails.application.routes.draw do
  
  devise_scope :user do
    root :to => "devise/sessions#new"
  end

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
  resources :users, only: [:show, :index] do

    get 'setting'
    get 'bodyweights/calender'
    get 'today_tranings/traning_new'
    get 'today_tranings/traning_analysis'
    get 'today_tranings/chart'
    get 'today_tranings/chart_traningevent'
    
    get 'todaymeals/analysis'
    
    get 'myfoods/api_new'
    post 'myfoods/api_create'
    
    resources :bodyweights, only: [:edit, :update]

    resources :targetweights, only: [:new, :create, :edit, :update]
    resources :bmrs, only: [:new, :create, :edit, :update]
    resources :pfc_ratios, only: [:new, :create, :edit, :update]
    
    resources :traningevents
    resources :today_tranings, only: [:index, :create, :update, :destroy]
    resources :today_exercises do
      get 'calender'
      # collection do
      #   get :new_contents
      #   get :edit_contents
      # end
    end
    
    resources :todaymeals
    resources :todaymeal_recipes
    resources :recipes
    resources :recipefoods
    resources :myfoods do
      collection {post :import}
    end
    resources :apifoods, only: [:index]
    resources :meals_analysis
    

  end

  resources :exercise_categories do
    resources :exercise_contents
  end
end
