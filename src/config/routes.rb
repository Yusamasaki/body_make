Rails.application.routes.draw do
  devise_scope :user do
    root to: "users/sessions#new"
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
  resources :users, only: [:show, :index]
  resources :users do
    get 'setting'
    get 'bodyweights/calender'
    get 'todaymeals/analysis'
    get 'myfoods/api_new'
    post 'myfoods/api_create'
    get 'detail'
    resources :bodyweights, only: [:edit, :update] do
      get 'bodyfat_percentage_edit'
      patch 'bodyfat_percentage_update'
    end
    resources :targetweights, only: [:new, :create, :edit, :update]
    resources :bmrs, only: [:new, :create, :edit, :update]
    resources :pfc_ratios, only: [:new, :create, :edit, :update]
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
end
