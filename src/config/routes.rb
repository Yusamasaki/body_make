Rails.application.routes.draw do
  
  root to: 'staticpages#top'
  get 'homes/show'

  devise_for :users,
    controllers: {
      sessions: 'users/sessions',
      registrations: "users/registrations",
      omniauth_callbacks: 'users/omniauth_callbacks'
    }

  resources :users do
  end


end
